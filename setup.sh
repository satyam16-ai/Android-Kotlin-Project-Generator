#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo -e "${BLUE}════════════════════════════════════${NC}"
echo -e "${BLUE}  Android Kotlin Auto Setup${NC}"
echo -e "${BLUE}════════════════════════════════════${NC}"
echo -e "${YELLOW}Working directory: $SCRIPT_DIR${NC}"
echo -e "${YELLOW}Operating System: $MACHINE${NC}"
echo ""

# Function to print status
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

# 1. Check/Install Java
print_info "Checking Java installation..."
if ! command -v java &> /dev/null; then
    print_info "Installing Java 17..."
    if [ "$MACHINE" = "Mac" ]; then
        brew install openjdk@17
        export JAVA_HOME=$(/usr/libexec/java_home -v 17)
    else
        sudo apt update -qq
        sudo apt install -y openjdk-17-jdk
        export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
    fi
    print_status "Java installed"
else
    print_status "Java already installed: $(java -version 2>&1 | head -n 1)"
fi

# 1.5. Check/Install Kotlin (Optional but recommended)
print_info "Checking Kotlin installation..."
if ! command -v kotlinc &> /dev/null; then
    print_info "Installing Kotlin compiler..."
    if [ "$MACHINE" = "Mac" ]; then
        brew install kotlin
    else
        # Kotlin installation via SDKMAN or direct download
        if command -v sdk &> /dev/null; then
            sdk install kotlin
        else
            print_info "Kotlin compiler not critical for building. Skipping..."
            echo -e "   ${YELLOW}Note: Gradle will use its own Kotlin plugin${NC}"
        fi
    fi
    if command -v kotlinc &> /dev/null; then
        print_status "Kotlin installed: $(kotlinc -version 2>&1 | head -n 1)"
    fi
else
    print_status "Kotlin already installed: $(kotlinc -version 2>&1 | head -n 1)"
fi

# 2. Check/Install Android SDK
if [ "$MACHINE" = "Mac" ]; then
    ANDROID_SDK="$HOME/Library/Android/sdk"
else
    ANDROID_SDK="$HOME/Android/Sdk"
fi

print_info "Checking Android SDK..."

if [ ! -d "$ANDROID_SDK" ]; then
    print_info "Installing Android SDK..."
    mkdir -p "$ANDROID_SDK/cmdline-tools"
    cd "$ANDROID_SDK/cmdline-tools"
    
    # Download appropriate SDK tools for OS
    if [ "$MACHINE" = "Mac" ]; then
        wget -q --show-progress https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip
        unzip -q commandlinetools-mac-11076708_latest.zip
        rm commandlinetools-mac-11076708_latest.zip
    else
        wget -q --show-progress https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
        unzip -q commandlinetools-linux-11076708_latest.zip
        rm commandlinetools-linux-11076708_latest.zip
    fi
    
    mv cmdline-tools latest
    
    export ANDROID_HOME="$ANDROID_SDK"
    export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
    
    # Accept licenses and install SDK components
    yes | sdkmanager --licenses > /dev/null 2>&1
    
    if sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" > /dev/null 2>&1; then
        print_status "Android SDK installed"
    else
        print_error "SDK Manager failed. Please install Android SDK manually."
        echo -e "   ${YELLOW}Download from: https://developer.android.com/studio${NC}"
        exit 1
    fi
else
    print_status "Android SDK already installed"
    export ANDROID_HOME="$ANDROID_SDK"
    export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
fi

# Return to script directory
cd "$SCRIPT_DIR"

# 3. Create local.properties
echo "sdk.dir=$ANDROID_SDK" > local.properties
print_status "SDK configuration created"

# 4. Install ADB if not present
print_info "Checking ADB..."
if ! command -v adb &> /dev/null; then
    print_info "Installing ADB..."
    if [ "$MACHINE" = "Mac" ]; then
        brew install android-platform-tools
    else
        sudo apt install -y android-tools-adb android-tools-fastboot
    fi
    print_status "ADB installed"
else
    print_status "ADB already installed"
fi

# 4.5. Check Gradle Wrapper
print_info "Checking Gradle wrapper..."
if [ ! -f "./gradlew" ]; then
    print_info "Gradle wrapper not found, downloading and creating..."
    
    # Create temp directory
    GRADLE_TMP=$(mktemp -d)
    cd "$GRADLE_TMP"
    
    # Download Gradle
    print_info "Downloading Gradle 8.12..."
    wget -q https://services.gradle.org/distributions/gradle-8.12-bin.zip
    unzip -q gradle-8.12-bin.zip
    
    # Go back to project
    cd - > /dev/null
    
    # Create wrapper
    "$GRADLE_TMP/gradle-8.12/bin/gradle" wrapper --gradle-version 8.12
    chmod +x gradlew
    
    # Cleanup
    rm -rf "$GRADLE_TMP"
    
    print_status "Gradle wrapper created"
else
    print_status "Gradle wrapper found"
    chmod +x gradlew
fi

# 5. Build the project
echo ""
print_info "Building Android app..."
./gradlew clean assembleDebug 2>&1 | tee build.log | grep -E "BUILD|FAILURE|error" || true

if [ ${PIPESTATUS[0]} -eq 0 ]; then
    print_status "App built successfully!"
    APK_SIZE=$(du -h app/build/outputs/apk/debug/app-debug.apk | cut -f1)
    echo -e "   ${GREEN}APK Size: $APK_SIZE${NC}"
    echo -e "   ${GREEN}Location: app/build/outputs/apk/debug/app-debug.apk${NC}"
    echo -e "   ${YELLOW}Build log saved to: build.log${NC}"
else
    print_error "Build failed. Check build.log for details"
    echo -e "   ${YELLOW}Log file: $SCRIPT_DIR/build.log${NC}"
    exit 1
fi

# 6. Check for device and install
echo ""
print_info "Checking for connected device..."
adb devices | grep -w "device$" > /dev/null

if [ $? -eq 0 ]; then
    DEVICE=$(adb devices | grep -w "device" | awk '{print $1}')
    print_status "Device found: $DEVICE"
    
    print_info "Installing app on device..."
    ./gradlew installDebug --quiet
    
    if [ $? -eq 0 ]; then
        print_status "App installed successfully!"
        echo ""
        echo -e "${GREEN}════════════════════════════════${NC}"
        echo -e "${GREEN}     🎉 SETUP COMPLETE! 🎉${NC}"
        echo -e "${GREEN}════════════════════════════════${NC}"
        echo ""
        echo -e "${BLUE}Launch 'MyApplication' from your phone!${NC}"
        echo ""
    else
        print_error "Installation failed. Please check:"
        echo "   1. USB Debugging is enabled"
        echo "   2. 'Install via USB' is enabled (Settings → Developer Options)"
        echo "   3. Run: adb devices"
        echo ""
        echo -e "${YELLOW}Manual installation:${NC}"
        echo "   adb install -r app/build/outputs/apk/debug/app-debug.apk"
    fi
else
    print_error "No device connected"
    echo ""
    echo -e "${YELLOW}To install on a physical device:${NC}"
    echo "   1. Connect phone via USB/OTG"
    echo "   2. Enable USB Debugging"
    echo "   3. Enable 'Install via USB' (for Xiaomi/Redmi)"
    echo "   4. Run: ./gradlew installDebug"
    echo ""
    echo -e "${YELLOW}Or use an emulator:${NC}"
    echo "   1. Install Android Studio"
    echo "   2. Create an AVD (Android Virtual Device)"
    echo "   3. Start the emulator"
    echo "   4. Run: ./gradlew installDebug"
    echo ""
    echo -e "${BLUE}APK built at: app/build/outputs/apk/debug/app-debug.apk${NC}"
fi

# 7. Add environment variables to shell config
SHELL_CONFIG=""
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
fi

if [ ! -z "$SHELL_CONFIG" ]; then
    if ! grep -q "ANDROID_HOME" "$SHELL_CONFIG"; then
        echo "" >> "$SHELL_CONFIG"
        echo "# Android SDK" >> "$SHELL_CONFIG"
        echo "export ANDROID_HOME=$ANDROID_SDK" >> "$SHELL_CONFIG"
        echo "export PATH=\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/platform-tools:\$PATH" >> "$SHELL_CONFIG"
        print_status "Environment variables added to $SHELL_CONFIG"
    fi
fi

# 8. Optional: Install VS Code Extensions
echo ""
print_info "VS Code Extensions (Optional)..."
if command -v code &> /dev/null; then
    read -p "Install VS Code Kotlin & Java extensions? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installing VS Code extensions..."
        code --install-extension mathiasfrohlich.kotlin 2>/dev/null
        code --install-extension vscjava.vscode-java-pack 2>/dev/null
        code --install-extension redhat.java 2>/dev/null
        print_status "VS Code extensions installed"
    else
        echo -e "   ${YELLOW}Skipped VS Code extensions${NC}"
    fi
else
    echo -e "   ${YELLOW}VS Code not found. Skipping extensions.${NC}"
fi

echo ""
print_info "Quick commands:"
echo "   Build:   ./gradlew assembleDebug"
echo "   Install: ./gradlew installDebug"
echo "   Clean:   ./gradlew clean"
echo "   Logs:    cat build.log"
echo ""

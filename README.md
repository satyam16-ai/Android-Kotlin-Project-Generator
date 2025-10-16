# 🚀 Android Kotlin Project Generator# MyApplication



**One-command Android app setup with automated build, install, and deployment.**A minimal Android app project using Kotlin, scaffolded for VS Code. No emulator or simulator is included in this setup.



A professional tool to generate ready-to-run Android Kotlin projects with animated splash screens, Material Design, and automatic device installation.## ✅ APK Successfully Built!



[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)**Location:** `app/build/outputs/apk/debug/app-debug.apk` (5.3MB)

[![Kotlin](https://img.shields.io/badge/Kotlin-1.9.0-purple.svg)](https://kotlinlang.org/)

[![Gradle](https://img.shields.io/badge/Gradle-8.12-green.svg)](https://gradle.org/)## 📱 Install on Your Phone

[![Android](https://img.shields.io/badge/Android-5.0%2B-brightgreen.svg)](https://www.android.com/)

### Method 1: Via ADB (USB Debugging)

---1. **Reconnect your phone:**

   - Unplug and replug the OTG cable

## ✨ Features   - Accept USB debugging prompt on phone

   

- 🎯 **Zero Configuration** - One script does everything2. **Check device connection:**

- 📱 **Instant App Generation** - Create unlimited projects with custom names/packages   ```bash

- 🎨 **Animated Splash Screen** - Professional scale/fade animations built-in   adb devices

- 🛠️ **Auto Setup** - Installs JDK, Kotlin, Android SDK, Gradle automatically   ```

- 📲 **Direct Install** - Builds APK and installs to connected device   Should show: `59WKZDLFWKXG8TPR    device`

- 🎭 **Material Design** - Modern UI components included

- 🔄 **Gradle Wrapper** - No global Gradle installation needed3. **Install the APK:**

- 🖥️ **Cross-Platform** - Works on Linux and macOS   ```bash

- 📦 **VS Code Ready** - Kotlin & Java extensions auto-installed   adb install -t app/build/outputs/apk/debug/app-debug.apk

   ```

---

### Method 2: Manual Transfer (If ADB has issues)

## 🎬 Quick Start1. **Transfer APK to phone:**

   ```bash

### Generate Your First App (30 seconds)   adb push app/build/outputs/apk/debug/app-debug.apk /sdcard/Download/

   ```

```bash   

# Clone the repository2. **On your phone:**

git clone https://github.com/yourusername/android-kotlin-generator.git   - Open File Manager

cd android-kotlin-generator   - Go to Downloads folder

   - Tap `app-debug.apk`

# Create a new project   - Allow "Install from Unknown Sources" if prompted

./create-project.sh   - Tap Install

```

### Method 3: Direct File Transfer

**Interactive prompts:**1. Copy `app/build/outputs/apk/debug/app-debug.apk` to your phone via:

```   - USB file transfer

Enter project name: MyAwesomeApp   - Bluetooth

Enter package name: com.mycompany.awesome   - Cloud storage (Google Drive, etc.)

Enter app display name: My Awesome App2. Open the APK file on your phone to install

```

## 🔧 Rebuild the App

**That's it!** 🎉 Your app will be:

- ✅ Generated with complete structureAfter making code changes:

- ✅ Built into APK```bash

- ✅ Installed on connected device./gradlew assembleDebug

- ✅ Ready to launch from your phone```



---## 🐛 Troubleshooting



## 📋 Prerequisites**Device shows "offline":**

- Reconnect USB cable

### Required- Run: `adb kill-server && adb start-server`

- **USB Debugging enabled** on Android device- Check USB debugging is enabled on phone

- **Install via USB enabled** (Settings → Developer Options → Install via USB)

- **Internet connection** (for first-time setup)**Build errors:**

- Run: `./gradlew clean assembleDebug`

### Auto-Installed

The scripts automatically install:## Project Structure

- ☕ Java JDK (if missing)- Kotlin source: `app/src/main/java/com/example/myapplication/MainActivity.kt`

- 🎯 Kotlin compiler- Manifest: `app/src/main/AndroidManifest.xml`

- 🤖 Android SDK & Command-line tools- Gradle build files: `build.gradle`, `app/build.gradle`

- 🔧 Gradle build system
- 📱 ADB (Android Debug Bridge)
- 💻 VS Code extensions (optional)

---

## 🛠️ Usage

### 1️⃣ Create New Project

```bash
./create-project.sh
```

**What it creates:**
```
YourProjectName/
├── app/
│   ├── src/main/
│   │   ├── java/com/your/package/
│   │   │   ├── SplashActivity.kt    # Animated splash
│   │   │   └── MainActivity.kt      # Welcome page
│   │   ├── res/
│   │   │   ├── layout/              # UI layouts
│   │   │   ├── values/              # Colors, strings, styles
│   │   │   └── drawable/            # Icons & graphics
│   │   └── AndroidManifest.xml
│   └── build.gradle
├── gradle/wrapper/
├── build.gradle
├── settings.gradle
├── setup.sh                          # One-command setup
├── gradlew                           # Gradle wrapper
└── README.md
```

### 2️⃣ Build & Install

Navigate to your generated project and run setup:

```bash
cd YourProjectName
./setup.sh                 # Auto setup + build + install
```

**Or use Gradle directly:**
```bash
./gradlew assembleDebug    # Build APK only
./gradlew installDebug     # Build + Install to device
./gradlew clean            # Clean build artifacts
```

### 3️⃣ Launch App

Open your Android device and launch the app from the app drawer! 📱

---

## 🎨 What's Included in Generated Apps

### ✨ Splash Screen
- **Smooth Animations:** Logo scale (0.5→1.0), fade-in, slide-up text
- **Duration:** 2.5 seconds with smooth transitions
- **Theme:** Material fullscreen splash theme
- **Auto-navigation:** Seamless transition to main activity

### 🏠 Main Activity
- **Welcome UI:** Clean Material Design layout
- **Feature List:** Pre-built sections ready to customize
- **Scrollable:** ScrollView for long content
- **Responsive:** Works on all screen sizes

### 🛠️ Tech Stack
- **Language:** Kotlin 1.9.0
- **Min SDK:** 21 (Android 5.0 Lollipop)
- **Target SDK:** 34 (Android 14)
- **Build System:** Gradle 8.12 + Android Gradle Plugin 8.7.3
- **UI Framework:** AndroidX + Material Components 1.9.0
- **Java Compatibility:** Java 8 bytecode (works with JDK 8-25)

---

## 📱 Device Setup Guide

### Enable Developer Options

1. Open **Settings** → **About Phone**
2. Tap **Build Number** 7 times
3. You'll see "You are now a developer!"

### Enable USB Debugging

1. **Settings** → **Developer Options**
2. Enable **USB Debugging**
3. **For Xiaomi/MIUI/Redmi:** Also enable **Install via USB**

### Connect & Verify

```bash
# Check device connection
adb devices

# Expected output:
# List of devices attached
# XXXXXXXXXXXXXX    device
```

💡 **Tip:** If device shows "unauthorized", check your phone for USB debugging authorization prompt.

---

## 🔧 Advanced Usage

### Custom Package Structure

```bash
./create-project.sh
# Package: com.company.product.module
# Creates: app/src/main/java/com/company/product/module/
```

### Build Variants

```bash
./gradlew assembleDebug      # Debug build with debugging enabled
./gradlew assembleRelease    # Release build (requires signing)
```

### Build Tasks

```bash
./gradlew tasks              # List all available tasks
./gradlew clean              # Remove build artifacts
./gradlew clean assembleDebug # Clean + rebuild
```

### View Build Logs

```bash
cat build.log                # Detailed build output
```

---

## 📂 Repository Structure

```
android-kotlin-generator/
├── 📄 create-project.sh       # 🎯 Main generator script
├── 📄 setup.sh                # 🔧 Automated setup script (template)
├── 📄 README.md               # 📖 This documentation
├── 📄 .gitignore              # Git ignore rules
├── 📁 .github/                # GitHub configuration
│   └── copilot-instructions.md
├── 📁 app/                    # 📱 Template Android application
│   ├── build.gradle          # App-level build configuration
│   └── src/main/
│       ├── java/             # Kotlin source files (template)
│       ├── res/              # Resources (layouts, drawables, values)
│       └── AndroidManifest.xml
├── 📄 build.gradle            # Project-level build configuration
├── 📄 settings.gradle         # Gradle project settings
├── 📁 gradle/wrapper/         # Gradle wrapper configuration
│   └── gradle-wrapper.properties
└── 📄 gradlew                 # Gradle wrapper script (Unix/Linux/Mac)
```

---

## 🐛 Troubleshooting

### Build Failed

```bash
# Check Java version
java -version

# Should be JDK 8 or higher

# Re-run setup to install dependencies
./setup.sh
```

### Device Not Found

```bash
# Restart ADB server
adb kill-server
adb start-server
adb devices

# Check USB cable and connection
# Try different USB port
```

### Gradle Wrapper Missing

```bash
# Manually create Gradle wrapper
wget https://services.gradle.org/distributions/gradle-8.12-bin.zip
unzip -q gradle-8.12-bin.zip
./gradle-8.12/bin/gradle wrapper
rm -rf gradle-8.12 gradle-8.12-bin.zip
```

### Installation Failed on Xiaomi/MIUI

**Error:** `INSTALL_FAILED_USER_RESTRICTED`

**Solution:**
1. Settings → Additional Settings → Developer Options
2. Enable **Install via USB**
3. Try installation again

### Kotlin Compiler Not Found

```bash
# Install using SDKMAN (recommended)
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install kotlin

# Or let setup.sh install it automatically
./setup.sh
```

---

## 🎓 Example Projects

### E-commerce App
```bash
./create-project.sh
# Name: ShopEasy
# Package: com.shopify.easyshop
# Display: Shop Easy
```

### Social Media App
```bash
./create-project.sh
# Name: ConnectHub
# Package: com.social.connecthub
# Display: ConnectHub
```

### Productivity App
```bash
./create-project.sh
# Name: TaskMaster
# Package: com.productivity.taskmaster
# Display: Task Master
```

---

## 🚀 What Happens During Setup

When you run `./setup.sh`, the script automatically:

1. **✅ System Detection** - Identifies OS (Linux/macOS)
2. **✅ Check Prerequisites** - Verifies required tools
3. **📦 Install Java** - Auto-installs JDK if missing
4. **🎯 Setup Kotlin** - Installs Kotlin compiler
5. **🤖 Install Android SDK** - Downloads SDK, build-tools, platform-tools
6. **🔧 Create Gradle Wrapper** - Sets up Gradle 8.12
7. **🏗️ Build APK** - Compiles your app (output saved to build.log)
8. **📱 Install on Device** - Deploys APK via ADB
9. **💻 VS Code Extensions** - Optionally installs Kotlin/Java support
10. **✨ Done!** - App ready to launch

**⏱️ Time:** 2-5 minutes (first run), 30 seconds (subsequent builds)

---

## 📊 System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| **OS** | Ubuntu 18.04+ / macOS 10.14+ | Ubuntu 22.04+ / macOS 13+ |
| **RAM** | 4 GB | 8 GB+ |
| **Storage** | 2 GB free | 5 GB+ free |
| **Java** | JDK 8 | JDK 17 or JDK 21 |
| **Android Device** | Android 5.0+ (API 21) | Android 10+ (API 29) |
| **Internet** | Required for first setup | - |

---

## 🤝 Contributing

Contributions are welcome! Here's how:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Development Guidelines
- Follow Kotlin coding conventions
- Test on both Linux and macOS
- Update documentation for new features
- Keep scripts POSIX-compliant where possible

---

## 📄 License

```
MIT License

Copyright (c) 2025 Android Kotlin Generator

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🙏 Credits & Acknowledgments

Built with these amazing technologies:

- [**Kotlin**](https://kotlinlang.org/) - Modern, concise Android development language
- [**Android Gradle Plugin**](https://developer.android.com/build) - Official Android build system
- [**Material Components**](https://material.io/develop/android) - Google's Material Design UI
- [**AndroidX**](https://developer.android.com/jetpack/androidx) - Modern Android libraries
- [**Gradle**](https://gradle.org/) - Powerful build automation

---

## 📞 Support

Need help? We're here for you:

- 🐛 **Bug Reports:** [GitHub Issues](https://github.com/yourusername/android-kotlin-generator/issues)
- 💬 **Questions:** [GitHub Discussions](https://github.com/yourusername/android-kotlin-generator/discussions)
- 📧 **Email:** your.email@example.com
- 📖 **Wiki:** [Documentation](https://github.com/yourusername/android-kotlin-generator/wiki)

---

## 🎯 Roadmap

Future enhancements planned:

- [ ] **Jetpack Compose** support
- [ ] Multiple **splash screen templates**
- [ ] **Firebase** integration wizard
- [ ] **Automated testing** setup (JUnit, Espresso)
- [ ] **CI/CD** pipeline templates (GitHub Actions, GitLab CI)
- [ ] **Docker** containerization support
- [ ] **Room Database** template
- [ ] **Retrofit API** integration template
- [ ] **MVVM Architecture** template
- [ ] **Dependency Injection** (Hilt/Koin) setup

---

## 📈 Stats

![GitHub stars](https://img.shields.io/github/stars/yourusername/android-kotlin-generator?style=social)
![GitHub forks](https://img.shields.io/github/forks/yourusername/android-kotlin-generator?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/yourusername/android-kotlin-generator?style=social)

---

## 💖 Show Your Support

If this project helped you, please consider:

- ⭐ **Star** this repository
- 🐦 **Share** on Twitter
- 📝 **Write** a blog post about it
- 💰 **Sponsor** the project

---

<div align="center">

**Made with ❤️ for Android Developers**

[⬆ Back to Top](#-android-kotlin-project-generator)

</div>

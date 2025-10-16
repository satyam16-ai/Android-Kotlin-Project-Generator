#!/bin/bash

# Android Kotlin Project Generator
# Creates a new Android Kotlin project from scratch

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}════════════════════════════════════${NC}"
echo -e "${BLUE}  Android Kotlin Project Generator${NC}"
echo -e "${BLUE}════════════════════════════════════${NC}"
echo ""

# Get project details from user
read -p "Enter project name (e.g., MyKotlinApp): " PROJECT_NAME
read -p "Enter package name (e.g., com.example.myapp): " PACKAGE_NAME
read -p "Enter app display name (default: $PROJECT_NAME): " APP_DISPLAY_NAME
APP_DISPLAY_NAME=${APP_DISPLAY_NAME:-$PROJECT_NAME}

# Convert package name to directory path
PACKAGE_PATH=$(echo $PACKAGE_NAME | tr '.' '/')

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

echo ""
echo -e "${GREEN}✓${NC} Creating project: $PROJECT_NAME"
echo -e "${GREEN}✓${NC} Package: $PACKAGE_NAME"
echo -e "${GREEN}✓${NC} Display name: $APP_DISPLAY_NAME"
echo ""

# Create directory structure
echo -e "${YELLOW}→${NC} Creating project structure..."
mkdir -p app/src/main/java/$PACKAGE_PATH
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/values
mkdir -p app/src/main/res/drawable
mkdir -p gradle/wrapper
mkdir -p .github

echo -e "${GREEN}✓${NC} Project structure created"

# Create build.gradle (root)
cat > build.gradle << 'EOF'
buildscript {
    ext.kotlin_version = '1.9.0'
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath "com.android.tools.build:gradle:8.7.3"
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

# Create app/build.gradle
cat > app/build.gradle << EOF
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'

android {
    namespace '$PACKAGE_NAME'
    compileSdkVersion 34
    defaultConfig {
        applicationId "$PACKAGE_NAME"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0"
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = '1.8'
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib:1.9.0"
    implementation 'androidx.core:core-ktx:1.12.0'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
}
EOF

# Create settings.gradle
cat > settings.gradle << EOF
rootProject.name = "$PROJECT_NAME"
include ':app'
EOF

# Create gradle.properties
cat > gradle.properties << 'EOF'
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAndroidX=true
android.enableJetifier=true
kotlin.code.style=official
EOF

# Create gradle wrapper properties
cat > gradle/wrapper/gradle-wrapper.properties << 'EOF'
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.12-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
EOF

# Download gradle wrapper jar
curl -o gradle/wrapper/gradle-wrapper.jar https://raw.githubusercontent.com/gradle/gradle/master/gradle/wrapper/gradle-wrapper.jar 2>/dev/null

# Create AndroidManifest.xml
cat > app/src/main/AndroidManifest.xml << EOF
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <application
        android:allowBackup="true"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/Theme.$PROJECT_NAME">
        
        <activity 
            android:name=".SplashActivity"
            android:exported="true"
            android:theme="@style/SplashTheme">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        
        <activity 
            android:name=".MainActivity"
            android:exported="false" />
            
    </application>

</manifest>
EOF

# Create SplashActivity.kt
cat > app/src/main/java/$PACKAGE_PATH/SplashActivity.kt << EOF
package $PACKAGE_NAME

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.animation.AccelerateDecelerateInterpolator
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class SplashActivity : AppCompatActivity() {
    
    private lateinit var logoImageView: ImageView
    private lateinit var appNameTextView: TextView
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)
        
        logoImageView = findViewById(R.id.logo_imageview)
        appNameTextView = findViewById(R.id.app_name_textview)
        
        animateSplash()
    }
    
    private fun animateSplash() {
        logoImageView.apply {
            scaleX = 0.5f
            scaleY = 0.5f
            alpha = 0f
        }
        
        appNameTextView.apply {
            alpha = 0f
            translationY = 50f
        }
        
        logoImageView.animate()
            .scaleX(1f)
            .scaleY(1f)
            .alpha(1f)
            .setDuration(800)
            .setInterpolator(AccelerateDecelerateInterpolator())
            .withEndAction {
                appNameTextView.animate()
                    .alpha(1f)
                    .translationY(0f)
                    .setDuration(600)
                    .setInterpolator(AccelerateDecelerateInterpolator())
                    .start()
            }
            .start()
        
        Handler(Looper.getMainLooper()).postDelayed({
            startActivity(Intent(this, MainActivity::class.java))
            finish()
        }, 2500)
    }
}
EOF

# Create MainActivity.kt
cat > app/src/main/java/$PACKAGE_PATH/MainActivity.kt << EOF
package $PACKAGE_NAME

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }
}
EOF

# Create activity_splash.xml
cat > app/src/main/res/layout/activity_splash.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/splash_background">

    <LinearLayout
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_centerInParent="true"
        android:orientation="vertical"
        android:gravity="center">

        <ImageView
            android:id="@+id/logo_imageview"
            android:layout_width="120dp"
            android:layout_height="120dp"
            android:src="@drawable/ic_launcher_foreground"
            android:contentDescription="@string/app_logo" />

        <TextView
            android:id="@+id/app_name_textview"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginTop="16dp"
            android:text="@string/app_name"
            android:textSize="28sp"
            android:textStyle="bold"
            android:textColor="@color/white" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginTop="8dp"
            android:text="@string/app_tagline"
            android:textSize="14sp"
            android:textColor="@color/white"
            android:alpha="0.8" />

    </LinearLayout>

    <ProgressBar
        android:layout_width="36dp"
        android:layout_height="36dp"
        android:layout_alignParentBottom="true"
        android:layout_centerHorizontal="true"
        android:layout_marginBottom="48dp"
        android:indeterminateTint="@color/white" />

</RelativeLayout>
EOF

# Create activity_main.xml
cat > app/src/main/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/white"
    android:fillViewport="true">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:padding="24dp"
        android:gravity="center_horizontal">

        <ImageView
            android:layout_width="120dp"
            android:layout_height="120dp"
            android:layout_marginTop="48dp"
            android:src="@drawable/ic_launcher_foreground"
            android:contentDescription="@string/app_logo" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginTop="24dp"
            android:text="Welcome! 👋"
            android:textSize="32sp"
            android:textStyle="bold"
            android:textColor="@color/purple_500" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginTop="8dp"
            android:text="@string/app_name"
            android:textSize="20sp"
            android:textColor="@color/black"
            android:alpha="0.7" />

        <View
            android:layout_width="60dp"
            android:layout_height="4dp"
            android:layout_marginTop="24dp"
            android:background="@color/purple_500" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginTop="32dp"
            android:text="✨ Your Kotlin Android App is Ready!"
            android:textSize="18sp"
            android:textStyle="bold"
            android:textColor="@color/purple_700"
            android:gravity="center" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginTop="16dp"
            android:text="• Built with Kotlin\n• Animated Splash Screen\n• Material Design\n• Ready for Development"
            android:textSize="16sp"
            android:textColor="@color/black"
            android:lineSpacingExtra="4dp" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginTop="48dp"
            android:text="Built with ❤️ using VS Code"
            android:textSize="14sp"
            android:textColor="@color/black"
            android:alpha="0.5" />

    </LinearLayout>

</ScrollView>
EOF

# Create strings.xml
cat > app/src/main/res/values/strings.xml << EOF
<resources>
    <string name="app_name">$APP_DISPLAY_NAME</string>
    <string name="app_logo">App Logo</string>
    <string name="app_tagline">Powered by Kotlin</string>
</resources>
EOF

# Create colors.xml
cat > app/src/main/res/values/colors.xml << 'EOF'
<resources>
    <color name="purple_500">#6200EE</color>
    <color name="purple_700">#3700B3</color>
    <color name="teal_200">#03DAC5</color>
    <color name="teal_700">#018786</color>
    <color name="white">#FFFFFF</color>
    <color name="black">#000000</color>
    <color name="splash_background">#6200EE</color>
</resources>
EOF

# Create styles.xml
cat > app/src/main/res/values/styles.xml << EOF
<resources>
    <style name="Theme.$PROJECT_NAME" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
        <item name="colorPrimary">@color/purple_500</item>
        <item name="colorPrimaryVariant">@color/purple_700</item>
        <item name="colorOnPrimary">@color/white</item>
        <item name="colorSecondary">@color/teal_200</item>
        <item name="colorSecondaryVariant">@color/teal_700</item>
        <item name="colorOnSecondary">@color/black</item>
    </style>
    
    <style name="SplashTheme" parent="Theme.MaterialComponents.DayNight.NoActionBar">
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowBackground">@color/splash_background</item>
    </style>
</resources>
EOF

# Create ic_launcher_foreground.xml
cat > app/src/main/res/drawable/ic_launcher_foreground.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="108"
    android:viewportHeight="108">
    
    <path
        android:fillColor="@color/purple_500"
        android:pathData="M54,54m-50,0a50,50 0,1 1,100 0a50,50 0,1 1,-100 0" />
    
    <path
        android:fillColor="@color/white"
        android:pathData="M35,70L35,38L42,38L54,55L66,38L73,38L73,70L66,70L66,50L54,67L42,50L42,70Z" />
    
</vector>
EOF

# Create proguard-rules.pro
cat > app/proguard-rules.pro << 'EOF'
# Add project specific ProGuard rules here
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
*.iml
.gradle
/local.properties
/.idea/
.DS_Store
/build
/captures
.externalNativeBuild
.cxx
local.properties
*.log
EOF

# Copy setup.sh from template
cp /home/satyam_ai/Desktop/android/setup.sh ./setup.sh
chmod +x setup.sh

# Create README
cat > README.md << EOF
# $PROJECT_NAME

Android Kotlin application with animated splash screen.

## Quick Start

\`\`\`bash
./setup.sh
\`\`\`

## Package
\`$PACKAGE_NAME\`

## Features
- Animated Splash Screen
- Material Design
- Kotlin Native
- Ready for Development
EOF

# Copy Gradle wrapper from template (if exists)
if [ -f "$TEMPLATE_DIR/gradlew" ]; then
    echo "→ Copying Gradle wrapper..."
    cp "$TEMPLATE_DIR/gradlew" .
    cp "$TEMPLATE_DIR/gradlew.bat" . 2>/dev/null || true
    chmod +x gradlew
fi

echo ""
echo -e "${GREEN}════════════════════════════════════${NC}"
echo -e "${GREEN}  ✅ Project Created Successfully!${NC}"
echo -e "${GREEN}════════════════════════════════════${NC}"
echo ""
echo -e "${BLUE}Project location: $(pwd)${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. cd $PROJECT_NAME"
echo "  2. ./setup.sh"
echo ""

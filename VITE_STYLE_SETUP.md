# 🚀 Vite-Style Android Kotlin Generator

## What Changed?

Instead of **hardcoding** all files in bash scripts, we now use a **template-based approach** like Vite/Create React App:

### Old Approach ❌
```bash
# Hardcoded everything in create-project.sh
cat > MainActivity.kt << 'EOF'
package com.example...
...500 lines of hardcoded files...
EOF
```

### New Approach ✅
```bash
# Download template from GitHub
git clone https://github.com/satyam16-ai/android-kotlin-template.git
# Customize package names
sed -i "s/com.example.myapp/$YOUR_PACKAGE/g" *.kt
```

## 📦 Two Repositories

### 1. **android-kotlin-template** (Template Repo)
- Contains the base Android project
- Has Gradle wrapper included
- Ready-to-use app with splash screen
- Push this to: `https://github.com/satyam16-ai/android-kotlin-template`

### 2. **Android-Kotlin-Project-Generator** (Generator Repo)
- Contains `create-android-app.sh` (lightweight script)
- Downloads template from GitHub
- Customizes it with user's package name
- Current repo

## 🎯 Setup Steps

### Step 1: Push Template to GitHub

```bash
cd ~/Desktop/android/android-kotlin-template

# Create repo on GitHub: android-kotlin-template
git remote add origin git@github.com:satyam16-ai/android-kotlin-template.git
git push -u origin main
```

### Step 2: Update Main Repo

```bash
cd ~/Desktop/android

# Add new generator script
git add create-android-app.sh
git commit -m "✨ Add Vite-style generator (downloads template)"
git push
```

### Step 3: Test the Generator

```bash
cd ~/Desktop

# Run the new generator
bash ~/Desktop/android/create-android-app.sh

# It will:
# 1. Ask for project details
# 2. Clone template from GitHub
# 3. Customize package names
# 4. Ready to use!
```

## ✨ Benefits

| Feature | Old (Hardcoded) | New (Template) |
|---------|----------------|----------------|
| **Size** | 15KB script | 2KB script |
| **Speed** | Slow (writes each file) | Fast (git clone) |
| **Updates** | Edit bash script | Update GitHub repo |
| **Gradle Wrapper** | Missing/broken | ✅ Included |
| **Maintenance** | Hard | Easy |
| **Like Vite?** | ❌ | ✅ |

## 📋 How It Works

```bash
$ create-android-app

🚀 Create Android Kotlin App
━━━━━━━━━━━━━━━━━━━━━━━━━━

Project name: MyAwesomeApp
Package name: com.mycompany.awesome  
App display name: My Awesome App

→ Downloading template...
→ Customizing project...
→ Git initialized

✅ Done! Project created at: ./MyAwesomeApp

Next steps:
  cd MyAwesomeApp
  ./setup.sh
```

## 🔧 What Gets Customized

The generator automatically replaces:

1. **Package name**: `com.example.myapplication` → `com.mycompany.awesome`
2. **App name**: In `strings.xml`
3. **Project name**: In `settings.gradle`
4. **Package structure**: Creates `com/mycompany/awesome/` folders
5. **README**: With your project details

## 📂 Template Structure

```
android-kotlin-template/
├── app/
│   ├── build.gradle
│   └── src/main/
│       ├── java/com/example/myapplication/
│       │   ├── SplashActivity.kt
│       │   └── MainActivity.kt
│       ├── res/
│       └── AndroidManifest.xml
├── gradle/wrapper/ (✅ Included!)
├── gradlew (✅ Included!)
├── build.gradle
├── settings.gradle
└── setup.sh
```

## 🎯 Usage

### Install Globally (Optional)

```bash
# Copy to /usr/local/bin
sudo cp ~/Desktop/android/create-android-app.sh /usr/local/bin/create-android-app
sudo chmod +x /usr/local/bin/create-android-app

# Now use anywhere:
cd ~/projects
create-android-app
```

### Use Directly

```bash
bash ~/Desktop/android/create-android-app.sh
```

### Use with npx-style (Future)

```bash
# Could be published as npm package
npx create-android-app my-app
```

## 🚀 Publishing

### 1. Publish Template

```bash
cd ~/Desktop/android/android-kotlin-template
git remote add origin git@github.com:satyam16-ai/android-kotlin-template.git
git push -u origin main
```

### 2. Update Generator README

Add to main README.md:

```markdown
## Quick Start

\`\`\`bash
curl -fsSL https://raw.githubusercontent.com/satyam16-ai/Android-Kotlin-Project-Generator/main/create-android-app.sh | bash
\`\`\`

Or clone and run:

\`\`\`bash
git clone https://github.com/satyam16-ai/Android-Kotlin-Project-Generator.git
./Android-Kotlin-Project-Generator/create-android-app.sh
\`\`\`
```

## 📊 Comparison

### Create React App Style:
```bash
npx create-react-app my-app
cd my-app
npm start
```

### Our Android Generator:
```bash
create-android-app
cd MyApp  
./setup.sh
```

**Same simplicity! 🎉**

## 🎓 Next Steps

1. ✅ Push `android-kotlin-template` to GitHub
2. ✅ Test the new generator
3. ✅ Update main repo README
4. ✅ Add to PATH for global access
5. 🔄 Maintain template repo for updates

---

**Made with ❤️ - Just like Vite!**

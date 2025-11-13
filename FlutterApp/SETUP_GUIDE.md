# 🚀 Flutter App Setup Guide

**Smart Agriculture Mobile App**  
**Version:** 1.0.0  
**Last Updated:** 2025-11-08

---

## 📋 Prerequisites

### **Required Software**
1. **Flutter SDK** (3.0.0 or higher)
   - Download: https://flutter.dev/docs/get-started/install
   - Verify: `flutter --version`

2. **Dart SDK** (3.0.0 or higher)
   - Included with Flutter

3. **Android Studio** (for Android development)
   - Download: https://developer.android.com/studio
   - Install Android SDK (API 21+)
   - Install Android Emulator

4. **Xcode** (for iOS development - Mac only)
   - Download from Mac App Store
   - Install Command Line Tools: `xcode-select --install`

5. **Git**
   - Download: https://git-scm.com/downloads

### **System Requirements**
- **Windows:** Windows 10 or later (64-bit)
- **macOS:** macOS 10.14 or later
- **Linux:** Ubuntu 18.04 or later
- **RAM:** 8GB minimum (16GB recommended)
- **Disk Space:** 10GB free space

---

## 🔧 Installation Steps

### **Step 1: Verify Flutter Installation**

```bash
# Check Flutter installation
flutter doctor

# Expected output should show:
# ✓ Flutter (Channel stable)
# ✓ Android toolchain
# ✓ Chrome (for web development)
# ✓ Android Studio
# ✓ VS Code (optional)
# ✓ Connected device
```

If any issues are found, follow the instructions provided by `flutter doctor`.

### **Step 2: Clone/Navigate to Project**

```bash
cd C:\Users\Admin\Desktop\Smart-Agriculture\FlutterApp
```

### **Step 3: Install Dependencies**

```bash
# Get all Flutter packages
flutter pub get

# This will install:
# - provider (state management)
# - dio (HTTP client)
# - shared_preferences (local storage)
# - google_fonts (typography)
# - fl_chart (charts)
# - intl (internationalization)
# - And more...
```

### **Step 4: Configure API Endpoint**

Edit `lib/config/app_config.dart`:

```dart
// For Android Emulator
static const String apiBaseUrl = 'http://10.0.2.2:5000/api';

// For iOS Simulator
static const String apiBaseUrl = 'http://localhost:5000/api';

// For Physical Device (replace with your computer's IP)
static const String apiBaseUrl = 'http://192.168.1.XXX:5000/api';
```

**To find your computer's IP:**
- **Windows:** `ipconfig` (look for IPv4 Address)
- **macOS/Linux:** `ifconfig` or `ip addr`

### **Step 5: Start Backend Server**

The Flutter app requires the backend API to be running:

```bash
# Navigate to backend directory
cd ..\WebApp\backend

# Install dependencies (first time only)
npm install

# Start the server
npm run dev

# Server should start on http://localhost:5000
```

---

## 📱 Running the App

### **Option 1: Android Emulator**

1. **Start Android Emulator:**
   - Open Android Studio
   - Go to Tools > Device Manager
   - Create/Start an emulator (API 21+)

2. **Run the app:**
   ```bash
   flutter run
   ```

### **Option 2: Physical Android Device**

1. **Enable Developer Options:**
   - Go to Settings > About Phone
   - Tap "Build Number" 7 times
   - Go back to Settings > Developer Options
   - Enable "USB Debugging"

2. **Connect device via USB**

3. **Verify connection:**
   ```bash
   flutter devices
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

### **Option 3: iOS Simulator (Mac only)**

1. **Start iOS Simulator:**
   ```bash
   open -a Simulator
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

### **Option 4: Physical iOS Device (Mac only)**

1. **Connect device via USB**

2. **Trust the computer on your device**

3. **Configure signing in Xcode:**
   - Open `ios/Runner.xcworkspace` in Xcode
   - Select Runner > Signing & Capabilities
   - Select your Team

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🎯 Quick Start Commands

```bash
# List all connected devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Run in debug mode (default)
flutter run

# Run in release mode (faster, no hot reload)
flutter run --release

# Run in profile mode (performance profiling)
flutter run --profile

# Hot reload (press 'r' in terminal while app is running)
# Hot restart (press 'R' in terminal)
# Quit (press 'q' in terminal)
```

---

## 🔍 Troubleshooting

### **Problem: Cannot connect to backend**

**Solution:**
1. Verify backend is running: `http://localhost:5000/api/health`
2. Check API URL in `app_config.dart`
3. For physical device, use computer's IP address
4. Disable firewall temporarily to test
5. Ensure both devices are on same network

### **Problem: Build errors**

**Solution:**
```bash
# Clean build cache
flutter clean

# Get dependencies again
flutter pub get

# Rebuild
flutter run
```

### **Problem: Gradle build fails (Android)**

**Solution:**
```bash
# Navigate to android directory
cd android

# Clean Gradle cache
./gradlew clean

# Or on Windows
gradlew.bat clean

# Go back and rebuild
cd ..
flutter run
```

### **Problem: Pod install fails (iOS)**

**Solution:**
```bash
# Navigate to ios directory
cd ios

# Update CocoaPods
pod repo update

# Install pods
pod install

# Go back and rebuild
cd ..
flutter run
```

### **Problem: Hot reload not working**

**Solution:**
- Press 'R' for hot restart instead of 'r'
- Check for syntax errors
- Restart the app completely
- Some changes require full restart (main.dart, native code)

### **Problem: App crashes on startup**

**Solution:**
1. Check backend is running
2. Verify API URL is correct
3. Check device logs:
   ```bash
   flutter logs
   ```
4. Run in debug mode to see error details

---

## 🧪 Testing

### **Manual Testing**

```bash
# Run app in debug mode
flutter run

# Test the following features:
# ✓ Login with valid credentials
# ✓ Register new account
# ✓ View dashboard stats
# ✓ Add new field
# ✓ View field details
# ✓ View sensors
# ✓ View alerts
# ✓ Mark alert as read
# ✓ Start/stop irrigation
# ✓ View recommendations
# ✓ View profile
# ✓ Logout
```

### **Test Credentials**

Use credentials from your database or register a new account:
- **Email:** test@example.com
- **Password:** Test123!

---

## 📦 Building for Production

### **Android APK (Debug)**

```bash
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

### **Android APK (Release)**

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### **Android App Bundle (for Play Store)**

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### **iOS (Mac only)**

```bash
flutter build ios --release
# Then open Xcode to archive and upload to App Store
```

---

## 🔐 App Signing (Production)

### **Android Signing**

1. **Generate keystore:**
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Create `android/key.properties`:**
   ```properties
   storePassword=<password>
   keyPassword=<password>
   keyAlias=upload
   storeFile=<path-to-keystore>
   ```

3. **Update `android/app/build.gradle`:**
   ```gradle
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
   ```

### **iOS Signing**

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select Runner > Signing & Capabilities
3. Select your Team and Bundle Identifier
4. Archive and upload to App Store Connect

---

## 📊 Performance Optimization

### **Release Build Optimizations**

```bash
# Build with optimization flags
flutter build apk --release --split-per-abi

# This creates separate APKs for:
# - armeabi-v7a (32-bit ARM)
# - arm64-v8a (64-bit ARM)
# - x86_64 (64-bit Intel)
```

### **Reduce App Size**

1. **Remove unused resources**
2. **Enable code shrinking** (already configured)
3. **Use vector graphics** instead of raster images
4. **Compress images**
5. **Use App Bundle** instead of APK

---

## 🔄 Updating Dependencies

```bash
# Check for outdated packages
flutter pub outdated

# Update all packages to latest compatible versions
flutter pub upgrade

# Update to latest major versions (breaking changes)
flutter pub upgrade --major-versions
```

---

## 📱 Device-Specific Configuration

### **Android Minimum SDK**
- **Minimum:** API 21 (Android 5.0 Lollipop)
- **Target:** API 34 (Android 14)
- **Compile:** API 34

### **iOS Minimum Version**
- **Minimum:** iOS 12.0
- **Target:** iOS 17.0

---

## 🌐 Network Configuration

### **Android Network Security**

The app is configured to allow cleartext traffic for local development:
```xml
android:usesCleartextTraffic="true"
```

**For production, remove this and use HTTPS only.**

### **iOS Network Security**

The app allows arbitrary loads for local development:
```xml
<key>NSAllowsArbitraryLoads</key>
<true/>
```

**For production, remove this and use HTTPS only.**

---

## 📝 Development Tips

### **Hot Reload vs Hot Restart**

- **Hot Reload (r):** Fast, preserves app state
- **Hot Restart (R):** Slower, resets app state
- **Full Restart:** Required for native code changes

### **Useful VS Code Extensions**

1. **Flutter** - Official Flutter extension
2. **Dart** - Official Dart extension
3. **Flutter Widget Snippets** - Code snippets
4. **Awesome Flutter Snippets** - More snippets
5. **Pubspec Assist** - Dependency management

### **Debugging**

```bash
# Run with verbose logging
flutter run -v

# View device logs
flutter logs

# Analyze code
flutter analyze

# Format code
flutter format .
```

---

## 🆘 Getting Help

### **Resources**
- **Flutter Docs:** https://flutter.dev/docs
- **Dart Docs:** https://dart.dev/guides
- **Stack Overflow:** https://stackoverflow.com/questions/tagged/flutter
- **Flutter Community:** https://flutter.dev/community

### **Project Documentation**
- `README.md` - Project overview
- `FLUTTER_SYNC_STATUS.md` - Sync verification
- `PROJECT_CONTEXT.md` - Overall architecture
- Backend `README.md` - API documentation

---

## ✅ Setup Checklist

- [ ] Flutter SDK installed and verified
- [ ] Android Studio/Xcode installed
- [ ] Dependencies installed (`flutter pub get`)
- [ ] API endpoint configured in `app_config.dart`
- [ ] Backend server running on port 5000
- [ ] Device/emulator connected
- [ ] App runs successfully
- [ ] Can login with test credentials
- [ ] Dashboard loads with data
- [ ] All screens accessible

---

**Status:** ✅ Flutter App Ready for Development  
**Next Steps:** Run the app, test features, and start developing!

🎉 **Happy Coding!**

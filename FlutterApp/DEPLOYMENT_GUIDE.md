# 📦 Flutter App Deployment Guide

**Smart Agriculture Mobile App**  
**Version:** 1.0.0  
**Platform:** Android & iOS

---

## 📋 Pre-Deployment Checklist

### **Code Quality**
- [ ] All features tested and working
- [ ] No console errors or warnings
- [ ] Code formatted: `flutter format .`
- [ ] Code analyzed: `flutter analyze`
- [ ] Performance optimized
- [ ] Memory leaks checked

### **Configuration**
- [ ] API endpoint changed to production URL
- [ ] Remove debug flags
- [ ] Update app version in `pubspec.yaml`
- [ ] Update app name and icons
- [ ] Configure proper permissions
- [ ] Remove test credentials

### **Security**
- [ ] HTTPS only (no cleartext traffic)
- [ ] API keys secured
- [ ] Sensitive data encrypted
- [ ] Certificate pinning (optional)
- [ ] ProGuard/R8 enabled (Android)

### **Assets**
- [ ] App icon (1024x1024)
- [ ] Splash screen
- [ ] Screenshots for stores
- [ ] Feature graphics
- [ ] Privacy policy URL
- [ ] Terms of service URL

---

## 🤖 Android Deployment

### **Step 1: Prepare for Release**

1. **Update `pubspec.yaml`:**
   ```yaml
   version: 1.0.0+1  # version+buildNumber
   ```

2. **Update API URL in `lib/config/app_config.dart`:**
   ```dart
   static const String apiBaseUrl = 'https://your-production-api.com/api';
   ```

3. **Remove cleartext traffic from `AndroidManifest.xml`:**
   ```xml
   <!-- Remove this line: -->
   android:usesCleartextTraffic="true"
   ```

### **Step 2: Generate Signing Key**

```bash
# Generate keystore (one-time setup)
keytool -genkey -v -keystore ~/smart-agriculture-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias smart-agriculture

# You'll be asked for:
# - Keystore password (save this securely!)
# - Key password (save this securely!)
# - Name, Organization, etc.
```

**⚠️ IMPORTANT:** Store the keystore file and passwords securely. If lost, you cannot update your app!

### **Step 3: Configure Signing**

Create `android/key.properties`:
```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=smart-agriculture
storeFile=C:/path/to/smart-agriculture-keystore.jks
```

**Add to `.gitignore`:**
```
android/key.properties
*.jks
```

Update `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### **Step 4: Build Release APK**

```bash
# Build release APK
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
# Size: ~15-20 MB
```

### **Step 5: Build App Bundle (Recommended for Play Store)**

```bash
# Build App Bundle (smaller download size)
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### **Step 6: Test Release Build**

```bash
# Install on device
flutter install --release

# Or manually install APK
adb install build/app/outputs/flutter-apk/app-release.apk
```

### **Step 7: Google Play Store Submission**

1. **Create Developer Account:**
   - Go to https://play.google.com/console
   - Pay one-time $25 registration fee

2. **Create New App:**
   - App name: Smart Agriculture
   - Default language: English
   - App or game: App
   - Free or paid: Free

3. **Fill App Information:**
   - **App details:**
     - Short description (80 chars)
     - Full description (4000 chars)
     - Screenshots (at least 2)
     - Feature graphic (1024x500)
     - App icon (512x512)
   
   - **Categorization:**
     - Category: Productivity / Business
     - Tags: agriculture, farming, IoT, smart farming
   
   - **Contact details:**
     - Email, phone, website
     - Privacy policy URL (required)

4. **Upload App Bundle:**
   - Go to Production > Create new release
   - Upload `app-release.aab`
   - Add release notes
   - Review and rollout

5. **Content Rating:**
   - Complete questionnaire
   - Get rating (likely: Everyone)

6. **Pricing & Distribution:**
   - Free
   - Select countries (Pakistan, etc.)
   - Confirm content guidelines

7. **Submit for Review:**
   - Review all sections
   - Submit for review
   - Wait 1-3 days for approval

---

## 🍎 iOS Deployment

### **Step 1: Prepare for Release**

1. **Update `pubspec.yaml`:**
   ```yaml
   version: 1.0.0+1
   ```

2. **Update API URL:**
   ```dart
   static const String apiBaseUrl = 'https://your-production-api.com/api';
   ```

3. **Remove arbitrary loads from `ios/Runner/Info.plist`:**
   ```xml
   <!-- Remove or modify NSAppTransportSecurity -->
   ```

### **Step 2: Configure Xcode**

1. **Open project in Xcode:**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Update Bundle Identifier:**
   - Select Runner in project navigator
   - General tab
   - Bundle Identifier: `com.smartagriculture.app`

3. **Configure Signing:**
   - Signing & Capabilities tab
   - Team: Select your Apple Developer team
   - Automatically manage signing: ✓

4. **Update App Info:**
   - Display Name: Smart Agriculture
   - Version: 1.0.0
   - Build: 1

### **Step 3: App Icons & Launch Screen**

1. **App Icon:**
   - Create 1024x1024 icon
   - Use https://appicon.co to generate all sizes
   - Replace in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

2. **Launch Screen:**
   - Edit `ios/Runner/Base.lproj/LaunchScreen.storyboard`
   - Or use launch screen package

### **Step 4: Build for Release**

```bash
# Build iOS release
flutter build ios --release

# This creates:
# build/ios/iphoneos/Runner.app
```

### **Step 5: Archive in Xcode**

1. **Select "Any iOS Device" as target**

2. **Product > Archive**

3. **Wait for archive to complete**

4. **Window > Organizer** to see archives

### **Step 6: Upload to App Store Connect**

1. **Create App Store Connect Account:**
   - Go to https://appstoreconnect.apple.com
   - Requires Apple Developer Program ($99/year)

2. **Create New App:**
   - My Apps > + > New App
   - Platform: iOS
   - Name: Smart Agriculture
   - Primary Language: English
   - Bundle ID: com.smartagriculture.app
   - SKU: smart-agriculture-001

3. **Fill App Information:**
   - **App Information:**
     - Subtitle (30 chars)
     - Privacy Policy URL
     - Category: Productivity
     - Secondary Category: Business
   
   - **Pricing:**
     - Price: Free
     - Availability: All countries
   
   - **App Privacy:**
     - Complete privacy questionnaire
     - Data collection disclosure

4. **Prepare for Submission:**
   - **Screenshots:** (Required for all device sizes)
     - 6.5" iPhone (1284x2778)
     - 5.5" iPhone (1242x2208)
     - 12.9" iPad Pro (2048x2732)
   
   - **App Preview Video:** (Optional)
   
   - **Description:**
     - Promotional text (170 chars)
     - Description (4000 chars)
     - Keywords (100 chars)
     - Support URL
     - Marketing URL (optional)

5. **Upload Build:**
   - In Xcode Organizer
   - Select archive
   - Distribute App > App Store Connect
   - Upload
   - Wait for processing (15-30 mins)

6. **Submit for Review:**
   - Select uploaded build
   - Add What's New in This Version
   - Submit for review
   - Wait 1-3 days for approval

---

## 🔄 Version Updates

### **Semantic Versioning**

Format: `MAJOR.MINOR.PATCH+BUILD`

- **MAJOR:** Breaking changes (1.0.0 → 2.0.0)
- **MINOR:** New features (1.0.0 → 1.1.0)
- **PATCH:** Bug fixes (1.0.0 → 1.0.1)
- **BUILD:** Build number (always increment)

Example:
```yaml
version: 1.2.3+45
# Version: 1.2.3
# Build: 45
```

### **Updating Existing App**

1. **Increment version in `pubspec.yaml`:**
   ```yaml
   version: 1.1.0+2  # New version + new build number
   ```

2. **Build new release:**
   ```bash
   flutter build appbundle --release  # Android
   flutter build ios --release         # iOS
   ```

3. **Upload to stores:**
   - Google Play: Create new release
   - App Store: Upload new build

4. **Add release notes:**
   - What's new
   - Bug fixes
   - Improvements

---

## 🧪 Testing Before Release

### **Internal Testing**

```bash
# Build and test release version
flutter build apk --release
flutter install --release

# Test on multiple devices:
# - Different Android versions
# - Different screen sizes
# - Different network conditions
```

### **Beta Testing**

**Android (Google Play):**
- Create closed/open testing track
- Add testers via email
- Get feedback before production

**iOS (TestFlight):**
- Upload build to App Store Connect
- Add internal/external testers
- Get feedback before release

### **Testing Checklist**

- [ ] App launches successfully
- [ ] Login/registration works
- [ ] All screens load properly
- [ ] API calls work with production backend
- [ ] Images and assets load
- [ ] Notifications work (if implemented)
- [ ] Offline behavior (if implemented)
- [ ] Performance is acceptable
- [ ] No crashes or freezes
- [ ] Battery usage is reasonable

---

## 📊 Analytics & Monitoring

### **Recommended Tools**

1. **Firebase Analytics** (Free)
   - User behavior tracking
   - Crash reporting
   - Performance monitoring

2. **Sentry** (Crash reporting)
   - Real-time error tracking
   - Release health monitoring

3. **Google Analytics**
   - User demographics
   - Screen views
   - Events

### **Implementation**

Add to `pubspec.yaml`:
```yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_analytics: ^10.7.4
  firebase_crashlytics: ^3.4.8
```

---

## 🔐 Security Best Practices

### **API Security**
- [ ] Use HTTPS only
- [ ] Implement certificate pinning
- [ ] Secure token storage
- [ ] API key obfuscation

### **Data Security**
- [ ] Encrypt sensitive data
- [ ] Use secure storage (flutter_secure_storage)
- [ ] Clear cache on logout
- [ ] Validate all inputs

### **Code Security**
- [ ] Enable ProGuard/R8 (Android)
- [ ] Obfuscate code: `flutter build --obfuscate`
- [ ] Remove debug logs
- [ ] No hardcoded secrets

---

## 📈 Post-Launch

### **Monitor Metrics**
- Downloads
- Active users
- Crash rate
- User ratings
- Performance metrics

### **Gather Feedback**
- App store reviews
- In-app feedback
- User surveys
- Support tickets

### **Continuous Improvement**
- Regular updates
- Bug fixes
- New features
- Performance optimization

---

## 🆘 Common Issues

### **Android Build Fails**

```bash
# Clean and rebuild
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

### **iOS Build Fails**

```bash
# Clean and rebuild
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter build ios --release
```

### **App Rejected by Store**

**Common reasons:**
- Missing privacy policy
- Incomplete app information
- Crashes on launch
- Misleading description
- Inappropriate content

**Solution:** Fix issues and resubmit

---

## 📞 Support Resources

### **Documentation**
- Flutter Deployment: https://flutter.dev/docs/deployment
- Google Play Console: https://support.google.com/googleplay/android-developer
- App Store Connect: https://developer.apple.com/app-store-connect/

### **Communities**
- Flutter Discord: https://discord.gg/flutter
- Stack Overflow: https://stackoverflow.com/questions/tagged/flutter
- Reddit: r/FlutterDev

---

## ✅ Deployment Checklist

### **Pre-Release**
- [ ] All features complete and tested
- [ ] Production API configured
- [ ] App signed properly
- [ ] Icons and assets ready
- [ ] Privacy policy created
- [ ] Store listings prepared

### **Android**
- [ ] APK/AAB built successfully
- [ ] Tested on physical device
- [ ] Google Play account created
- [ ] App listing complete
- [ ] Submitted for review

### **iOS**
- [ ] Archive created successfully
- [ ] Tested on physical device
- [ ] Apple Developer account active
- [ ] App Store listing complete
- [ ] Submitted for review

### **Post-Release**
- [ ] Monitor crash reports
- [ ] Respond to reviews
- [ ] Track analytics
- [ ] Plan next update

---

**Status:** ✅ Ready for Deployment  
**Estimated Time:** 1-3 days for store approval

🚀 **Good luck with your launch!**

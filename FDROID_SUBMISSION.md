# F-Droid Submission Guide for Linfa

This document contains everything needed to submit Linfa to F-Droid.

## Quick Summary

F-Droid is an app store for Free and Open Source Software (FOSS) Android apps. All apps must be built from source, contain no proprietary dependencies, and meet strict privacy requirements.

## What's Been Prepared

### 1. Fastlane Metadata Structure
```
fastlane/metadata/android/
├── en-US/
│   ├── title.txt
│   ├── short_description.txt
│   ├── full_description.txt
│   ├── changelogs/
│   │   └── 1.txt
│   └── images/
│       └── screenshots/
└── it-IT/
    ├── title.txt
    ├── short_description.txt
    ├── full_description.txt
    ├── changelogs/
    │   └── 1.txt
    └── images/
        └── screenshots/
```

### 2. F-Droid Metadata File
Located at `fdroid/com.linfa.app.yml` - this is the build recipe F-Droid uses.

### 3. Android Build Configuration
Updated `android/app/build.gradle.kts` with:
- Fixed SDK versions (compileSdk 34, targetSdk 34)
- Disabled dependency info inclusion in APK (`dependenciesInfo`)
- Explicit version code/name for reproducible builds

## Required Changes Before Submission

### DONE: `google_fonts` Dependency Removed

The `google_fonts` package has been removed from `pubspec.yaml` and Roboto fonts are now bundled locally in `assets/fonts/`. The font declaration in `pubspec.yaml` now references these local `.ttf` files directly.

### DONE: `isar_flutter_libs` Compatibility

Isar bundles precompiled native binaries. F-Droid may require these to be built from source. Check current F-Droid policy or have `drift` as a fallback.

## Submission Process

### Option 1: Submit to F-Droid Official Repository (Recommended)

1. **Fork the f-droid-data repository**
   ```bash
   git clone https://gitlab.com/fdroid/fdroiddata.git
   cd fdroiddata
   ```

2. **Copy the metadata file**
   ```bash
   cp /path/to/linfa/fdroid/com.linfa.app.yml metadata/com.linfa.app.yml
   ```

3. **Test the build locally** (requires Docker)
   ```bash
   docker run -ti --rm -v "$(pwd):/build" registry.gitlab.com/fdroid/fdroidserver:latest build com.linfa.app
   ```

4. **Create a Merge Request**
   - Push your changes to your fork
   - Open a merge request at https://gitlab.com/fdroid/fdroiddata/-/merge_requests
   - Fill in the MR template with app details

### Option 2: Use F-Droid's Inclusion Request

1. Go to https://gitlab.com/fdroid/rfp/-/issues
2. Create a new issue with:
   - App name: Linfa
   - Source code URL: https://github.com/cataWalter/linfa
   - License: MIT
   - Summary: Houseplant tracker and reminder app
   - Category: Reading

## Build Verification

Before submitting, verify your app builds correctly:

```bash
# Clean build
flutter clean
flutter pub get

# Build release APK
flutter build apk --release

# Verify no proprietary dependencies
flutter pub deps --style=compact
```

## F-Droid Requirements Checklist

- [x] Open source license (MIT)
- [x] Source code publicly available
- [x] No proprietary dependencies (google_fonts removed, fonts bundled locally)
- [x] No tracking or analytics
- [x] No proprietary services required
- [x] Fastlane metadata structure created
- [x] Build configuration updated for reproducible builds
- [x] `google_fonts` replaced with bundled fonts
- [x] App icon added to fastlane metadata (512x512)
- [ ] Screenshots added to `fastlane/metadata/android/*/images/screenshots/`
- [ ] APK builds successfully on F-Droid's build server
- [ ] APK builds successfully on F-Droid's build server

## Screenshots Requirements

F-Droid requires at least one screenshot per supported locale:

- Format: PNG or JPEG
- Minimum size: 320x480 pixels
- Maximum size: 8192x8192 pixels
- Recommended: 1080x1920 (portrait) or 1920x1080 (landscape)
- Maximum 8 screenshots per locale

Place screenshots in:
```
fastlane/metadata/android/en-US/images/screenshots/
fastlane/metadata/android/it-IT/images/screenshots/
```

## Icon Requirements

- Format: PNG
- Size: 512x512 pixels
- No transparency
- Place at: `fastlane/metadata/android/en-US/images/icon.png`

## Feature Graphic (Optional)

- Format: PNG
- Size: 1024x500 pixels
- Place at: `fastlane/metadata/android/en-US/images/featureGraphic.png`

## After Submission

1. F-Droid maintainers will review your submission
2. They may request changes or clarifications
3. Once approved, the app will be built on F-Droid's build server
4. The app will appear in the F-Droid repository within 1-2 weeks
5. Users can then install updates automatically through the F-Droid client

## Useful Links

- F-Droid Data Repository: https://gitlab.com/fdroid/fdroiddata
- F-Droid Inclusion Policy: https://f-droid.org/docs/Inclusion_Policy/
- F-Droid Build Metadata: https://f-droid.org/docs/Build_Metadata_Reference/
- F-Droid Forum: https://forum.f-droid.org/

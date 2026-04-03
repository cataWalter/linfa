# F-Droid Submission for Linfa

## App Details

- **Name:** Linfa
- **Summary:** Track your houseplants, set reminders, and observe growth
- **Source Code:** https://github.com/cataWalter/linfa
- **License:** MIT
- **Category:** Reading
- **Issue Tracker:** https://github.com/cataWalter/linfa/issues
- **Changelog:** https://github.com/cataWalter/linfa/releases

## Why this app?

Houseplants need regular care: watering, fertilizing, repotting, leaf cleaning. Existing apps like Planta, Blossom, and PictureThis are freemium with paywalls (€25-30/year), require accounts, and store data on their servers.

Linfa is different:
- 100% free - no paywalls, no subscriptions
- Open source - code is transparent
- Privacy-first - all data stays on device, no account required
- Offline-first - works without internet connection

## F-Droid Readiness Checklist

- [x] Open source license (MIT)
- [x] Source code publicly available on GitHub
- [x] No proprietary dependencies (google_fonts removed, fonts bundled locally)
- [x] No tracking or analytics
- [x] No proprietary services required
- [x] Fastlane metadata structure prepared
- [x] Build configuration updated for reproducible builds
- [x] App icon included (512x512)
- [ ] Screenshots (to be added after first build)

## Build Instructions

The app is built with Flutter. Build recipe for F-Droid:

```yaml
Categories:
  - Reading
License: MIT
AuthorName: Linfa Contributors
SourceCode: https://github.com/cataWalter/linfa
IssueTracker: https://github.com/cataWalter/linfa/issues
Changelog: https://github.com/cataWalter/linfa/releases

AutoName: Linfa

RepoType: git
Repo: https://github.com/cataWalter/linfa.git

Builds:
  - versionName: "1.0.0"
    versionCode: 1
    commit: "?"
    subdir: android
    sudo:
      - apt-get update
      - apt-get install -y openjdk-17-jdk-headless
    output: app/build/outputs/flutter-apk/app-release.apk
    srclibs:
      - Flutter@3.24.0
    prebuild:
      - export FLUTTER_ROOT=$$Flutter$$
      - export PATH=$$Flutter$$/bin:$PATH
      - flutter config --no-analytics
      - flutter pub get
    build:
      - flutter build apk --release
    ndk: r26

AutoUpdateMode: Version
UpdateCheckMode: Tags
UpdateCheckData: "pubspec.yaml|version:\\s.*\\+(\\d+)|.|version:\\s(\\d+\\.\\d+\\.\\d+)\\+"
CurrentVersion: "1.0.0"
CurrentVersionCode: 1
```

## Notes

- The app uses Isar database which bundles precompiled native binaries. F-Droid may require verification of this dependency.
- All fonts are bundled locally (Roboto, OFL license) - no network access required for fonts.
- No Google Play Services or Firebase dependencies.
- All data stored locally on device.

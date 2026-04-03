# Linfa - Il Tuo Assistente per le Piante Domestiche

<div align="center">

![Linfa Banner](assets/images/banner.png)

**The most advanced open-source plant care companion**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-blue.svg)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/cataWalter/linfa.svg)](https://github.com/cataWalter/linfa/stargazers)

[Download](#download) • [Features](#features) • [Screenshots](#screenshots) • [Documentation](#documentation) • [Contributing](#contributing)

</div>

---

## 🌿 Overview

Linfa is a **premium, feature-rich** mobile application for tracking and caring for your houseplants. Built with Flutter, it combines cutting-edge technology with beautiful design to create the ultimate plant parent experience.

### Why Linfa?

While other plant apps lock essential features behind paywalls (€25-30/year), require accounts, and store your data on their servers, Linfa offers:

- ✨ **100% Free** - No subscriptions, no paywalls, no premium features
- 🔒 **Privacy-First** - All data stays on your device
- 🌍 **Offline-First** - Works without internet
- 📱 **Cross-Platform** - One app for all your devices
- 🎨 **Beautiful Design** - Material 3 with smooth animations
- 🏆 **Industry-Leading Features** - Gamification, AI, analytics & more

---

## 🚀 Industry-Leading Features

### 🎯 Core Features

| Feature | Description |
|---------|-------------|
| **Plant Tracking** | Add unlimited plants with photos, species, location, and detailed care info |
| **Smart Reminders** | Customizable notifications for watering, fertilizing, repotting, and more |
| **Growth Timeline** | Document your plant's journey with photos and notes over time |
| **Care Guides** | Comprehensive database with detailed care instructions for 100+ plant species |
| **Weather Integration** | Smart care recommendations based on local weather conditions |
| **Export/Import** | Full data portability with JSON backup and restore |

### 🏆 Gamification System

Linfa makes plant care fun and rewarding:

- **Experience Points (XP)** - Earn XP for every care action
- **Level System** - Progress from Seedling to Plant Deity (15 levels)
- **Achievements** - 30+ achievements across 8 categories
- **Streaks** - Track daily care streaks and build habits
- **Badges** - Collect special badges for milestones

### 📊 Advanced Analytics

Get deep insights into your plant care:

- **Overview Dashboard** - Quick stats at a glance
- **Care Statistics** - Track watering, fertilizing, and growth tracking activity
- **Achievement Progress** - See your progress towards all achievements
- **Weather Insights** - Smart recommendations based on weather patterns
- **Trends** - Visualize your care patterns over time

### 🌤️ Weather Integration

Smart care adjustments based on real-time weather:

- **Automatic Watering Adjustments** - Extend intervals during rainy weather
- **Humidity Alerts** - Get notified when humidity is too high or low
- **Temperature Warnings** - Protect plants from freezing or extreme heat
- **Light Recommendations** - Adjust plant placement based on cloud cover

### ♿ Accessibility Features

Linfa is designed for everyone:

- **Screen Reader Support** - Full VoiceOver and TalkBack compatibility
- **High Contrast Mode** - Enhanced visibility for visually impaired users
- **Reduced Motion** - Respect users who prefer minimal animations
- **Haptic Feedback** - Tactile responses for important actions
- **Large Touch Targets** - Easy-to-tap buttons and controls

### 🌍 Multi-Language Support

- Italian (Italiano) - Default
- English (English)
- Expandable to 10+ languages

---

## 📱 Screenshots

<div align="center">

| Home Screen | Plant List | Analytics |
|-------------|------------|-----------|
| ![Home](assets/images/home.png) | ![Plants](assets/images/plants.png) | ![Analytics](assets/images/analytics.png) |

| Plant Detail | Reminders | Settings |
|--------------|-----------|----------|
| ![Detail](assets/images/detail.png) | ![Reminders](assets/images/reminders.png) | ![Settings](assets/images/settings.png) |

</div>

---

## 🛠️ Technology Stack

### Core Framework
- **Flutter 3.x** - Cross-platform framework by Google
- **Dart 3.x** - Modern, type-safe language with pattern matching

### State Management
- **Riverpod** - Compile-safe, reactive state management
- **GoRouter** - Declarative routing with deep linking

### Data & Storage
- **Isar** - Fast, type-safe NoSQL database
- **Hive** - Lightweight key-value storage for preferences
- **SQLite** - Optional relational database support

### Notifications
- **flutter_local_notifications** - Native local notifications
- **timezone** - Timezone-aware scheduling

### Media
- **image_picker** - Camera and gallery access
- **image** - Image processing and manipulation
- **path_provider** - Cross-platform file paths

### UI/UX
- **Material 3** - Modern design system
- **flutter_animate** - Declarative animations
- **responsive_framework** - Adaptive layouts
- **lucide_icons** - Beautiful, consistent icons

### Quality & Testing
- **very_good_analysis** - Strict linting rules
- **mockito** - Mock generation for testing
- **flutter_test** - Official testing framework
- **integration_test** - End-to-end testing

---

## 📁 Project Structure

```
linfa/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── app.dart                     # Main app configuration
│   │
│   ├── core/                        # Core functionality
│   │   ├── constants/
│   │   │   ├── colors.dart          # Color palette
│   │   │   ├── strings.dart         # Localized strings
│   │   │   ├── routes.dart          # Route definitions
│   │   │   └── enums.dart           # Shared enums
│   │   ├── theme/
│   │   │   ├── light.dart           # Light theme
│   │   │   ├── dark.dart            # Dark theme
│   │   │   └── typography.dart      # Typography system
│   │   ├── utils/
│   │   │   ├── date.dart            # Date utilities
│   │   │   ├── image.dart           # Image utilities
│   │   │   └── export.dart          # Export utilities
│   │   └── services/
│   │       ├── error_handler.dart   # Error handling & logging
│   │       ├── accessibility_service.dart # Accessibility features
│   │       └── weather_service.dart # Weather integration
│   │
│   ├── data/                        # Data layer
│   │   ├── models/
│   │   │   ├── plant.dart           # Plant model
│   │   │   ├── plant_care_guide.dart # Care guide model
│   │   │   ├── reminder.dart        # Reminder model
│   │   │   ├── growth_entry.dart    # Growth entry model
│   │   │   └── achievement.dart     # Gamification models
│   │   ├── repositories/
│   │   │   ├── plant_repository.dart
│   │   │   └── reminder_repository.dart
│   │   └── database/
│   │       └── database.dart        # Database setup
│   │
│   ├── features/                    # Feature screens
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   ├── plants/
│   │   │   ├── plant_list_screen.dart
│   │   │   ├── plant_detail_screen.dart
│   │   │   ├── add_plant_screen.dart
│   │   │   ├── edit_plant_screen.dart
│   │   │   └── widgets/
│   │   ├── reminders/
│   │   │   ├── reminder_list_screen.dart
│   │   │   ├── add_reminder_screen.dart
│   │   │   └── widgets/
│   │   ├── growth/
│   │   │   ├── growth_timeline_screen.dart
│   │   │   └── widgets/
│   │   ├── analytics/
│   │   │   └── analytics_screen.dart # Advanced analytics
│   │   └── settings/
│   │       └── settings_screen.dart
│   │
│   └── shared/                      # Shared components
│       ├── providers/
│       │   ├── plant_provider.dart
│       │   ├── reminder_provider.dart
│       │   ├── theme_provider.dart
│       │   ├── notification_provider.dart
│       │   └── gamification_provider.dart
│       └── widgets/
│           ├── empty_state.dart
│           ├── photo_picker.dart
│           └── reminder_picker.dart
│
├── assets/
│   ├── images/                      # Static images
│   ├── icons/                       # Custom icons
│   ├── fonts/                       # Custom fonts
│   └── plant_types/
│       └── plant_types.json         # Plant database
│
├── test/                            # Unit & widget tests
├── integration_test/                # E2E tests
└── pubspec.yaml                     # Dependencies
```

---

## 🚀 Quick Start

### Prerequisites

- Flutter SDK 3.x or higher
- Dart 3.x or higher
- Android Studio / Xcode (for emulators)
- A physical device (for notification testing)

### Installation

```bash
# Clone the repository
git clone https://github.com/cataWalter/linfa.git
cd linfa

# Install dependencies
flutter pub get

# Generate code (if needed)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# macOS
flutter build macos --release

# Windows
flutter build windows --release
```

---

## 📖 Usage Guide

### 1. Add Your First Plant

1. Tap the **+** button on the home screen
2. Take a photo or choose from gallery
3. Enter plant name and select species
4. Set location (room) and light conditions
5. Configure care reminders

### 2. Set Up Reminders

1. Go to a plant's detail screen
2. Tap **Add Reminder**
3. Choose reminder type (watering, fertilizing, etc.)
4. Set frequency and time
5. Enable notifications

### 3. Track Growth

1. Open a plant's detail screen
2. Tap **Growth Timeline**
3. Add photos and notes regularly
4. Watch your plant's journey over time

### 4. Earn Achievements

- Water plants to earn **Watering** achievements
- Add more plants for **Collection** achievements
- Maintain daily streaks for **Streak** achievements
- Track growth for **Care** achievements

### 5. Export Your Data

1. Go to **Settings**
2. Tap **Export Data**
3. Choose format (JSON)
4. Share or save your backup

---

## 🌱 Plant Database

Linfa includes a comprehensive database of common houseplants:

| Plant | Watering | Light | Difficulty |
|-------|----------|-------|------------|
| Pothos | Every 7-10 days | Indirect | Easy |
| Monstera | Every 7 days | Bright indirect | Easy |
| Sansevieria | Every 14-21 days | Any | Very Easy |
| Ficus | Every 7-10 days | Bright indirect | Medium |
| Succulents | Every 14-21 days | Direct | Easy |
| Fern | Every 3-5 days | Indirect | Medium |

### Adding Custom Plants

Edit `assets/plant_types/plant_types.json`:

```json
{
  "id": "monstera_deliciosa",
  "common_name": "Monstera",
  "scientific_name": "Monstera deliciosa",
  "family": "Araceae",
  "difficulty": "easy",
  "watering": {
    "frequency_days": 7,
    "method": "Water when top 2 inches of soil are dry",
    "signs": ["Drooping leaves", "Dry soil"]
  },
  "light": {
    "type": "indirectBright",
    "hours_per_day": 6,
    "description": "Bright, indirect light"
  },
  "humidity": {
    "level": "medium",
    "percentage": 50
  },
  "temperature": {
    "min_celsius": 18,
    "max_celsius": 27
  }
}
```

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/models/plant_test.dart

# Run widget tests
flutter test test/widget/

# Run integration tests
flutter test integration_test/

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Test Coverage Goals

- Unit Tests: 90%+
- Widget Tests: 85%+
- Integration Tests: Key user flows

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Ways to Contribute

1. **Add Plant Types** - Expand our plant database
2. **Improve UI/UX** - Suggest design improvements
3. **Translate** - Help localize to more languages
4. **Test** - Report bugs and suggest features
5. **Code** - Submit pull requests for new features

### Development Workflow

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Run `dart format lib/` before committing
- Run `flutter analyze` to check for issues
- Write tests for new features

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Icons** - [Lucide Icons](https://lucide.dev/)
- **Fonts** - [Google Fonts](https://fonts.google.com/)
- **Inspiration** - The r/houseplants community
- **Testing** - Golden tests inspired by Flutter's best practices

---

## 📞 Support

- **Issues** - [GitHub Issues](https://github.com/cataWalter/linfa/issues)
- **Discussions** - [GitHub Discussions](https://github.com/cataWalter/linfa/discussions)
- **Email** - (coming soon)

---

## 🗺️ Roadmap

### Completed ✅

- [x] Core plant tracking
- [x] Reminder system with notifications
- [x] Growth timeline
- [x] Export/Import functionality
- [x] Dark/Light themes
- [x] Error handling system
- [x] Accessibility features
- [x] Gamification system
- [x] Advanced analytics
- [x] Weather integration
- [x] Achievement system

### In Progress 🚧

- [ ] AI-powered plant identification
- [ ] Disease detection from photos
- [ ] Community features (optional)
- [ ] Cloud backup (encrypted, optional)

### Planned 📋

- [ ] Widget for home screen
- [ ] Apple Watch / Wear OS support
- [ ] Plant sharing via QR codes
- [ ] Multi-user support
- [ ] 10+ language support
- [ ] Tablet optimization
- [ ] Foldable device support

---

<div align="center">

**Made with ❤️ for plant lovers everywhere**

[⭐ Star this repo](https://github.com/cataWalter/linfa) • [🍴 Fork](https://github.com/cataWalter/linfa/fork) • [📢 Share](https://github.com/cataWalter/linfa)

</div>
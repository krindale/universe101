# Universe101 🌌

An educational Flutter app for exploring the cosmos - planets, space phenomena, and exploration history.

## Features

- 🪐 Interactive 3D planet models
- 🌟 Cosmic phenomena exploration
- 🚀 Space exploration timeline
- 📚 Educational learning cards
- 🎨 Immersive dark theme with cosmic aesthetics
- 💾 Local favorites and progress tracking

## Getting Started

### Prerequisites

- Flutter SDK (>=3.9.2)
- Dart SDK
- Firebase project (optional for cloud features)

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd universe101
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase (Optional)

The app includes demo Firebase configuration. For production use:

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure --project=your-project-id
```

This will generate a new `lib/firebase_options.dart` file with your Firebase credentials.

4. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/                   # Data models
│   └── celestial_body.dart
├── screens/                  # UI screens
│   └── home_screen.dart
└── theme/                    # App theming
    └── app_theme.dart
```

## Dependencies

### Core
- `firebase_core` - Firebase integration
- `cloud_firestore` - Cloud database
- `provider` - State management

### Local Storage
- `sqflite` - Local SQLite database
- `shared_preferences` - User preferences
- `path_provider` - File system paths

### UI & Media
- `model_viewer_plus` - 3D model rendering
- `cached_network_image` - Image caching
- `flutter_svg` - SVG support
- `google_fonts` - Custom fonts

## Testing

Run tests with:
```bash
flutter test
```

Run analyzer:
```bash
flutter analyze
```

## Building

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

### Web
```bash
flutter build web
```

## Firebase Setup (Production)

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Firestore Database
3. Run `flutterfire configure` to generate platform-specific configs
4. Update Firebase rules for production security

## License

This project is licensed under the MIT License.

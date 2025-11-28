# BookSwap - Flutter Firebase App

A Flutter application for book swapping with real-time features using Firebase.

## Architecture

This app follows Clean Architecture principles with:

```
lib/
├── data/
│   ├── models/          # Data models with JSON serialization
│   └── repositories/    # Data access layer
├── domain/
│   ├── entities/        # Business entities
│   └── usecases/        # Business logic
└── presentation/
    ├── screens/         # UI screens
    ├── widgets/         # Reusable widgets
    └── providers/       # State management (Provider)
```

## Features Implemented

### ✅ Phase 1: Project Setup & Authentication
- [x] Clean architecture folder structure
- [x] Firebase integration setup
- [x] Provider state management
- [x] User authentication (login/signup)
- [x] Email verification enforcement

### 🚧 In Progress
- [ ] Book listings CRUD
- [ ] Swap functionality
- [ ] Navigation structure
- [ ] Settings page
- [ ] Real-time chat (bonus)

## Setup Instructions

1. Clone the repository
2. Run `flutter pub get`
3. Configure Firebase (add your own config files)
4. Run the app with `flutter run`

## Firebase Configuration

You'll need to add your own Firebase configuration files:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

## State Management

Using Provider for state management with the following providers:
- `AuthProvider`: Handles authentication state and operations
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

### ✅ Phase 2: Complete Authentication & Navigation
- [x] Signup screen with validation
- [x] Email verification screen
- [x] Bottom navigation structure
- [x] Settings page with profile & toggles
- [x] Main app navigation flow

### ✅ Phase 3: Book Listings CRUD
- [x] Book repository with Firebase operations
- [x] Book provider for state management
- [x] Add book screen with image upload
- [x] Browse books with real-time updates
- [x] My listings with delete functionality
- [x] Image picker and Firebase Storage

### ✅ Phase 4: Swap Functionality
- [x] Swap entities and models
- [x] Swap repository with batch operations
- [x] Swap provider for state management
- [x] Real-time swap requests
- [x] Book status updates (available → pending)
- [x] My Offers screen with status tracking
- [x] Swap button on browse screen

### ✅ Phase 5: Real-time Chat (Bonus)
- [x] Chat entities and models
- [x] Chat repository with message operations
- [x] Chat provider for state management
- [x] Real-time chat list screen
- [x] Chat detail screen with messaging
- [x] Auto-chat creation on swap requests
- [x] Message timestamps and user identification

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
- `BookProvider`: Manages book CRUD operations and image uploads
- `SwapProvider`: Handles swap requests and real-time updates
- `ChatProvider`: Manages real-time chat functionality
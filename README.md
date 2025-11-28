# BookSwap App

Hello! This is my book exchange app. Basically, you can list your old books and swap them with other students instead of buying expensive new ones.

## What it does

- **Sign up & Login**: Create an account with email verification.
- **List your books**: Take a photo, add title/authorand pick its condition.
- **Browse books**: See what other students are offering.
- **Request swaps**: Found a book you need? click that swap button.
- **Chat**: Talk to the book owner to arrange the exchange.
- **Manage requests**: Accept or reject swap offers from others.

## Architecture Diagram


## Database Schema

### Firestore Collections:
- `users/{userId}` - User profiles and settings
- `books/{bookId}` - Book listings with metadata
- `swaps/{swapId}` - Swap requests and status
- `chats/{chatId}` - Chat conversations
  - `messages/{messageId}` - Individual chat messages

## Build Instructions

1. **Clone Repository**
   ```bash
   git clone [your-repo-url]
   cd bookswap
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create project at https://console.firebase.google.com
   - Enable Authentication (Email/Password)
   - Create Firestore database
   - Enable Storage for images
   - Run `flutterfire configure`
   - Add configuration files:
     - `android/app/google-services.json`
     - `ios/Runner/GoogleService-Info.plist`
     - `lib/firebase_options.dart`

4. **Run Application**
   ```bash
   flutter run
   ```

## State Management Implementation

**Library Used:** Provider Pattern

**Providers:**
- `AuthProvider`: Authentication state, login/logout operations
- `BookProvider`: Book CRUD operations, image uploads to Firebase Storage
- `SwapProvider`: Swap request management, real-time status updates
- `ChatProvider`: Real-time messaging with Firestore streams

**Benefits:**
- Reactive UI updates
- Separation of business logic from UI
- Real-time synchronization with Firebase
- Clean dependency injection

## Technology Stack

- **Flutter** - Cross-platform mobile framework
- **Firebase Auth** - User authentication with email verification
- **Firestore** - Real-time NoSQL database for books, swaps, messages
- **Firebase Storage** - Image storage for book covers
- **Provider** - State management for reactive UI

## Clean Architecture

The app follows clean architecture principles with clear separation:
- **Presentation**: UI screens and state management
- **Domain**: Business entities and use cases
- **Data**: Models and repository implementations

<img width="3323" height="2392" alt="image" src="https://github.com/user-attachments/assets/84ac6bc1-1720-40b0-8101-a25a8e1b5ada" />


## Features Implemented

✅ **Authentication**: Email/password signup, login, logout with verification
✅ **Book CRUD**: Create, read, update, delete book listings
✅ **Real-time Sync**: Instant updates using Firestore streams
✅ **Swap System**: Request swaps with status tracking
✅ **Navigation**: Bottom navigation with 4 main screens
✅ **Chat System**: Real-time messaging between users
✅ **Settings**: Profile management and notification toggles

**Done by:** Cannelle Mwiza

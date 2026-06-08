# jomlayanz

A cross-platform OTT / video streaming application built with Flutter. jomlayanz lets
users browse and watch movies, TV shows, live TV channels and playlists, manage
subscriptions and rentals, download content for offline viewing, and personalize
their experience across Android, iOS, macOS and the web.

## Features

- **Browse & discover** — home feed with movies, TV shows, TV channels, top artists and blogs, plus full search and "view all" listings.
- **Video playback** — dedicated players for movies, TV shows, playlists and live TV (powered by `better_player_plus`, `video_player`, `flick_video_player` and `youtube_player_flutter`).
- **Authentication** — email/password sign in & sign up, phone sign-in with OTP, Google Sign-In, forgot/reset password, and interest selection onboarding.
- **Subscriptions & payments** — subscription plans and in-app purchases via RevenueCat (`purchases_flutter`) and Stripe (`flutter_stripe`), payment history and rentals.
- **Profile management** — edit profile, change password, favorites, playlists, downloads, notifications, language selection, FAQ and contact us.
- **Offline downloads** — download videos for offline viewing.
- **Monetization** — in-app advertising via Google Mobile Ads.
- **Localization** — multi-language support through GetX translations.

## Tech Stack

- **Framework:** Flutter (Dart SDK `>=3.4.1 <4.0.0`)
- **State management & routing:** GetX (`get`)
- **Networking:** `dio` / `http`
- **Responsive UI:** `flutter_screenutil`
- **Config:** `flutter_dotenv` (environment files)
- **Payments:** `flutter_stripe`, `purchases_flutter` (RevenueCat)
- **Ads:** `google_mobile_ads`

## Project Structure

```
lib/
├── main.dart            # App entry point
├── controllers/         # GetX controllers (auth, home, payment, profile, video_player, common)
├── screens/             # UI screens (auth, home, intro, profile, video_player, widgets)
├── models/              # Data models
├── services/            # API & purchase services
├── widgets/             # Reusable widgets
├── helpers/             # Helper utilities (e.g. ads)
├── language/            # Localization strings
└── utils/               # Constants, environment & utility functions
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart `>=3.4.1`)
- Android Studio / Xcode for platform builds

### Setup

1. Clone the repository:

   ```bash
   git clone <repo-url>
   cd jomlayanz
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Configure environment variables. Copy `.env.example` and fill in your values:

   ```bash
   cp .env.example .env
   ```

   ```env
   Base_Url = ''
   Api_Url = ''
   Image_Base_Url = ''
   ApiKey = ''
   ```

   The active env file is selected via `Environment.fileName` (`.env`, `.env.dev`).

4. Run the app:

   ```bash
   flutter run
   ```

## Supported Platforms

Android · iOS · macOS · Web

## License

This project is proprietary. All rights reserved.

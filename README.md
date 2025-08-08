# Chargebee Demo (Flutter)

Minimal demo to confirm a user's subscription status (mocked) using:
- Flutter + Riverpod (codegen) + Freezed + json_serializable
- Feature-first structure
- Happy-path widget tests and manual confirmation

Quick start:
- flutter pub get
- dart run build_runner build -d --delete-conflicting-outputs
- flutter test test/patrol_widget_test.dart test/screenshot_smoke_test.dart -r expanded
- flutter run (manual confirmation)

Configuration (env variables):
- For live integration later, set CHARGEBEE_API_KEY and CHARGEBEE_SITE via env or --dart-define.
  Example:
  flutter run --dart-define=CHARGEBEE_SITE=njwpoc-test --dart-define=CHARGEBEE_API_KEY=env:CHARGEBEE_API_KEY

See setup.md for environment setup instructions.

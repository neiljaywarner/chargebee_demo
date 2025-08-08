# DITL Monitoring
Timestamp (GPT-5): 2025-08-08 20:21Z

Manual confirmation steps (UI):
- Launch app (flutter run)
- Type sub_123456789 in Subscription ID field
- Tap "Check Subscription"
- Expect a card showing "Status: active" and a verified icon

Optional parallel checks (once ready):
- Widget tests (focused): flutter test test/patrol_widget_test.dart test/screenshot_smoke_test.dart -r expanded
- Maestro (short run): maestro test .maestro/flows/subscription_check.yaml
- ADB screenshots/videos (optional RECORD=1): RECORD=1 bash scripts/run_e2e.sh

Questions/Concerns (Please review first):
- Provide Chargebee API key when ready; I will wire via env var and --dart-define.
- Confirm appId/bundleId preference (currently com.example.chargebee_demo). Do you want com.njw.chargebee_demo?
- Network mocking choice: ✅ You confirmed proceeding with Fake Dio first; Charlatan remains an option.

Progress Log:
- 🚀 Created Flutter project and added dependencies
- ✅ Implemented Subscription model (Freezed/JSON)
- ✅ Implemented local mock repository reading assets JSON
- ✅ Built Riverpod AsyncNotifier controller and UI screen
- 🚧 Added BDD feature/test and Maestro flow (wip)
- ✅ Wrote planning and mocking docs

Next Steps:
- Add codegen files by running build_runner watch
- Implement Fake Dio adapter and provider override (phase 2)
- Prepare live Dio client and secure auth (phase 3)

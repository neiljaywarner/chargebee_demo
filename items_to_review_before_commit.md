# Items To Review Before Commit

For Human:
- Verify passing widget test locally: `flutter test test/patrol_widget_test.dart -r expanded`
- Inspect screenshots: `artifacts/screenshots/maestro_before.png`, `maestro_after.png`
- (Optional) Watch the local video recording in `artifacts/videos/`
- Confirm README/setup docs are accurate
- Scan atomic_commits.md and network_call_mocking.md for next steps

For LLM (backup to GPT-5): Claude 3.7 Sonnet
Prompt:
"You are reviewing a Flutter MVP for verifying a Chargebee subscription status. The MVP uses Riverpod, Freezed, and a local mock repo, with widget tests for proof. Maestro flows capture before/after screenshots and optional local video. Please review for: simplicity, testability, clarity of docs, and risk areas for next steps (Fake Dio near-the-wire mock). Suggest concrete improvements without overcomplicating Commit 1. Output Good/Bad/Ugly and a prioritized checklist for Commit 2."

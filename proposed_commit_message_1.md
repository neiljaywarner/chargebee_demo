feat(core): finalize Commit 1 (MVP, tests, and docs)

- Simplify app: remove router for now; direct home: SubscriptionScreen
- Feature-first screen and constants (no magic subscription IDs)
- Passing happy-path widget test; optional Maestro flow in maestro/
- Scripts for emulator and test orchestration; help and usage docs
- Public maestro dir with README and setup; CI/FTL TODOs stubbed
- Architecture, BDD process notes, and session summaries updated
- Parked items moved to todo_llm_prompts.md (custom_lint, broader BDD)

Proof before commit:
- Manual confirmation passes (input sub_demo_default e Check Subscription e Status: active)
- Widget test passes: test/patrol_widget_test.dart
- Maestro flow compiles and runs; final assert pending minor timing tweak


# Plan (Aug 8, 3:10–4:50pm CT) — Chargebee Demo POC
Timestamp (GPT-5): 2025-08-08 15:21 CT

Goals:
- Demo -> POC -> MVP path for Chargebee subscription verification
- Black-box tests pass at every atomic commit (BDD, Maestro optional, adb screenshots fallback)
- Architecture: repository -> controller (Riverpod AsyncNotifier codegen) -> UI

Scope today (timebox 100 minutes):
1) Commit 1 — UI + domain + controller, no networking
   - Add Freezed model (Subscription)
   - Local mock repository reading assets/mock/subscription_active.json
   - Riverpod AsyncNotifier controller + simple screen with input and result
   - BDD test green
2) Commit 2 — Near-the-wire mocking
   - Introduce Fake Dio adapter that returns saved JSON by path
   - Keep repository interface; swap implementation via provider override
   - Document choice in network_call_mocking.md
   - Add Maestro flow; ensure tooltip/keys for selectors
3) Commit 3 — Live sandbox integration (read-only retrieve)
   - Wire Dio to https://njwpoc-test.chargebee.com/api/v2/subscriptions/{id}
   - Auth via basic auth using API key in env var (no plaintext in repo)
   - Toggle via --dart-define or Riverpod provider overrides
   - Black-box test for happy path (may mock when running CI), manual run for live

Stretch (if time remains):
- Add login stub screen with email field (non-auth) before subscription check
- Add error handling states (404/401/rate limit) and corresponding tests
- Video script draft for TikTok/Shorts

Deliverables today:
- Working Flutter app with mocked subscription check
- bdd_widget_test feature and test
- Maestro script
- Docs: network_call_mocking.md, ditl_monitoring.md, prompt_history.md, atomic_commits.md

Risks/Assumptions:
- Chargebee sandbox availability and key setup
- Time to configure Maestro on local machine
- Codegen runs on dev machine (build_runner)

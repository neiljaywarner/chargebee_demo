# Atomic Commits Plan
Timestamp (GPT-5): 2025-08-08 15:21 CT

1) ✅ feat(core): init app with Riverpod + Freezed + UI skeleton (no networking)
   - 🚀 Add Subscription model (freezed) and local asset mock repository
   - ✅ Add controller and simple screen to verify subscription id
   - 🚧 Add BDD feature/test and Maestro flow

2) ⏳ feat(network-mock): add Fake Dio adapter + provider override
   - Map GET /api/v2/subscriptions/{id} to assets JSON
   - Document approach in network_call_mocking.md

LLM prompt for Atomic Commit 2:
"Implement a near-the-wire network mocking layer using Dio so we can flip between local JSON and real HTTP with minimal code changes.
Requirements:
- Create a FakeDioHttpClientAdapter that intercepts GET /api/v2/subscriptions/{id} and serves assets/mock/subscription_{id}.json if present; otherwise serve assets/mock/subscription_active.json by default.
- Add a dioClientProvider in core/network/dio_client.dart with two implementations: fake (default for tests/dev), and live (baseUrl from CHARGEBEE_SITE dart-define, Basic auth using CHARGEBEE_API_KEY from env or dart-define; do NOT log secrets).
- Update subscription_repository to accept a Dio (or an abstract ApiClient) and parse the envelope {"subscription": {...}} into the thin Freezed model.
- Add a small smoke test that flips to fake-dio and verifies the controller returns active status.
- Keep BDD and Maestro optional; do not block if they fail.
- Update README with a section on toggling mock/live via --dart-define and provider overrides."

3) ⏳ feat(network-live): wire Dio to Chargebee sandbox (retrieve subscription)
   - Basic auth via API key from env var
   - Add configuration via --dart-define and provider layers

4) 🔧 chore(ci/docs): stabilize tests, add screenshots script (adb) fallback
   - If Maestro flaky, capture adb screenshots as evidence

# Network Call Mocking Choice
Timestamp (GPT-5): 2025-08-08 20:21Z

Decision: Start with "Fake Dio" returning saved JSON files (near-the-wire), inspired by Riverpod's fake_marvel example.

Why not Charlatan (for now)?
- Pros of Charlatan:
  - Declarative mock routes, easy to script varied responses
  - Great for quickly simulating complex APIs
- Cons for this POC:
  - Another dependency and DSL to learn
  - Slightly further from real wire format/headers

Why Fake Dio?
- Pros:
  - Uses the same request layer (Dio) as production
  - Easy to plug via custom HttpClientAdapter/interceptor
  - Serves exact saved JSON payloads that mirror Chargebee v2 responses
  - Minimal surface-area difference between mock and live
- Cons:
  - Requires writing a small adapter and keeping JSON files updated

Plan:
- Phase 1: Local repository reads assets JSON (already implemented)
- Phase 2: Introduce FakeDioHttpClientAdapter that maps GET /api/v2/subscriptions/{id} -> assets/mock/subscription_*.json
- Tests: bdd_widget_test stays black-box; we override repository/provider for mock/live as needed.

Agreement (Neil): ✅ Agree to proceed with Fake Dio approach for near-the-wire mocking today. We can revisit Charlatan later if needed.

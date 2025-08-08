# BDD Process Notes

Current approach:
- Focus first on happy-path widget tests for speed and reliability.
- Maestro used as an optional device-level check (few seconds flow).
- Screenshots generated via widget tests for deterministic proof.

What works well:
- Widget tests are fast and deterministic (no emulator/simulator).
- Maestro text selectors (labelText/button text) are robust.

What’s challenging:
- bdd_widget_test requires glue + build_runner; can slow iteration.
- Android emulators are heavier; iOS simulators are typically faster.

Plan:
- Prefer iOS Simulator for device screenshots/videos when we add device flows.
- Keep Maestro short; assert visible text for success.
- Broaden BDD after near-the-wire mock is added.

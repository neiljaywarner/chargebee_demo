# Under the Hood: Discussion Points

- Custom logger wrapper (Log.d / Log.i / Log.w / Log.e) built on top of package:logger.
  - kDebugMode-gated so release builds don’t emit logs.
  - Timestamps enabled for easier auditing.
- Lint: enforce no debugPrint usage
  - Implemented via a custom_lint plugin (see tools/chargebee_demo_lints) that flags any debugPrint invocation.
  - Rationale: centralized logging allows filtering, redaction, and consistent formatting.
- GoRouter adoption
  - Even with a single route today, sets us up for adding a login flow or settings later without churn.

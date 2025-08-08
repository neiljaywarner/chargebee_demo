# Architecture

This project follows a feature-first structure, inspired by codewithandrea.com best practices and Riverpod codegen.

- lib/
  - features/
    - subscription/
      - subscription.dart (Freezed data class + JSON)
      - subscription_repository.dart (Repository interface + provider)
      - subscription_controller.dart (AsyncNotifier controller)
      - subscription_screen.dart (UI)
  - main.dart (ProviderScope + app)

Key points:
- Riverpod generators (@riverpod) produce typed providers in *.g.dart files.
- Freezed + json_serializable provide immutable models and robust JSON mapping.
- UI depends on controller (AsyncValue), controller depends on repository, repository provides data.

Mermaid diagram:
```mermaid
digraph G {
  rankdir=LR;
  UI["SubscriptionScreen"] -> Controller["SubscriptionController (AsyncNotifier)"];
  Controller -> Repo["SubscriptionRepository (provider)"];
  Repo -> Data["Local JSON (assets/mock/subscription_active.json)"];
}
```

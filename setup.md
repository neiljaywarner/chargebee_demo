# Setup

1) Flutter deps
- Install Flutter SDK
- flutter pub get
- dart run build_runner build -d --delete-conflicting-outputs

2) Env variables (zsh)
- Open ~/.zshrc and add:
  export CHARGEBEE_SITE=njwpoc-test
  export CHARGEBEE_API_KEY=sk_test_xxx
- Reload shell: source ~/.zshrc

3) Chargebee sandbox
- Create a Chargebee sandbox at https://www.chargebee.com/
- In the sandbox, generate an API key with read access
- Note your site subdomain (e.g., njwpoc-test)

4) Running the app
- flutter run
- Manual confirmation steps are documented at top of ditl_monitoring.md

Later (Phase 3):
- We will use these env vars to call Chargebee REST API via Dio.

#!/usr/bin/env bash
set -euo pipefail

# Record a local video of the Maestro flow and capture screenshots inside the flow.
# Usage:
#   scripts/maestro_record.sh [-h]
# Env:
#   APP_ID        Android app id (default: com.example.chargebee_demo)
#   ARTIFACTS_DIR Artifacts dir (default: artifacts)
#   FLOW          Flow to run (default: maestro/flows/subscription_check.yaml)

usage() {
  cat <<'EOF'
Usage: scripts/maestro_record.sh [options]
Options:
  -h, --help    Show help
Env:
  APP_ID        Android app id (default: com.example.chargebee_demo)
  ARTIFACTS_DIR Artifacts dir (default: artifacts)
  FLOW          Maestro flow to run (default: maestro/flows/subscription_check.yaml)
EOF
}

for arg in "$@"; do
  case "$arg" in
    -h|--help)
      usage
      exit 0
      ;;
  esac
done

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
cd "$PROJECT_DIR"

APP_ID="${APP_ID:-com.example.chargebee_demo}"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-artifacts}"
FLOW="${FLOW:-maestro/flows/subscription_check.yaml}"

mkdir -p "$ARTIFACTS_DIR/videos" "$ARTIFACTS_DIR/logs" "$ARTIFACTS_DIR/screenshots"

# Ensure emulator & app
source "$PROJECT_DIR/scripts/android_helpers.sh"
ensure_emulator_running
uninstall_app_if_present || true
install_app
launch_app

# Before screenshot (safety net in case takeScreenshot fails)
screencap "$ARTIFACTS_DIR/screenshots/maestro_before.png"

# Record locally using Maestro
# Output directory receives a timestamped recording file
maestro record --local "$ARTIFACTS_DIR/videos" "$FLOW" | tee "$ARTIFACTS_DIR/logs/maestro_record.log"

# After screenshot (safety net)
screencap "$ARTIFACTS_DIR/screenshots/maestro_after.png"

echo "Artifacts:"
echo "  - Screenshots: $ARTIFACTS_DIR/screenshots/maestro_before.png, maestro_after.png"
echo "  - Video (local recording dir): $ARTIFACTS_DIR/videos"
echo "  - Logs: $ARTIFACTS_DIR/logs/maestro_record.log"

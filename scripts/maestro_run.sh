#!/usr/bin/env bash
set -euo pipefail

# Run the Maestro happy-path flow. Ensures emulator and app launched first.
# Usage:
#   scripts/maestro_run.sh [-h]
# Env:
#   RECORD=1   Record screen to artifacts/videos/maestro_run.mp4
#   APP_ID     Android app id (default: com.example.chargebee_demo)
#   ARTIFACTS_DIR  Artifacts directory (default: artifacts)

usage() {
  cat <<'EOF'
Usage: scripts/maestro_run.sh [options]
Options:
  -h, --help    Show help
Env:
  RECORD=1      Record screen during Maestro test
  APP_ID        Android app id (default: com.example.chargebee_demo)
  ARTIFACTS_DIR Artifacts dir (default: artifacts)
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
mkdir -p "$ARTIFACTS_DIR/videos" "$ARTIFACTS_DIR/logs" "$ARTIFACTS_DIR/screenshots"

source "$PROJECT_DIR/scripts/android_helpers.sh"

ensure_emulator_running
uninstall_app_if_present || true
install_app
launch_app

# Before screenshot
screencap "$ARTIFACTS_DIR/screenshots/maestro_before.png"

PASS=0
if [[ "${RECORD:-0}" == "1" ]]; then
  start_screen_recording "$ARTIFACTS_DIR/videos/maestro_run.mp4"
fi
set +e
maestro test "$PROJECT_DIR/maestro/flows/subscription_check.yaml" | tee "$ARTIFACTS_DIR/logs/maestro.log"
rc=${PIPESTATUS[0]}
set -e
if [[ "${RECORD:-0}" == "1" ]]; then
  stop_screen_recording || true
fi
# After screenshot regardless of pass/fail
screencap "$ARTIFACTS_DIR/screenshots/maestro_after.png"

if [[ $rc -eq 0 ]]; then
  PASS=1
else
  # If failed and we recorded, keep the video but clearly report failure
  :
fi

if [[ $PASS -eq 1 ]]; then
  echo "Maestro flow passed. Logs: $ARTIFACTS_DIR/logs/maestro.log";
  if [[ -f "$ARTIFACTS_DIR/videos/maestro_run.mp4" ]]; then echo "Video: $ARTIFACTS_DIR/videos/maestro_run.mp4"; fi
  exit 0
else
  echo "Maestro flow failed. See $ARTIFACTS_DIR/logs/maestro.log" >&2
  exit 1
fi

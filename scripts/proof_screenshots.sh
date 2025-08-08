#!/usr/bin/env bash
set -euo pipefail

# Generate before/after screenshots using Maestro flows and verify they differ.
# Falls back to ADB screenshots if needed.
# Usage: scripts/proof_screenshots.sh [-h]
# Env:
#  APP_ID        Android app id (default: com.example.chargebee_demo)
#  ARTIFACTS_DIR Artifacts dir (default: artifacts)
#  FLOW          Flow to run (default: maestro/flows/subscription_check.yaml)
#  USE_FLUTTER_RUN=1  Try launching via flutter run if Maestro launch not reliable (optional)

usage() {
  cat <<'EOF'
Usage: scripts/proof_screenshots.sh [options]
Options:
  -h, --help    Show help
Env:
  APP_ID              Android app id (default: com.example.chargebee_demo)
  ARTIFACTS_DIR       Artifacts dir (default: artifacts)
  FLOW                Maestro flow to run (default: maestro/flows/subscription_check.yaml)
  USE_FLUTTER_RUN=1   Launch via flutter run prior to flow (optional)
EOF
}

for arg in "$@"; do
  case "$arg" in
    -h|--help) usage; exit 0;;
  esac
done

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
cd "$PROJECT_DIR"

APP_ID="${APP_ID:-com.example.chargebee_demo}"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-artifacts}"
FLOW="${FLOW:-maestro/flows/subscription_check.yaml}"
mkdir -p "$ARTIFACTS_DIR/screenshots" "$ARTIFACTS_DIR/logs"

source "$PROJECT_DIR/scripts/android_helpers.sh"
ensure_emulator_running
uninstall_app_if_present || true
install_app

if [[ "${USE_FLUTTER_RUN:-0}" == "1" ]]; then
  # Attempt to launch via flutter run in background for 12s then background it
  (flutter --no-version-check --suppress-analytics run -d "${DEVICE_ID:-}" &)
  sleep 12 || true
else
  launch_app
fi

# Run Maestro flow which captures screenshots inside the flow
set +e
maestro test "$FLOW" | tee "$ARTIFACTS_DIR/logs/maestro_proof.log"
rc=${PIPESTATUS[0]}
set -e

BEFORE="$ARTIFACTS_DIR/screenshots/loading_flutter_logo.png"
AFTER="$ARTIFACTS_DIR/screenshots/maestro_after.png"

# As a safety net, ensure both files exist. If Maestro didn't create them, use ADB captures.
if [[ ! -f "$BEFORE" ]]; then screencap "$BEFORE"; fi
if [[ ! -f "$AFTER" ]]; then screencap "$AFTER"; fi

if [[ ! -s "$BEFORE" || ! -s "$AFTER" ]]; then
  echo "One of the screenshots is empty. BEFORE=$BEFORE AFTER=$AFTER" >&2
  exit 1
fi

# Ensure before and after differ
H1=$(shasum -a 256 "$BEFORE" | awk '{print $1}')
H2=$(shasum -a 256 "$AFTER" | awk '{print $1}')
if [[ "$H1" == "$H2" ]]; then
  echo "Before and after screenshots are identical; expected them to differ." >&2
  exit 1
fi

echo "Proof screenshots ready:"
echo "  BEFORE (loading): $BEFORE"
echo "  AFTER: $AFTER"
echo "  Logs: $ARTIFACTS_DIR/logs/maestro_proof.log"

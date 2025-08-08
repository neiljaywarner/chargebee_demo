#!/usr/bin/env bash
set -euo pipefail

# Simple script: uninstall app, launch via flutter run, then maestro record --local on hello_world flow
# Usage: scripts/simple_maestro.sh

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
cd "$PROJECT_DIR"

APP_ID="${APP_ID:-com.example.chargebee_demo}"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-artifacts}"
FLOW="${FLOW:-maestro/flows/subscription_hello_world.yaml}"
mkdir -p "$ARTIFACTS_DIR/videos" "$ARTIFACTS_DIR/screenshots" "$ARTIFACTS_DIR/logs"

source "$PROJECT_DIR/scripts/android_helpers.sh"
ensure_emulator_running
uninstall_app_if_present || true

# Launch via flutter run (background)
(flutter --no-version-check --suppress-analytics run -d "${DEVICE_ID:-}" &) || true
sleep 12 || true

# Record locally using Maestro
maestro record --local "$ARTIFACTS_DIR/videos" "$FLOW" | tee "$ARTIFACTS_DIR/logs/maestro_simple_record.log"

echo "Simple Maestro recording complete. Check $ARTIFACTS_DIR/videos and screenshots folder."

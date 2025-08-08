#!/usr/bin/env bash
set -euo pipefail

APP_ID="com.example.chargebee_demo"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-artifacts}"

log() { echo "[helpers] $*"; }
warn() { echo "[helpers][WARN] $*" >&2; }

ensure_adb() {
  if ! command -v adb >/dev/null 2>&1; then
    warn "adb not found. Please ensure Android SDK platform-tools are installed and on PATH."
    exit 1
  fi
}

ensure_emulator_running() {
  export DEVICE_ID=""
  ensure_adb
  # If any device is already connected and online, use it
  if adb devices | awk 'NR>1 && $2=="device" {print $1}' | grep -q .; then
    DEVICE_ID=$(adb devices | awk 'NR>1 && $2=="device" {print $1; exit}')
    log "Device already online: ${DEVICE_ID}"
    export DEVICE_ID
    return 0
  fi

  # Try to list AVDs and start the first one
  if command -v emulator >/dev/null 2>&1; then
    local avd
    avd=$(emulator -list-avds | head -n 1 || true)
    if [[ -z "${avd}" ]]; then
      warn "No AVDs found. Attempting to create a default AVD if sdkmanager/avdmanager are available."
      if command -v sdkmanager >/dev/null 2>&1 && command -v avdmanager >/dev/null 2>&1; then
        # Try a common system image; adjust if unavailable
        sdkmanager --install "platforms;android-34" "system-images;android-34;google_apis;x86_64" || true
        echo "no" | avdmanager create avd -n cb_demo_avd -k "system-images;android-34;google_apis;x86_64" || true
        avd="cb_demo_avd"
      else
        warn "sdkmanager/avdmanager not found. Please create an AVD via Android Studio."
        exit 1
      fi
    fi
    log "Starting emulator: ${avd}"
    nohup emulator -avd "${avd}" -netdelay none -netspeed full -no-snapshot -no-boot-anim >/dev/null 2>&1 &
  else
    warn "emulator command not found. Please install Android Emulator via Android Studio."
    exit 1
  fi

  log "Waiting for device to boot..."
  adb wait-for-device
  # Wait for boot complete property
  local timeout=180
  while [[ ${timeout} -gt 0 ]]; do
    if adb shell getprop sys.boot_completed 2>/dev/null | grep -q 1; then
      break
    fi
    sleep 2
    timeout=$((timeout-2))
  done
  if [[ ${timeout} -le 0 ]]; then
    warn "Device did not boot in time."
    exit 1
  fi
  DEVICE_ID=$(adb devices | awk 'NR>1 && $2=="device" {print $1; exit}')
  export DEVICE_ID
  log "Device booted: ${DEVICE_ID}"
}

uninstall_app_if_present() {
  set +e
  adb uninstall "${APP_ID}" >/dev/null 2>&1
  set -e
}

install_app() {
  if ! command -v flutter >/dev/null 2>&1; then
    warn "flutter not found. Please install Flutter and ensure it's on PATH."
    exit 1
  fi
  # Build and install debug
  flutter --no-version-check --suppress-analytics install -d "${DEVICE_ID:-}" || {
    warn "flutter install failed, attempting fallback via APK."
    flutter --no-version-check --suppress-analytics build apk -v
    adb install -r build/app/outputs/flutter-apk/app-debug.apk
  }
}

launch_app() {
  # Try via monkey (safe)
  if ! adb -s "${DEVICE_ID:-}" shell monkey -p "${APP_ID}" -c android.intent.category.LAUNCHER 1 > /dev/null 2>&1; then
    warn "monkey launch failed, trying am start"
    adb -s "${DEVICE_ID:-}" shell cmd package resolve-activity -c android.intent.category.LAUNCHER "${APP_ID}" | grep name= || true
    adb -s "${DEVICE_ID:-}" shell am start -n "${APP_ID}/.MainActivity" || true
  fi
}

start_screen_recording() {
  local out_mp4="$1"
  log "Starting screenrecord to /sdcard/tmp_record.mp4"
  # Max duration 3 minutes; adjust per test run
adb -s "${DEVICE_ID:-}" shell screenrecord /sdcard/tmp_record.mp4 > /dev/null 2>&1 &
  export SCREENRECORD_PID=$!
  export SCREENRECORD_OUT="${out_mp4}"
}

stop_screen_recording() {
  if [[ -n "${SCREENRECORD_PID:-}" ]]; then
    log "Stopping screenrecord (pid ${SCREENRECORD_PID})"
    kill -INT ${SCREENRECORD_PID} >/dev/null 2>&1 || true
    wait ${SCREENRECORD_PID} 2>/dev/null || true
    sleep 1
    mkdir -p "${ARTIFACTS_DIR}/videos"
adb -s "${DEVICE_ID:-}" pull /sdcard/tmp_record.mp4 "${SCREENRECORD_OUT}" > /dev/null 2>&1 || true
    adb -s "${DEVICE_ID:-}" shell rm /sdcard/tmp_record.mp4 > /dev/null 2>&1 || true
    unset SCREENRECORD_PID
  fi
}

screencap() {
  local out_png="$1"
  mkdir -p "${ARTIFACTS_DIR}/screenshots"
adb -s "${DEVICE_ID:-}" shell screencap -p /sdcard/tmp_cap.png > /dev/null 2>&1 || true
  adb -s "${DEVICE_ID:-}" pull /sdcard/tmp_cap.png "${out_png}" > /dev/null 2>&1 || true
  adb -s "${DEVICE_ID:-}" shell rm /sdcard/tmp_cap.png > /dev/null 2>&1 || true
}

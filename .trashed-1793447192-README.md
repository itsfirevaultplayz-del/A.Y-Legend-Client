# A.Y Legend Client

A safe companion/UI app for Minecraft Bedrock (Android).
Package ID: `com.aylegend.client`

**This app does NOT** inject into Minecraft, touch its memory, bypass anti-cheat,
or provide any cheats (no KillAura, X-Ray, Reach, AutoClicker, Wallhack, packet
manipulation or automation). It only stores UI/performance preferences and opens
the installed Minecraft app via a normal Android launch intent.

## Features
- Neon dark UI (black + red/blue)
- `LAUNCH MINECRAFT` (package `com.mojang.minecraftpe`); friendly message if not installed
- `MOD MENU` preferences saved with SharedPreferences: Custom HUD, PvP UI, FPS Mode,
  Low Graphics Mode, Crosshair, Keystrokes HUD, A.Y Neon Theme

## Build
GitHub Actions (`.github/workflows/build-apk.yml`) runs on push to `main` or manually
and uploads the artifact **A-Y-Legend-Client-release** (`app-release.apk`).

Locally: `flutter pub get && flutter build apk --release`

Note: the release APK is signed with the debug key so it installs for testing.
Add your own keystore before publishing to a store.

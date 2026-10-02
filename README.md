# A.Y Legend Client

Complete Flutter Android source + GitHub Actions APK workflow.

## GitHub
Upload the CONTENTS of this folder to the repository root (do not upload the ZIP itself).

Required root structure:
.github/workflows/build-apk.yml
lib/main.dart
pubspec.yaml
assets/

Then open GitHub Actions:
Build A.Y Legend Client APK -> Run workflow

The workflow creates a clean Android Flutter project on GitHub's runner,
copies the Dart source and pubspec into it, runs flutter analyze, builds
a release APK, and uploads app-release.apk.

## Safety
This is a companion UI/settings app. It does not inject into Minecraft,
modify memory, bypass anti-cheat, or provide unfair cheats.

# GitHub APK build

1. Upload the CONTENTS of this ZIP to the root of your GitHub repository. Do not upload the ZIP file itself.
2. Make sure `.github/workflows/build-apk.yml` exists exactly at that path.
3. Commit the changes to `main`.
4. Open the repository's **Actions** tab.
5. Open **Build A.Y Legend Client APK**.
6. Wait for the run to finish with a green check.
7. Open the successful run and scroll to **Artifacts**.
8. Download **A-Y-Legend-Client-release**. Inside it is `app-release.apk`.

This workflow deliberately recreates the Android platform with `flutter create` before building. That prevents an incomplete or incompatible `android/` folder from breaking the GitHub build.

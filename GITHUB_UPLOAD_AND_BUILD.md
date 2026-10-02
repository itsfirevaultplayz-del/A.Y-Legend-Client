# A.Y Legend Client — GitHub upload & APK build

## Upload
1. Create/open your GitHub repository.
2. Upload the CONTENTS of this ZIP to the repository root.
3. Make sure this file exists exactly at:
   `.github/workflows/build-apk.yml`
4. Commit to `main`.

## Build
Open **Actions** → **Build A.Y Legend Client APK**.
A push to `main`, pull request to `main`, or **Run workflow** starts the build.

When it finishes with a green check:
**Actions → successful run → Artifacts → A-Y-Legend-Client-APK**

The artifact contains `app-release.apk`.

## Important
Do not paste the workflow inside another file.
Do not create `.github/workflows/.github/workflows/...`.
The workflow file must be exactly:
`.github/workflows/build-apk.yml`

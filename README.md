# flutter_note

A Flutter Project of compilation of everything I learn about flutter.

## Build Command

- Localization 코드 생성
    - `flutter pub run intl_utils:generate`
- JSON 직렬화/역직렬화 코드 생성을 위해 Build Runner 실행
    - `flutter pub run build_runner build --delete-conflicting-outputs`
- 빌드
    - `flutter build [appbundle|apk|ios|ipa] -t lib/config/env/[development|production].dart --flavor [development|production]`
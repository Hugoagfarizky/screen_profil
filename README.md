# Profile — Flutter App

Personal profile app built with Flutter for the **individual assignment of the Emerging Technology course 2026/2027**, Digital Innovation Department, Institut Teknologi Sepuluh Nopember.

The app displays personal data, photo, skills, and contacts across several screens with a dark theme, Outfit/Inter typography, and light animations.

## Features

- **Hero section** with profile photo and tagline.
- **Marquee band** with hobbies and interests.
- **Nav pill** for navigating between sections.
- **About list** with personal data (name, student ID, campus, department, origin).
- **Photo section** with several photos.
- **Contacts** for Instagram, GitHub, and email.
- Empty fields are automatically hidden, so it is safe if some fields are not filled yet.

## Running

```bash
flutter pub get
flutter run          # pick a device/emulator
flutter test         # unit + widget tests
flutter analyze      # lint check
```

## Editing personal data

All data lives in **`lib/data/profil_data.dart`**. Just change the values in the `ProfilData` class; widgets do not need to be touched. Empty fields (`''` or `[]`) are not rendered.

## Structure

```
lib/
├── main.dart                  entry point
├── data/profil_data.dart      ALL personal data lives here
├── screens/profile_screen.dart
├── theme/app_theme.dart       colors and typography
└── widgets/                   hero, about, photo, marquee, nav, components
assets/
├── images/                    avatar and photos
└── fonts/                     Outfit & Inter
test/profile_screen_test.dart
NASKAH_VIDEO.md                presentation script for the assignment
```

## Notes

This repo is part of a university assignment, not a product. `NASKAH_VIDEO.md` contains the script for the grading video.

## License

[MIT](LICENSE)

# Profil â€” Aplikasi Flutter

Aplikasi profil pribadi berbasis Flutter untuk **tugas individu Mata Kuliah Teknologi Berkembang 2026/2027**, Departemen Inovasi Digital, Institut Teknologi Sepuluh Nopember.

Aplikasi menampilkan data diri, foto, skill, dan kontak dalam beberapa layar dengan tema gelap, tipografi Outfit/Inter, dan animasi ringan.

## Fitur

- **Hero section** dengan foto profil dan tagline.
- **Marquee band** berisi hobi dan minat.
- **Nav pill** untuk berpindah antar bagian.
- **About list** berisi data diri (nama, NRP, kampus, departemen, asal).
- **Photo section** dengan beberapa foto.
- **Kontak** ke Instagram, GitHub, dan email.
- Data kosong otomatis tidak ditampilkan, jadi aman kalau ada field yang belum diisi.

## Menjalankan

```bash
flutter pub get
flutter run          # pilih device/emulator
flutter test         # unit + widget test
flutter analyze      # cek lint
```

## Mengubah data diri

Semua data ada di **`lib/data/profil_data.dart`**. Cukup ubah nilai di kelas `ProfilData`; widget tidak perlu disentuh. Field yang dikosongkan (`''` atau `[]`) tidak akan dirender.

## Struktur

```
lib/
â”œâ”€â”€ main.dart                  entry point
â”œâ”€â”€ data/profil_data.dart      SEMUA data diri ada di sini
â”œâ”€â”€ screens/profile_screen.dart
â”œâ”€â”€ theme/app_theme.dart       warna dan tipografi
â””â”€â”€ widgets/                   hero, about, foto, marquee, nav, komponen
assets/
â”œâ”€â”€ images/                    avatar dan foto
â””â”€â”€ fonts/                     Outfit & Inter
test/profile_screen_test.dart
NASKAH_VIDEO.md                naskah presentasi tugas
```

## Catatan

Repo ini bagian dari tugas kuliah, bukan produk. `NASKAH_VIDEO.md` berisi naskah untuk video penilaian.

## Lisensi

[MIT](LICENSE)

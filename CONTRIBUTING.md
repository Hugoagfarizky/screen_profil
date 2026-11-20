# Panduan Kontribusi

Aplikasi profil Flutter berisi data diri, foto, skill, dan kontak yang disusun dalam beberapa layar dengan tema gelap dan tipografi Outfit/Inter.

## Menjalankan

```bash
flutter pub get
flutter run
flutter test
```

## Sebelum mengirim perubahan

- `flutter analyze` dan `flutter test` harus lolos.
- Ubah data diri hanya di `lib/data/profil_data.dart`, bukan di widget.
- Jangan commit `.env`, kunci API, atau hasil build.

## Alur kontribusi

1. `git checkout -b fix/nama-singkat`
2. Commit dengan pesan yang jelas.
3. Buka pull request ke `main`, jelaskan **apa** dan **kenapa**.

Untuk masalah keamanan, ikuti `SECURITY.md`, jangan buka issue publik.

## Lisensi

Dengan mengirim pull request, kontribusimu dirilis di bawah [MIT License](LICENSE).
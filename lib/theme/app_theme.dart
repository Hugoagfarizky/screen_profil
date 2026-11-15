import 'package:flutter/material.dart';

/// Nama keluarga font yang didaftarkan di pubspec.yaml.
class AppFonts {
  AppFonts._();

  static const judul = 'Outfit';
  static const isi = 'Inter';
}

/// Warna dasar. Krem, hitam hangat, dan oranye amber.
class AppColors {
  AppColors._();

  static const krem = Color(0xFFF6F1E7);
  static const hitam = Color(0xFF1C1814);
  static const oranye = Color(0xFFFF9F1C);
  static const putih = Color(0xFFFFFFFF);
}

/// Palet yang dipakai widget. Isinya berbeda untuk mode terang dan gelap,
/// jadi widget cukup memanggil `Palet.of(context)`.
class Palet {
  const Palet({
    required this.latar,
    required this.kartu,
    required this.teks,
    required this.teksRedup,
    required this.garis,
    required this.aksen,
    required this.aksenTeks,
    required this.gelap,
    required this.diAtasGelap,
    required this.pita,
    required this.pitaTeks,
  });

  final Color latar; // latar halaman
  final Color kartu; // kartu putih
  final Color teks; // teks utama
  final Color teksRedup; // teks sekunder
  final Color garis; // garis tipis
  final Color aksen; // oranye untuk bidang (tombol, lingkaran, chip)
  final Color aksenTeks; // oranye untuk teks, cukup kontras dengan latar
  final Color gelap; // bidang gelap (navigasi, baris terbuka, chip gelap)
  final Color diAtasGelap; // teks di atas bidang gelap
  final Color pita; // latar pita teks berjalan
  final Color pitaTeks; // teks di pita

  static const terang = Palet(
    latar: AppColors.krem,
    kartu: AppColors.putih,
    teks: AppColors.hitam,
    teksRedup: Color(0xA31C1814),
    garis: Color(0x1F1C1814),
    aksen: AppColors.oranye,
    aksenTeks: Color(0xFFB86200),
    gelap: AppColors.hitam,
    diAtasGelap: AppColors.krem,
    pita: AppColors.hitam,
    pitaTeks: AppColors.krem,
  );

  static const malam = Palet(
    latar: Color(0xFF14110E),
    kartu: Color(0xFF221D18),
    teks: AppColors.krem,
    teksRedup: Color(0xADF6F1E7),
    garis: Color(0x1FF6F1E7),
    aksen: AppColors.oranye,
    aksenTeks: Color(0xFFFFB347),
    gelap: Color(0xFF2C2620),
    diAtasGelap: AppColors.krem,
    pita: AppColors.oranye,
    pitaTeks: AppColors.hitam,
  );

  static Palet of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? malam : terang;
}

class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(Brightness.light, Palet.terang);
  static ThemeData dark() => _build(Brightness.dark, Palet.malam);

  static ThemeData _build(Brightness brightness, Palet p) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.oranye,
          brightness: brightness,
        ).copyWith(
          primary: p.aksen,
          onPrimary: AppColors.hitam,
          surface: p.latar,
          onSurface: p.teks,
        );

    return ThemeData(
      colorScheme: scheme,
      fontFamily: AppFonts.isi,
      scaffoldBackgroundColor: p.latar,
      useMaterial3: true,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.hitam,
        contentTextStyle: TextStyle(color: AppColors.krem),
      ),
      // Warna seleksi teks dan kursor mengikuti palet.
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: p.aksen,
        selectionColor: p.aksen.withValues(alpha: 0.35),
      ),
    );
  }
}

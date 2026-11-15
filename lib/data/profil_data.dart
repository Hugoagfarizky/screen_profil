import 'package:flutter/material.dart';

/// SEMUA DATA DIRI ADA DI FILE INI.
///
/// Data bertanda CONTOH masih isian sementara. Ganti dengan data aslimu
/// sebelum merekam video. Isian yang dikosongkan ('' atau []) otomatis
/// tidak ditampilkan.
class ProfilData {
  ProfilData._();

  // --- Data asli ---
  static const nama = 'Muh Nugraha Yubi Agfarizky';
  static const panggilan = 'Hugo';
  static const nrp = '5051241034';
  static const kampus = 'Institut Teknologi Sepuluh Nopember';
  static const mataKuliah = 'Teknologi Berkembang 2026/2027';
  static const departemen = 'Inovasi Digital';
  static const angkatan = ''; // isi tahun angkatan, misal '2024'
  static const asal = 'Palembang';
  static const hobi = <String>['Musik', 'Badminton', 'Gaming'];
  static const skill = <String>['Design Graphic', 'Editing', 'Vibecoding'];

  /// Satu kalimat pendek di bawah nama pada kartu pembuka (bisa diganti).
  static const tagline = '"Pelan-pelan, yang penting jalan terus."';

  // --- CONTOH: ganti dengan data aslimu ---
  static const tentang =
      'Suka ngulik desain dan jalan malam keliling kota.'; // CONTOH

  // --- Kontak (halaman ke-3) ---
  static const kontak = <Kontak>[
    Kontak('Instagram', '@hugoagfarizky_', Icons.camera_alt_outlined),
    Kontak('GitHub', '@hugoagfarizky', Icons.code_rounded),
    Kontak('Email', 'nugrahaagfarizky@gmail.com', Icons.mail_outline_rounded),
  ];
}

class Kontak {
  const Kontak(this.platform, this.nilai, this.ikon);

  final String platform;
  final String nilai;
  final IconData ikon;
}

/// Ikon untuk hobi berdasarkan kata kuncinya.
IconData ikonHobi(String hobi) {
  final h = hobi.toLowerCase();
  const peta = <String, IconData>{
    'musik': Icons.music_note_rounded,
    'lagu': Icons.music_note_rounded,
    'gitar': Icons.music_note_rounded,
    'futsal': Icons.sports_soccer_rounded,
    'sepak': Icons.sports_soccer_rounded,
    'bola': Icons.sports_soccer_rounded,
    'basket': Icons.sports_basketball_rounded,
    'badminton': Icons.sports_tennis_rounded,
    'gym': Icons.fitness_center_rounded,
    'olahraga': Icons.directions_run_rounded,
    'lari': Icons.directions_run_rounded,
    'foto': Icons.photo_camera_outlined,
    'video': Icons.videocam_outlined,
    'game': Icons.sports_esports_outlined,
    'baca': Icons.menu_book_outlined,
    'buku': Icons.menu_book_outlined,
    'film': Icons.movie_outlined,
    'masak': Icons.restaurant_outlined,
    'kopi': Icons.coffee_outlined,
    'jalan': Icons.directions_walk_rounded,
    'travel': Icons.flight_takeoff_rounded,
    'desain': Icons.palette_outlined,
    'gambar': Icons.brush_outlined,
    'coding': Icons.code_rounded,
  };
  for (final e in peta.entries) {
    if (h.contains(e.key)) return e.value;
  }
  return Icons.favorite_border_rounded;
}

/// Ikon untuk skill berdasarkan namanya.
IconData ikonSkill(String skill) {
  final s = skill.toLowerCase();
  if (s.contains('flutter')) return Icons.flutter_dash;
  if (s.contains('vibe')) return Icons.auto_awesome_outlined;
  if (s.contains('edit')) return Icons.movie_edit;
  if (s.contains('design') ||
      s.contains('graphic') ||
      s.contains('figma') ||
      s.contains('desain') ||
      s.contains('ui')) {
    return Icons.palette_outlined;
  }
  if (s.contains('data') || s.contains('sql')) return Icons.storage_rounded;
  if (s.contains('git')) return Icons.merge_type_rounded;
  return Icons.code_rounded;
}

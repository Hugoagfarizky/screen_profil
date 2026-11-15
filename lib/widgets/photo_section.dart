import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/profil_data.dart';
import '../theme/app_theme.dart';
import 'komponen.dart';

/// Bagian penutup berlatar gelap: foto asli dalam bingkai oranye,
/// satu kalimat tentang diri, dan daftar kontak.
class PhotoSection extends StatelessWidget {
  const PhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    final malam = Theme.of(context).brightness == Brightness.dark;
    final latar = malam ? p.kartu : AppColors.hitam;
    final teksRedup = p.diAtasGelap.withValues(alpha: 0.72);

    return Container(
      color: latar,
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Foto asli dalam bingkai oranye.
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: p.aksen,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 4 / 5,
                    child: Image.asset(
                      'assets/images/foto.jpg',
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, -0.2),
                      semanticLabel:
                          'Foto asli ${ProfilData.nama} '
                          'berdiri di trotoar pada malam hari',
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -6,
                top: -10,
                child: Bintang(ukuran: 28, warna: p.diAtasGelap),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const LabelBagian(teks: 'Profil Singkat', diAtasGelap: true),
          const SizedBox(height: 10),
          const JudulBagian(awal: 'Siapa ', sorot: 'Saya?', diAtasGelap: true),
          if (ProfilData.tentang.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              ProfilData.tentang,
              style: TextStyle(
                fontFamily: AppFonts.judul,
                fontSize: 20,
                height: 1.4,
                fontWeight: FontWeight.w500,
                color: p.diAtasGelap,
              ),
            ),
          ],
          if (ProfilData.kontak.isNotEmpty) ...[
            const SizedBox(height: 32),
            Text(
              'Hubungi saya · ketuk untuk menyalin',
              style: TextStyle(fontSize: 13, color: teksRedup),
            ),
            const SizedBox(height: 12),
            for (final k in ProfilData.kontak) ...[
              _BarisKontak(kontak: k),
              const SizedBox(height: 10),
            ],
          ],
          const SizedBox(height: 24),
          Container(height: 1, color: p.diAtasGelap.withValues(alpha: 0.12)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Dibuat dengan Flutter',
                  style: TextStyle(fontSize: 12.5, color: teksRedup),
                ),
              ),
              Text(
                'Tekber 2026/27',
                style: TextStyle(fontSize: 12.5, color: teksRedup),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Satu kontak. Ketuk untuk menyalin ke clipboard.
class _BarisKontak extends StatelessWidget {
  const _BarisKontak({required this.kontak});

  final Kontak kontak;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    return Material(
      color: p.diAtasGelap.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: p.diAtasGelap.withValues(alpha: 0.12)),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        minTileHeight: 64,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: p.aksen, shape: BoxShape.circle),
          child: Icon(kontak.ikon, size: 20, color: AppColors.hitam),
        ),
        title: Text(
          kontak.platform,
          style: TextStyle(
            fontSize: 12.5,
            color: p.diAtasGelap.withValues(alpha: 0.7),
          ),
        ),
        subtitle: Text(
          kontak.nilai,
          style: TextStyle(
            fontFamily: AppFonts.judul,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: p.diAtasGelap,
          ),
        ),
        trailing: Icon(
          Icons.copy_rounded,
          size: 18,
          color: p.diAtasGelap.withValues(alpha: 0.6),
        ),
        onTap: () {
          Clipboard.setData(ClipboardData(text: kontak.nilai));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('${kontak.platform} disalin: ${kontak.nilai}'),
              ),
            );
        },
      ),
    );
  }
}

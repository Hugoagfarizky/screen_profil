import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'komponen.dart';

/// Satu baris yang bisa dibuka-tutup.
class DataDiri {
  const DataDiri({
    required this.judul,
    this.isi = '',
    this.keterangan,
    this.chip = const [],
  });

  final String judul;

  /// Teks besar saat baris dibuka. Boleh kosong jika hanya berisi chip.
  final String isi;
  final String? keterangan;

  /// Chip berikon (misalnya daftar hobi atau skill).
  final List<(String, IconData?)> chip;
}

/// Bagian "Kenalan Lebih Dekat": daftar bernomor, satu baris terbuka
/// sekaligus. Isinya hal yang tidak ada di bagian pembuka.
class AboutList extends StatefulWidget {
  const AboutList({super.key, required this.data});

  final List<DataDiri> data;

  @override
  State<AboutList> createState() => _AboutListState();
}

class _AboutListState extends State<AboutList> {
  int? _terbuka = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: LabelBagian(teks: 'Tentang Saya'),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerLeft,
          child: JudulBagian(awal: 'Kenalan ', sorot: 'Lebih Dekat'),
        ),
        const SizedBox(height: 24),
        for (var i = 0; i < widget.data.length; i++) ...[
          _Baris(
            nomor: i + 1,
            data: widget.data[i],
            terbuka: _terbuka == i,
            onTap: () => setState(() => _terbuka = _terbuka == i ? null : i),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _Baris extends StatelessWidget {
  const _Baris({
    required this.nomor,
    required this.data,
    required this.terbuka,
    required this.onTap,
  });

  final int nomor;
  final DataDiri data;
  final bool terbuka;
  final VoidCallback onTap;

  static const _lebarTab = 64.0;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    final latar = terbuka ? p.gelap : p.kartu;
    final warnaJudul = terbuka ? p.diAtasGelap : p.teks;
    const durasi = Duration(milliseconds: 320);

    return Semantics(
      button: true,
      expanded: terbuka,
      child: AnimatedContainer(
        duration: durasi,
        curve: Curves.easeOutCubic,
        decoration: ShapeDecoration(
          color: latar,
          shape: const _BentukBaris(lebarTab: _lebarTab),
          shadows: [
            BoxShadow(
              color: Colors.black.withValues(alpha: terbuka ? 0.16 : 0.05),
              offset: const Offset(0, 6),
              blurRadius: 14,
            ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            customBorder: const _BentukBaris(lebarTab: _lebarTab),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 14, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: _lebarTab - 8,
                        child: Text(
                          '${nomor.toString().padLeft(2, '0')}.',
                          style: TextStyle(
                            fontFamily: AppFonts.judul,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: terbuka ? p.aksen : p.aksenTeks,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          data.judul,
                          style: TextStyle(
                            fontFamily: AppFonts.judul,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: warnaJudul,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: terbuka ? 0.125 : 0,
                        duration: durasi,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: p.aksen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_outward_rounded,
                            size: 18,
                            color: AppColors.hitam,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration: durasi,
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: terbuka
                        ? _IsiTerbuka(data: data, kiri: _lebarTab - 8)
                        : const SizedBox(width: double.infinity),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IsiTerbuka extends StatelessWidget {
  const _IsiTerbuka({required this.data, required this.kiri});

  final DataDiri data;
  final double kiri;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    return Padding(
      padding: EdgeInsets.only(left: kiri, top: 12, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.isi.isNotEmpty)
            Text(
              data.isi,
              style: TextStyle(
                fontFamily: AppFonts.judul,
                fontSize: 22,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: p.aksen,
              ),
            ),
          if (data.chip.isNotEmpty) ...[
            if (data.isi.isNotEmpty) const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final (teks, ikon) in data.chip)
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      ikon == null ? 12 : 8,
                      6,
                      12,
                      6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: p.diAtasGelap.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (ikon != null) ...[
                          Icon(ikon, size: 16, color: p.aksen),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          teks,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: p.diAtasGelap,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
          if (data.keterangan != null) ...[
            const SizedBox(height: 12),
            Text(
              data.keterangan!,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: p.diAtasGelap.withValues(alpha: 0.72),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Bentuk baris: persegi bersudut melengkung, dengan bagian nomor di kiri
/// sedikit lebih pendek di atas dan bawah, seperti tab map.
class _BentukBaris extends ShapeBorder {
  const _BentukBaris({required this.lebarTab});

  final double lebarTab;

  static const _r = 16.0; // jari-jari sudut
  static const _turun = 7.0; // seberapa pendek bagian tab
  static const _miring = 12.0; // panjang sisi miring

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final l = rect.left, t = rect.top, r = rect.right, b = rect.bottom;
    final x = l + lebarTab;
    return Path()
      ..moveTo(l, t + _turun + _r)
      ..quadraticBezierTo(l, t + _turun, l + _r, t + _turun)
      ..lineTo(x, t + _turun)
      ..lineTo(x + _miring, t)
      ..lineTo(r - _r, t)
      ..quadraticBezierTo(r, t, r, t + _r)
      ..lineTo(r, b - _r)
      ..quadraticBezierTo(r, b, r - _r, b)
      ..lineTo(x + _miring, b)
      ..lineTo(x, b - _turun)
      ..lineTo(l + _r, b - _turun)
      ..quadraticBezierTo(l, b - _turun, l, b - _turun - _r)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Progres satu elemen (0..1) di dalam rentang [mulai]..[selesai]
/// dari animasi masuk keseluruhan.
double antara(double t, double mulai, double selesai) {
  return Interval(
    mulai,
    selesai.clamp(0.0, 1.0),
    curve: Curves.easeOutExpo,
  ).transform(t);
}

/// Elemen yang naik dari bawah sambil memudar masuk.
class Muncul extends StatelessWidget {
  const Muncul({
    super.key,
    required this.progres,
    required this.child,
    this.jarak = 24,
  });

  final double progres;
  final double jarak;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: progres,
      child: Transform.translate(
        offset: Offset(0, (1 - progres) * jarak),
        child: child,
      ),
    );
  }
}

/// Bintang empat sudut dengan sisi melengkung ke dalam.
class Bintang extends StatelessWidget {
  const Bintang({super.key, required this.ukuran, required this.warna});

  final double ukuran;
  final Color warna;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(
        size: Size.square(ukuran),
        painter: _BintangPainter(warna),
      ),
    );
  }
}

class _BintangPainter extends CustomPainter {
  const _BintangPainter(this.warna);

  final Color warna;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2;
    final path = Path()
      ..moveTo(c.dx, c.dy - r)
      ..quadraticBezierTo(c.dx, c.dy, c.dx + r, c.dy)
      ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy + r)
      ..quadraticBezierTo(c.dx, c.dy, c.dx - r, c.dy)
      ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy - r)
      ..close();
    canvas.drawPath(path, Paint()..color = warna);
  }

  @override
  bool shouldRepaint(_BintangPainter old) => old.warna != warna;
}

/// Tiga garis pendek memancar, seperti coretan tangan di pojok judul.
class Coretan extends StatelessWidget {
  const Coretan({super.key, required this.warna, this.ukuran = 16});

  final Color warna;
  final double ukuran;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(
        size: Size.square(ukuran),
        painter: _CoretanPainter(warna),
      ),
    );
  }
}

class _CoretanPainter extends CustomPainter {
  const _CoretanPainter(this.warna);

  final Color warna;

  @override
  void paint(Canvas canvas, Size size) {
    final cat = Paint()
      ..color = warna
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round;
    final asal = Offset(0, size.height);
    for (final (sudut, panjang) in [
      (-80.0, 0.55),
      (-45.0, 0.75),
      (-10.0, 0.55),
    ]) {
      final rad = sudut * math.pi / 180;
      final arah = Offset(math.cos(rad), math.sin(rad));
      canvas.drawLine(
        asal + arah * size.width * 0.35,
        asal + arah * size.width * (0.35 + panjang),
        cat,
      );
    }
  }

  @override
  bool shouldRepaint(_CoretanPainter old) => old.warna != warna;
}

/// Label kecil dengan dua titik bertumpuk di depannya.
class LabelBagian extends StatelessWidget {
  const LabelBagian({super.key, required this.teks, this.diAtasGelap = false});

  final String teks;
  final bool diAtasGelap;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    final warnaTeks = diAtasGelap ? p.diAtasGelap : p.teks;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 12,
          child: Stack(
            children: [
              _titik(warnaTeks),
              Positioned(left: 8, child: _titik(p.aksen)),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          teks,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: warnaTeks,
          ),
        ),
      ],
    );
  }

  Widget _titik(Color warna) => Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(color: warna, shape: BoxShape.circle),
  );
}

/// Chip berbentuk pil, gelap atau oranye.
class ChipPil extends StatelessWidget {
  const ChipPil({super.key, required this.teks, this.oranye = false});

  final String teks;
  final bool oranye;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: oranye ? p.aksen : p.gelap,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: oranye ? p.aksen : p.diAtasGelap.withValues(alpha: 0.14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        teks,
        style: TextStyle(
          fontFamily: AppFonts.judul,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: oranye ? AppColors.hitam : p.diAtasGelap,
        ),
      ),
    );
  }
}

/// Tombol berbentuk pil. Mengecil sedikit saat ditekan.
class TombolPil extends StatefulWidget {
  const TombolPil({
    super.key,
    required this.label,
    required this.onPressed,
    this.utama = false,
    this.kecil = false,
  });

  final String label;
  final VoidCallback onPressed;

  /// Tombol utama: oranye dengan lingkaran panah hitam di kanan.
  final bool utama;

  /// Versi kecil untuk navigasi.
  final bool kecil;

  @override
  State<TombolPil> createState() => _TombolPilState();
}

class _TombolPilState extends State<TombolPil> {
  bool _ditekan = false;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    final tinggi = widget.kecil ? 40.0 : 50.0;
    final latar = widget.utama
        ? p.aksen
        : (widget.kecil ? AppColors.putih : p.kartu);
    final warnaTeks = widget.utama || widget.kecil ? AppColors.hitam : p.teks;

    return AnimatedScale(
      scale: _ditekan ? 0.96 : 1,
      duration: const Duration(milliseconds: 120),
      child: Material(
        color: latar,
        shape: StadiumBorder(
          side: widget.kecil
              ? BorderSide.none
              : BorderSide(color: p.teks, width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onPressed,
          onHighlightChanged: (v) => setState(() => _ditekan = v),
          child: Container(
            height: tinggi,
            padding: EdgeInsets.only(
              left: widget.kecil ? 16 : 20,
              right: widget.utama ? 6 : (widget.kecil ? 16 : 20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: AppFonts.judul,
                    fontSize: widget.kecil ? 14 : 16,
                    fontWeight: FontWeight.w600,
                    color: warnaTeks,
                  ),
                ),
                if (widget.utama) ...[
                  const SizedBox(width: 10),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: AppColors.hitam,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: AppColors.krem,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Judul bagian: sebagian kata berwarna oranye, dengan coretan di ujung.
class JudulBagian extends StatelessWidget {
  const JudulBagian({
    super.key,
    required this.awal,
    required this.sorot,
    this.diAtasGelap = false,
  });

  final String awal;
  final String sorot;
  final bool diAtasGelap;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    final warna = diAtasGelap ? p.diAtasGelap : p.teks;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: awal),
                TextSpan(
                  text: sorot,
                  style: TextStyle(color: diAtasGelap ? p.aksen : p.aksenTeks),
                ),
              ],
            ),
            style: TextStyle(
              fontFamily: AppFonts.judul,
              fontSize: 30,
              height: 1.1,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              color: warna,
            ),
          ),
        ),
        Positioned(right: 0, top: -6, child: Coretan(warna: warna)),
      ],
    );
  }
}

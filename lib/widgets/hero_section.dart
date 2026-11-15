import 'package:flutter/material.dart';

import '../data/profil_data.dart';
import '../theme/app_theme.dart';
import 'komponen.dart';

/// Bagian pembuka: kartu profil. Foto malam di atas memudar ke warna kartu,
/// avatar bulat, nama panggilan, info singkat, angka ringkas, dan tombol
/// untuk menggulir ke bagian "Kenalan Lebih Dekat".
class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.intro, required this.onKenalan});

  final Animation<double> intro;
  final VoidCallback onKenalan;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);

    return AnimatedBuilder(
      animation: intro,
      builder: (context, _) {
        final t = intro.value;
        return LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            // Dibulatkan supaya tidak ada garis tipis di tepi bawah sampul.
            final tinggiSampul = (w * 0.56).clamp(180.0, 240.0).roundToDouble();
            const ukuranAvatar = 88.0;

            return Muncul(
              progres: antara(t, 0, 0.5),
              jarak: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: p.kartu,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: p.garis),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      offset: const Offset(0, 12),
                      blurRadius: 32,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: tinggiSampul,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: _Sampul(progres: antara(t, 0, 0.9)),
                          ),
                          const Positioned(
                            top: 14,
                            right: 14,
                            child: _TombolTandai(),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 0,
                            child: Transform.scale(
                              scale: 0.6 + 0.4 * antara(t, 0.2, 0.7),
                              child: Opacity(
                                opacity: antara(t, 0.2, 0.6),
                                child: const _Avatar(ukuran: ukuranAvatar),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Muncul(
                            progres: antara(t, 0.3, 0.75),
                            jarak: 12,
                            child: _Identitas(p: p),
                          ),
                          const SizedBox(height: 20),
                          Muncul(
                            progres: antara(t, 0.4, 0.85),
                            jarak: 12,
                            child: _Angka(p: p),
                          ),
                          const SizedBox(height: 20),
                          Muncul(
                            progres: antara(t, 0.5, 0.95),
                            jarak: 12,
                            child: Row(
                              children: [
                                Expanded(child: _DeretSkill(p: p)),
                                const SizedBox(width: 12),
                                _TombolKenalan(onTap: onKenalan),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// Foto malam sebagai sampul, memudar ke warna kartu di bagian bawah.
class _Sampul extends StatelessWidget {
  const _Sampul({required this.progres});

  final double progres;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        // Sedikit membesar lalu kembali saat dibuka.
        Transform.scale(
          scale: 1.12 - 0.12 * progres,
          child: Image.asset(
            'assets/images/foto.jpg',
            fit: BoxFit.cover,
            alignment: const Alignment(0, -0.5),
            excludeFromSemantics: true,
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.35, 0.8, 0.94],
              colors: [
                p.kartu.withValues(alpha: 0),
                p.kartu.withValues(alpha: 0.05),
                p.kartu.withValues(alpha: 0.9),
                p.kartu,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Avatar bulat: foto diri berjas almamater ITS.
class _Avatar extends StatelessWidget {
  const _Avatar({required this.ukuran});

  final double ukuran;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    return Container(
      width: ukuran,
      height: ukuran,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: p.kartu, shape: BoxShape.circle),
      child: ClipOval(
        child: Image.asset(
          'assets/images/avatar.jpg',
          fit: BoxFit.cover,
          semanticLabel: 'Foto ${ProfilData.nama}',
        ),
      ),
    );
  }
}

/// Nama panggilan, satu kalimat pendek, dan dua info kecil.
class _Identitas extends StatelessWidget {
  const _Identitas({required this.p});

  final Palet p;

  @override
  Widget build(BuildContext context) {
    final gayaInfo = TextStyle(fontSize: 12.5, color: p.teksRedup);
    Widget info(IconData ikon, String teks) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(ikon, size: 15, color: p.teksRedup),
        const SizedBox(width: 5),
        Text(teks, style: gayaInfo),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: ProfilData.panggilan),
                TextSpan(
                  text: '.',
                  style: TextStyle(color: p.aksen),
                ),
              ],
            ),
            style: TextStyle(
              fontFamily: AppFonts.judul,
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              color: p.teks,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          ProfilData.tagline,
          style: TextStyle(
            fontSize: 14.5,
            height: 1.4,
            fontStyle: FontStyle.italic,
            color: p.teks,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 4,
          children: [
            info(Icons.badge_outlined, 'NRP ${ProfilData.nrp}'),
            info(Icons.location_on_outlined, 'ITS Surabaya'),
          ],
        ),
      ],
    );
  }
}

/// Tiga angka ringkas dipisah garis tegak.
class _Angka extends StatelessWidget {
  const _Angka({required this.p});

  final Palet p;

  @override
  Widget build(BuildContext context) {
    Widget kolom(String nilai, String label, {IconData? ikon}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (ikon != null) ...[
              Icon(ikon, size: 17, color: p.aksen),
              const SizedBox(width: 4),
            ],
            Text(
              nilai,
              style: TextStyle(
                fontFamily: AppFonts.judul,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: p.teks,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 12, color: p.teksRedup)),
      ],
    );

    Widget garis() => Container(
      width: 1,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: p.garis,
    );

    return Row(
      children: [
        kolom('${ProfilData.skill.length}', 'skill', ikon: Icons.star_rounded),
        garis(),
        kolom('${ProfilData.hobi.length}', 'hobi'),
        garis(),
        kolom('ITS', 'kampus'),
      ],
    );
  }
}

/// Ikon skill bertumpuk, seperti deretan logo tools di referensi.
class _DeretSkill extends StatelessWidget {
  const _DeretSkill({required this.p});

  final Palet p;

  @override
  Widget build(BuildContext context) {
    const ukuran = 30.0;
    const geser = 20.0;
    final ikon = [for (final s in ProfilData.skill) ikonSkill(s)];
    final warna = [p.aksen, p.gelap, p.kartu];
    final warnaIkon = [AppColors.hitam, p.diAtasGelap, p.teks];

    return Row(
      children: [
        SizedBox(
          width: ukuran + geser * (ikon.length - 1),
          height: ukuran,
          child: Stack(
            children: [
              for (var i = 0; i < ikon.length; i++)
                Positioned(
                  left: geser * i,
                  child: Container(
                    width: ukuran,
                    height: ukuran,
                    decoration: BoxDecoration(
                      color: warna[i % 3],
                      shape: BoxShape.circle,
                      border: Border.all(color: p.kartu, width: 2),
                      boxShadow: i % 3 == 2
                          ? [BoxShadow(color: p.garis, spreadRadius: 1)]
                          : null,
                    ),
                    child: Icon(ikon[i], size: 15, color: warnaIkon[i % 3]),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            'Skill',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppFonts.judul,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: p.teks,
            ),
          ),
        ),
      ],
    );
  }
}

/// Tombol pil gelap "Kenalan yuk". Mengecil sedikit saat ditekan.
class _TombolKenalan extends StatefulWidget {
  const _TombolKenalan({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_TombolKenalan> createState() => _TombolKenalanState();
}

class _TombolKenalanState extends State<_TombolKenalan> {
  bool _ditekan = false;

  @override
  Widget build(BuildContext context) {
    final terang = Theme.of(context).brightness == Brightness.light;
    final latar = terang ? AppColors.hitam : AppColors.oranye;
    final teks = terang ? AppColors.krem : AppColors.hitam;

    return AnimatedScale(
      scale: _ditekan ? 0.95 : 1,
      duration: const Duration(milliseconds: 120),
      child: Material(
        color: latar,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          onHighlightChanged: (v) => setState(() => _ditekan = v),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            child: Text(
              'Kenalan yuk',
              style: TextStyle(
                fontFamily: AppFonts.judul,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: teks,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tombol bulat putih di pojok sampul untuk menandai profil.
class _TombolTandai extends StatefulWidget {
  const _TombolTandai();

  @override
  State<_TombolTandai> createState() => _TombolTandaiState();
}

class _TombolTandaiState extends State<_TombolTandai> {
  bool _ditandai = false;

  void _ganti() {
    setState(() => _ditandai = !_ditandai);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(_ditandai ? 'Profil ditandai' : 'Tanda dihapus'),
          duration: const Duration(milliseconds: 1400),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.putih,
      shape: const CircleBorder(),
      elevation: 0,
      child: IconButton(
        onPressed: _ganti,
        tooltip: _ditandai ? 'Hapus tanda' : 'Tandai profil',
        iconSize: 20,
        visualDensity: VisualDensity.compact,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (anak, anim) =>
              ScaleTransition(scale: anim, child: anak),
          child: Icon(
            _ditandai ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            key: ValueKey(_ditandai),
            color: _ditandai ? AppColors.oranye : AppColors.hitam,
          ),
        ),
      ),
    );
  }
}

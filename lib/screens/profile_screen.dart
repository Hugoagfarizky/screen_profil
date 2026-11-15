import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/profil_data.dart';
import '../widgets/about_list.dart';
import '../widgets/hero_section.dart';
import '../widgets/marquee_band.dart';
import '../widgets/nav_pill.dart';
import '../widgets/photo_section.dart';

/// Layar profil. StatefulWidget karena ada animasi masuk saat dibuka.
///
/// Bagian pembuka berisi nama, NRP, dan foto. Bagian-bagian di bawahnya
/// berisi hal lain (departemen, asal, hobi, skill, kontak) supaya tidak
/// mengulang isi bagian pembuka.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.onGantiTema});

  final VoidCallback onGantiTema;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  final _kunciTentang = GlobalKey();
  final _kunciKontak = GlobalKey();

  /// Baris "Kenalan Lebih Dekat", dibuat dari ProfilData.
  /// Baris yang datanya kosong tidak dimasukkan.
  static List<DataDiri> get _dataDiri => [
    // Nama lengkap dan NRP (wajib tugas) ada di baris pertama,
    // yang terbuka otomatis.
    const DataDiri(
      judul: 'Identitas',
      isi: ProfilData.nama,
      chip: [
        ('NRP ${ProfilData.nrp}', Icons.badge_outlined),
        ('ITS Surabaya', Icons.school_outlined),
      ],
    ),
    if (ProfilData.departemen.isNotEmpty)
      DataDiri(
        judul: 'Jurusan',
        isi: ProfilData.departemen,
        chip: [
          if (ProfilData.angkatan.isNotEmpty)
            ('Angkatan ${ProfilData.angkatan}', Icons.event_outlined),
        ],
      ),
    if (ProfilData.asal.isNotEmpty)
      const DataDiri(judul: 'Asal', isi: ProfilData.asal),
    if (ProfilData.hobi.isNotEmpty)
      DataDiri(
        judul: 'Hobi & Minat',
        chip: [for (final h in ProfilData.hobi) (h, ikonHobi(h))],
      ),
    if (ProfilData.skill.isNotEmpty)
      DataDiri(
        judul: 'Skill',
        chip: [for (final s in ProfilData.skill) (s, ikonSkill(s))],
        keterangan: 'Hal yang saya kuasai dan terus saya asah.',
      ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_intro.status == AnimationStatus.dismissed) {
      // Hormati pengaturan "kurangi animasi" di HP.
      if (MediaQuery.of(context).disableAnimations) {
        _intro.value = 1;
      } else {
        _intro.forward();
      }
    }
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  void _gulirKe(GlobalKey kunci) {
    final ctx = kunci.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final terang = Theme.of(context).brightness == Brightness.light;
    final dataDiri = _dataDiri;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (terang ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light)
          .copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: NavPill(
                    onGantiTema: widget.onGantiTema,
                    onTentang: () => _gulirKe(_kunciTentang),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HeroSection(
                    intro: _intro,
                    onKenalan: () => _gulirKe(_kunciTentang),
                  ),
                ),
                const SizedBox(height: 28),
                MarqueeBand(
                  isi: [
                    ProfilData.mataKuliah,
                    ...ProfilData.skill,
                    ...ProfilData.hobi,
                  ],
                ),
                if (dataDiri.isNotEmpty) ...[
                  const SizedBox(height: 44),
                  Padding(
                    key: _kunciTentang,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AboutList(data: dataDiri),
                  ),
                ],
                const SizedBox(height: 40),
                PhotoSection(key: _kunciKontak),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

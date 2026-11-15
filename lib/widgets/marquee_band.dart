import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'komponen.dart';

/// Pita selebar layar berisi teks yang terus berjalan ke kiri,
/// dipisah bintang oranye.
class MarqueeBand extends StatefulWidget {
  const MarqueeBand({super.key, required this.isi});

  final List<String> isi;

  @override
  State<MarqueeBand> createState() => _MarqueeBandState();
}

class _MarqueeBandState extends State<MarqueeBand>
    with SingleTickerProviderStateMixin {
  final _scroll = ScrollController();
  late final AnimationController _jalan = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 22),
  )..addListener(_geser);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _jalan.stop();
    } else if (!_jalan.isAnimating) {
      _jalan.repeat();
    }
  }

  /// Isi pita diulang tiga kali. Saat satu putaran selesai, posisi
  /// kembali ke awal tanpa terlihat karena isinya sama persis.
  void _geser() {
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    // Frame pertama: ukuran pita belum dihitung.
    if (!pos.hasContentDimensions || !pos.hasViewportDimension) return;
    final satuPutaran = (pos.maxScrollExtent + pos.viewportDimension) / 3;
    _scroll.jumpTo(_jalan.value * satuPutaran);
  }

  @override
  void dispose() {
    _jalan.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    final malam = Theme.of(context).brightness == Brightness.dark;
    final gaya = TextStyle(
      fontFamily: AppFonts.judul,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: p.pitaTeks,
    );

    final satuPutaran = [
      for (final teks in widget.isi) ...[
        Text(teks, style: gaya),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Bintang(ukuran: 18, warna: malam ? AppColors.hitam : p.aksen),
        ),
      ],
    ];

    return Semantics(
      label: widget.isi.join(', '),
      child: ExcludeSemantics(
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: p.pita,
            border: Border(bottom: BorderSide(color: p.aksen, width: 3)),
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            controller: _scroll,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(children: [for (var i = 0; i < 3; i++) ...satuPutaran]),
          ),
        ),
      ),
    );
  }
}

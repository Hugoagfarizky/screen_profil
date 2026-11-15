import 'package:flutter/material.dart';

import '../data/profil_data.dart';
import '../theme/app_theme.dart';
import 'komponen.dart';

/// Navigasi berbentuk pil gelap: logo inisial, tombol tema, dan tombol
/// yang menggulir ke bagian "Kenalan Lebih Dekat".
class NavPill extends StatelessWidget {
  const NavPill({
    super.key,
    required this.onGantiTema,
    required this.onTentang,
  });

  final VoidCallback onGantiTema;
  final VoidCallback onTentang;

  @override
  Widget build(BuildContext context) {
    final p = Palet.of(context);
    final malam = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 56,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: p.gelap,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            offset: const Offset(0, 6),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo: inisial di lingkaran oranye.
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: p.aksen, shape: BoxShape.circle),
            child: Text(
              ProfilData.panggilan[0],
              style: const TextStyle(
                fontFamily: AppFonts.judul,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.hitam,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppFonts.judul,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: p.diAtasGelap,
              ),
            ),
          ),
          IconButton(
            onPressed: onGantiTema,
            tooltip: malam ? 'Mode terang' : 'Mode gelap',
            style: IconButton.styleFrom(
              backgroundColor: p.diAtasGelap.withValues(alpha: 0.08),
              foregroundColor: p.diAtasGelap,
              minimumSize: const Size(40, 40),
            ),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) =>
                  RotationTransition(turns: anim, child: child),
              child: Icon(
                malam ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                key: ValueKey(malam),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 6),
          TombolPil(label: 'Tentang', kecil: true, onPressed: onTentang),
        ],
      ),
    );
  }
}

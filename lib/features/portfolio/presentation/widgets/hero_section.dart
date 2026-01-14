import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/purple_theme.dart';
import '../../../../core/widgets/glass_container.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  Future<void> _downloadCV() async {
    final Uri url = Uri.parse('assets/cv/cv.pdf');
    if (!await launchUrl(url)) throw Exception('Could not launch $url');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.introGreeting,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: PurpleTheme.lightPurple,
                    fontWeight: FontWeight.w300,
                    fontSize: isMobile ? 22 : 28))
            .animate()
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.2)
            .blurXY(begin: 10, end: 0),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
                  colors: isDark
                      ? [Colors.white, PurpleTheme.lightPurple, Colors.white]
                      : [
                          PurpleTheme.primaryPurple,
                          PurpleTheme.secondaryPurple,
                          PurpleTheme.primaryPurple
                        ])
              .createShader(bounds),
          child: Text('Siham Abdullah',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 42 : 57,
                  color: isDark ? Colors.white : PurpleTheme.primaryPurple)),
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 800.ms)
            .slideX(begin: -0.15)
            .blurXY(begin: 15, end: 0)
            .then()
            .shimmer(
                delay: 1500.ms,
                duration: 2000.ms,
                color: PurpleTheme.lightPurple.withOpacity(0.3)),
        Text(l10n.introRole,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: isMobile ? 24 : 28))
            .animate()
            .fadeIn(delay: 500.ms, duration: 700.ms)
            .slideX(begin: -0.1)
            .blurXY(begin: 8, end: 0),
        const SizedBox(height: 30),
        GlassContainer(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Text(
            'Specialized in building high-performance, scalable mobile applications with Flutter. Committed to Clean Architecture, SOLID principles, and crafting pixel-perfect UI/UX experiences.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(height: 1.5, fontSize: 18),
          ),
        )
            .animate()
            .fadeIn(delay: 700.ms, duration: 900.ms)
            .scale(begin: const Offset(0.9, 0.9))
            .blurXY(begin: 10, end: 0),
        const SizedBox(height: 40),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _downloadCV,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                gradient: PurpleTheme.mainGradient,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: PurpleTheme.primaryPurple.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10)),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.file_download_outlined, color: Colors.white)
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: 0, end: -3, duration: 800.ms),
                  const SizedBox(width: 12),
                  Text(l10n.downloadCV,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 900.ms)
            .scale(
                begin: const Offset(0.8, 0.8),
                curve: Curves.elasticOut,
                duration: 1.seconds)
            .then()
            .shimmer(
                delay: 2.seconds,
                duration: 1800.ms,
                color: Colors.white.withOpacity(0.4)),
      ],
    );
  }
}

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
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.introGreeting,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: PurpleTheme.lightPurple,
                fontWeight: FontWeight.w300,
              ),
        )
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOutQuart)
            .slideX(begin: -0.1, curve: Curves.easeOutQuart),
        Text(
          'Siham Abdullah',
          style: Theme.of(context).textTheme.displayLarge,
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms, curve: Curves.easeOutQuart)
            .slideX(begin: -0.1, curve: Curves.easeOutQuart),
        Text(
          l10n.introRole, // "Flutter Developer"
          style: Theme.of(
            context,
          ).textTheme.headlineMedium,
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 800.ms, curve: Curves.easeOutQuart)
            .slideX(begin: -0.1, curve: Curves.easeOutQuart),
        const SizedBox(height: 30),
        GlassContainer(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Text(
            'Specialized in building high-performance, scalable mobile applications with Flutter. Committed to Clean Architecture, SOLID principles, and crafting pixel-perfect UI/UX experiences that drive user engagement.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(height: 1.5, fontSize: 18),
          ),
        )
            .animate()
            .fadeIn(
                delay: 600.ms, duration: 1000.ms, curve: Curves.easeOutQuart)
            .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOutQuart),
        const SizedBox(height: 40),
        // Download CV Button
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
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.file_download_outlined, color: Colors.white),
                  const SizedBox(width: 12),
                  Text(
                    l10n.downloadCV,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                duration: 2.seconds,
                begin: const Offset(1, 1),
                end: const Offset(1.03, 1.03),
                curve: Curves.easeInOut,
              )
              .animate()
              .fadeIn(delay: 800.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                curve: Curves.elasticOut,
                duration: 1.seconds,
              )
              .shimmer(
                delay: 3.seconds,
                duration: 2.seconds,
                color: Colors.white.withOpacity(0.3),
              ),
        ),
      ],
    );
  }
}

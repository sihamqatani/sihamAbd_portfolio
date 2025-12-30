import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';

import '../../../../core/theme/purple_theme.dart';
import '../../../../core/widgets/glass_container.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

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
      ],
    );
  }
}

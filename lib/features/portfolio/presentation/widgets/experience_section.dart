import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';

import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/experience.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;
  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.experience,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: isMobile ? 36 : null))
            .animate()
            .fadeIn()
            .slideX(begin: -0.15)
            .blurXY(begin: 10, end: 0),
        const SizedBox(height: 30),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            final exp = experiences[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                                    blurRadius: 12,
                                    spreadRadius: 2)
                              ]),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .scale(
                                begin: const Offset(1, 1),
                                end: const Offset(1.2, 1.2),
                                duration: 1500.ms,
                                delay: (index * 200).ms)
                            .animate()
                            .fadeIn(delay: (index * 150).ms)
                            .scale(
                                begin: Offset.zero, curve: Curves.elasticOut),
                        Expanded(
                          child: Container(
                              width: 2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1)
                                  ]))),
                        )
                            .animate()
                            .fadeIn(delay: (index * 150 + 200).ms)
                            .scaleY(begin: 0, alignment: Alignment.topCenter),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GlassContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isMobile) ...[
                                Text(exp.position,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(exp.period,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color: isDark
                                                ? Colors.white70
                                                : Colors.black54)),
                              ] else
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(exp.position,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(exp.period,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                  ],
                                ),
                              const SizedBox(height: 8),
                              Row(children: [
                                Icon(Icons.business,
                                    size: 16,
                                    color: Theme.of(context).primaryColor),
                                const SizedBox(width: 6),
                                Text(exp.company,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w500)),
                              ]),
                              const SizedBox(height: 12),
                              Text(exp.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(height: 1.5)),
                            ],
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: (index * 150 + 100).ms)
                        .slideX(begin: 0.1),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';

import '../../../../core/theme/purple_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/experience.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.experience,
          style: Theme.of(context).textTheme.displayMedium,
        )
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOutQuart)
            .slideX(begin: -0.1, curve: Curves.easeOutQuart),
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
                    // Timeline indicator
                    Column(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: PurpleTheme.primaryPurple,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    PurpleTheme.primaryPurple.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 2,
                            color: PurpleTheme.primaryPurple.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    // Content
                    Expanded(
                      child: GlassContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      exp.position,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    exp.period,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                exp.company,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: PurpleTheme.primaryPurple,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                exp.description,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(
                  delay: (index * 150).ms,
                  duration: 800.ms,
                  curve: Curves.easeOutQuart,
                )
                .slideX(
                  begin: 0.05,
                  delay: (index * 150).ms,
                  duration: 800.ms,
                  curve: Curves.easeOutQuart,
                );
          },
        ),
      ],
    );
  }
}

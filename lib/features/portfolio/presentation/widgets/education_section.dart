import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';

import '../../../../core/theme/purple_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/education.dart';

class EducationSection extends StatelessWidget {
  final List<Education> educations;

  const EducationSection({super.key, required this.educations});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.education,
          style: Theme.of(context).textTheme.displayMedium,
        ).animate().fadeIn().slideX(),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder: (context, constraints) {
            final int crossAxisCount = constraints.maxWidth < 600 ? 1 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 180,
              ),
              itemCount: educations.length,
              itemBuilder: (context, index) {
                final edu = educations[index];
                return GlassContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.school,
                        color: PurpleTheme.primaryPurple,
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        edu.degree,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        edu.school,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: PurpleTheme.primaryPurple,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        edu.period,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: (200 * index).ms).scale();
              },
            );
          },
        ),
      ],
    );
  }
}

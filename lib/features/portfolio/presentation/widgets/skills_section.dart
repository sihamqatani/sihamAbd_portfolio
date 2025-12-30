import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';

import '../../../../core/theme/purple_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/skill.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.skills,
          style: Theme.of(context).textTheme.displayMedium,
        ).animate().fadeIn().slideX(),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 900
                ? 3
                : constraints.maxWidth > 600
                    ? 2
                    : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 220,
              ),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];
                return GlassContainer(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: PurpleTheme.primaryPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    PurpleTheme.primaryPurple.withOpacity(0.2),
                              ),
                            ),
                            child: Text(
                              skill.category,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: PurpleTheme.primaryPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Icon(
                            _getIconForSkill(skill.iconCode),
                            color: PurpleTheme.primaryPurple.withOpacity(0.5),
                            size: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        skill.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          skill.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: isDark ? Colors.white70 : Colors.black54,
                                height: 1.4,
                              ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(
                        delay: (index * 80).ms,
                        duration: 800.ms,
                        curve: Curves.easeOutQuart)
                    .slideY(
                        begin: 0.1,
                        delay: (index * 80).ms,
                        duration: 800.ms,
                        curve: Curves.easeOutQuart);
              },
            );
          },
        ),
      ],
    );
  }

  IconData _getIconForSkill(String iconCode) {
    switch (iconCode) {
      case 'flutter':
        return Icons.mobile_friendly;
      case 'state_management':
        return Icons.account_tree;
      case 'backend':
        return Icons.cloud;
      case 'storage':
        return Icons.storage;
      case 'devops':
        return Icons.vibration;
      case 'algorithms':
        return Icons.functions;
      case 'location':
        return Icons.location_on;
      case 'design':
        return Icons.brush;
      case 'architecture':
        return Icons.layers;
      default:
        return Icons.code;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';

import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/skill.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;
  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.skills,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: isMobile ? 36 : null))
            .animate()
            .fadeIn()
            .slideX(begin: -0.15)
            .blurXY(begin: 10, end: 0),
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
              itemBuilder: (context, index) => _SkillCard(
                  skill: skills[index], index: index, isDark: isDark),
            );
          },
        ),
      ],
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Skill skill;
  final int index;
  final bool isDark;
  const _SkillCard(
      {required this.skill, required this.index, required this.isDark});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -8.0 : 0.0, 0.0),
        child: GlassContainer(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(widget.skill.category,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  AnimatedContainer(
                    duration: 300.ms,
                    transform: Matrix4.identity()
                      ..rotateZ(_isHovered ? 0.1 : 0),
                    child: Icon(_getIconForSkill(widget.skill.iconCode),
                        color: _isHovered
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.5),
                        size: _isHovered ? 28 : 24),
                  ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.1, 1.1),
                      duration: 2.seconds),
                ],
              ),
              const SizedBox(height: 16),
              Text(widget.skill.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: Text(widget.skill.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: widget.isDark ? Colors.white70 : Colors.black54),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (widget.index * 100).ms)
        .slideY(begin: 0.2)
        .scale(begin: const Offset(0.95, 0.95));
  }

  IconData _getIconForSkill(String iconCode) {
    final icons = {
      'flutter': Icons.mobile_friendly,
      'state_management': Icons.account_tree,
      'backend': Icons.cloud,
      'storage': Icons.storage,
      'devops': Icons.vibration,
      'algorithms': Icons.functions,
      'location': Icons.location_on,
      'design': Icons.brush,
      'architecture': Icons.layers
    };
    return icons[iconCode] ?? Icons.code;
  }
}

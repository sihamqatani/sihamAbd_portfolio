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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.education,
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
            final int crossAxisCount = constraints.maxWidth < 600 ? 1 : 2;
            final double cardHeight =
                isMobile ? 180 : 200; // Adjusted height to prevent overflow
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: cardHeight,
              ),
              itemCount: educations.length,
              itemBuilder: (context, index) => _EducationCard(
                  education: educations[index],
                  index: index,
                  isMobile: isMobile),
            );
          },
        ),
      ],
    );
  }
}

class _EducationCard extends StatefulWidget {
  final Education education;
  final int index;
  final bool isMobile;
  const _EducationCard(
      {required this.education, required this.index, required this.isMobile});

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
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
          child: Padding(
            padding: EdgeInsets.all(widget.isMobile ? 16.0 : 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: 300.ms,
                  padding: EdgeInsets.all(_isHovered ? 10 : 6),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .primaryColor
                          .withOpacity(_isHovered ? 0.15 : 0.1),
                      shape: BoxShape.circle),
                  child: Icon(Icons.school,
                      color: Theme.of(context).primaryColor,
                      size: widget.isMobile ? 32 : 36),
                ),
                SizedBox(height: widget.isMobile ? 8 : 12),
                Flexible(
                    child: Text(widget.education.degree,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: widget.isMobile ? 14 : 16))),
                const SizedBox(height: 4),
                Flexible(
                    child: Text(widget.education.school,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: PurpleTheme.primaryPurple,
                            fontSize: widget.isMobile ? 12 : 14))),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (widget.index * 150).ms)
        .slideY(begin: 0.2)
        .scale(begin: const Offset(0.9, 0.9));
  }
}

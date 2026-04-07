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
            final isMobileLayout = constraints.maxWidth < 600;
            if (isMobileLayout) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: educations.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) => _EducationCard(
                  education: educations[index],
                  index: index,
                  isMobile: true,
                ),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 950
                    ? 3
                    : (constraints.maxWidth > 600 ? 2 : 1),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 280, // زيادة المساحة لضمان شكل احترافي وواسع
              ),
              itemCount: educations.length,
              itemBuilder: (context, index) => _EducationCard(
                  education: educations[index],
                  index: index,
                  isMobile: constraints.maxWidth < 600),
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
          padding: EdgeInsets.zero, // إزالة الـ padding الافتراضي لمنع التداخل
          child: Padding(
            padding: EdgeInsets.all(widget.isMobile ? 12.0 : 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: 300.ms,
                  padding: EdgeInsets.all(_isHovered ? 12 : 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .primaryColor
                          .withOpacity(_isHovered ? 0.2 : 0.1),
                      shape: BoxShape.circle),
                  child: Icon(Icons.school,
                      color: Theme.of(context).primaryColor,
                      size: widget.isMobile ? 32 : 36),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.education.degree,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: widget.isMobile ? 14 : 16,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.education.school,
                  textAlign: TextAlign.center,
                  maxLines: 2, // زيادة عدد الأسطر للمدرسة أيضاً عند الحاجة
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: PurpleTheme.primaryPurple,
                        fontSize: widget.isMobile ? 12 : 14,
                      ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.education.period,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.isMobile ? 10 : 11,
                        ),
                  ),
                ),
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

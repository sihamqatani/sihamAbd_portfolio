import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';

import '../../../../core/theme/purple_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/project.dart';
import '../pages/project_details_page.dart';

class ProjectsSection extends StatefulWidget {
  final List<Project> projects;

  const ProjectsSection({super.key, required this.projects});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late PageController _pageController;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!;
        });
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white24 : Colors.black12;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            l10n.projects,
            style: Theme.of(context).textTheme.displayMedium,
          ).animate().fadeIn().slideX(),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 480,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.projects.length,
            itemBuilder: (context, index) {
              final project = widget.projects[index];

              // 3D Animation Logic with Easing
              final double relativePosition = index - _currentPage;
              final double absPosition = relativePosition.abs();

              // Use an easing curve for the factor to make it feel smoother
              final double factor =
                  (1.0 - (absPosition.clamp(0.0, 1.0))).toDouble();
              final double easedFactor = Curves.easeOutCubic.transform(factor);

              final double scale = 0.82 + (easedFactor * 0.18);
              final double opacity = 0.6 + (easedFactor * 0.4);
              final double rotation =
                  (relativePosition.clamp(-1.0, 1.0) * 0.4).toDouble();

              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateY(rotation)
                  ..scale(scale),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: opacity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProjectDetailsPage(project: project),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: GlassContainer(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: 'project_image_${project.id}',
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.05)
                                      : PurpleTheme.primaryPurple
                                          .withOpacity(0.05),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(18),
                                  ),
                                ),
                                child: project.imageUrl != null
                                    ? ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(18),
                                        ),
                                        child: Image.asset(
                                          project.imageUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Center(
                                        child: Icon(Icons.image,
                                            size: 70, color: iconColor),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    project.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: project.tags
                                        .take(3)
                                        .map(
                                          (tag) => Chip(
                                            label: Text(
                                              tag,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: PurpleTheme
                                                .primaryPurple
                                                .withOpacity(0.8),
                                            padding: EdgeInsets.zero,
                                            visualDensity:
                                                VisualDensity.compact,
                                            side: BorderSide.none,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        // Pagination Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.projects.length,
            (index) {
              final double activeFactor =
                  (1 - (index - _currentPage).abs()).clamp(0.0, 1.0);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: 8 + (activeFactor * 16), // Expands when active
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: PurpleTheme.primaryPurple.withOpacity(
                    0.2 + (activeFactor * 0.8),
                  ),
                  boxShadow: [
                    if (activeFactor > 0.5)
                      BoxShadow(
                        color: PurpleTheme.primaryPurple.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

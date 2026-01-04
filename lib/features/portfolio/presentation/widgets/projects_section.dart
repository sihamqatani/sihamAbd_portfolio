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
    _pageController = PageController(viewportFraction: 0.85)
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            l10n.projects,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 36 : 45,
                ),
          ).animate().fadeIn().slideX(),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: isMobile ? 380 : 320,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(
                project: widget.projects[index],
                index: index,
                currentPage: _currentPage,
                isMobile: isMobile,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        ProjectPagination(
          itemCount: widget.projects.length,
          currentPage: _currentPage,
        ),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;
  final int index;
  final double currentPage;
  final bool isMobile;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.currentPage,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double relativePosition = index - currentPage;
    final double absPosition = relativePosition.abs();
    final double factor = (1.0 - (absPosition.clamp(0.0, 1.0))).toDouble();
    final double easedFactor = Curves.easeOutCubic.transform(factor);

    final double scale = 0.85 + (easedFactor * 0.15);
    final double opacity = 0.6 + (easedFactor * 0.4);
    final double rotation =
        (relativePosition.clamp(-1.0, 1.0) * 0.3).toDouble();

    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(rotation)
        ..scale(scale),
      alignment: Alignment.center,
      child: Opacity(
        opacity: opacity,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProjectDetailsPage(project: project),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: GlassContainer(
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Positioned(
                      top: -15,
                      right: -10,
                      child: Text(
                        '0${index + 1}',
                        style: TextStyle(
                          fontSize: 110,
                          fontWeight: FontWeight.w900,
                          color: PurpleTheme.primaryPurple.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'project_image_${project.id}',
                            child: Container(
                              width: isMobile ? 80 : 90,
                              height: isMobile ? 80 : 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: PurpleTheme.primaryPurple
                                        .withOpacity(0.3),
                                    blurRadius: 25,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(isMobile ? 12 : 15),
                              child: project.imageUrl != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.asset(
                                        project.imageUrl!,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : Icon(Icons.apps,
                                      size: isMobile ? 40 : 45,
                                      color: PurpleTheme.primaryPurple),
                            ),
                          ),
                          SizedBox(width: isMobile ? 16 : 24),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  project.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.black87,
                                        height: 1.5,
                                        fontSize: 14,
                                      ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: project.tags.take(2).map((tag) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: PurpleTheme.primaryPurple
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: PurpleTheme.primaryPurple
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                          child: Text(
                                            tag,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: PurpleTheme.primaryPurple,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: PurpleTheme.primaryPurple
                                          .withOpacity(0.8),
                                      size: 24,
                                    ).animate(onPlay: (c) => c.repeat()).moveX(
                                          begin: 0,
                                          end: 6,
                                          duration: 1000.ms,
                                          curve: Curves.easeInOut,
                                        ),
                                  ],
                                ),
                              ],
                            ),
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
      ),
    );
  }
}

class ProjectPagination extends StatelessWidget {
  final int itemCount;
  final double currentPage;

  const ProjectPagination({
    super.key,
    required this.itemCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          final double activeFactor =
              (1 - (index - currentPage).abs()).clamp(0.0, 1.0);
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: 8 + (activeFactor * 16),
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
    );
  }
}

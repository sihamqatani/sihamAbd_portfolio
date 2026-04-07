import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';

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
        if (mounted) {
          setState(() {
            _currentPage = _pageController.page!;
          });
        }
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
          height: isMobile ? 420 : 380,
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

class ProjectCard extends StatefulWidget {
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
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _liftAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _liftAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onEnter(PointerEvent details) {
    if (mounted) {
      setState(() => _isHovered = true);
      _hoverController.forward();
    }
  }

  void _onExit(PointerEvent details) {
    if (mounted) {
      setState(() => _isHovered = false);
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Carousel transformation logic
    final double relativePosition = widget.index - widget.currentPage;
    final double absPosition = relativePosition.abs();
    final double factor = (1.0 - (absPosition.clamp(0.0, 1.0))).toDouble();
    final double opacity = 0.5 + (factor * 0.5);
    final double rotation = -(relativePosition.clamp(-1.0, 1.0) * 0.1);

    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(rotation)
        ..scale(0.9 + (factor * 0.1)),
      alignment: Alignment.center,
      child: Opacity(
        opacity: opacity,
        child: MouseRegion(
          onEnter: _onEnter,
          onExit: _onExit,
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProjectDetailsPage(project: widget.project),
                ),
              );
            },
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _hoverController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _liftAnimation.value),
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor.withOpacity(
                                  isDark ? (_isHovered ? 0.4 : 0.15) : 0.2),
                              blurRadius: _isHovered ? 30 : 20,
                              offset: Offset(0, _isHovered ? 15 : 10),
                              spreadRadius: _isHovered ? 2 : 0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            children: [
                              // 1. Background
                              Container(
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF1E1E24)
                                      : Colors.white,
                                ),
                              ),

                              // 2. Content Layout
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image Section (Top 55%)
                                  Expanded(
                                    flex: 11,
                                    child: _buildImageSection(isDark),
                                  ),
                                  // Info Section (Bottom 45%)
                                  Expanded(
                                    flex: 9,
                                    child: _buildInfoSection(context, isDark),
                                  ),
                                ],
                              ),

                              // 3. Hover Border Overlay
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: _isHovered
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(bool isDark) {
    return Container(
      width: double.infinity,
      color: isDark ? Colors.black26 : Colors.grey[100],
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Atmosphere - Blurred Background
          if (widget.project.imageUrl != null)
            ImageFiltered(
              imageFilter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: widget.project.imageUrl!.startsWith('http')
                  ? Image.network(
                      widget.project.imageUrl!,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.4),
                      colorBlendMode: BlendMode.darken,
                    )
                  : Image.asset(
                      widget.project.imageUrl!,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.4),
                      colorBlendMode: BlendMode.darken,
                    ),
            ),

          // 2. The Main Image - Contained
          if (widget.project.imageUrl != null)
            Center(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: -2,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.project.imageUrl!.startsWith('http')
                      ? Image.network(
                          widget.project.imageUrl!,
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          widget.project.imageUrl!,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            )
          else
            _buildDynamicPlaceholder(),
        ],
      ),
    );
  }

  Widget _buildDynamicPlaceholder() {
    // Generate initials from project title
    String initials = "";
    if (widget.project.title.isNotEmpty) {
      final words = widget.project.title.trim().split(RegExp(r'\s+'));
      if (words.length > 1) {
        initials = '${words[0][0]}${words[1][0]}'.toUpperCase();
      } else {
        initials = words[0].substring(0, words[0].length >= 2 ? 2 : 1).toUpperCase();
      }
    }

    // Determine icon based on tags
    IconData projectIcon = Icons.code_rounded;
    final tagsStr = widget.project.tags.join(' ').toLowerCase();
    if (tagsStr.contains('flutter') || tagsStr.contains('app') || tagsStr.contains('mobile')) {
      projectIcon = Icons.phone_iphone_rounded;
    } else if (tagsStr.contains('web') || tagsStr.contains('react') || tagsStr.contains('angular')) {
      projectIcon = Icons.language_rounded;
    } else if (tagsStr.contains('api') || tagsStr.contains('backend') || tagsStr.contains('node')) {
      projectIcon = Icons.api_rounded;
    } else if (tagsStr.contains('ui') || tagsStr.contains('design') || tagsStr.contains('figma')) {
      projectIcon = Icons.design_services_rounded;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.8),
            Theme.of(context).primaryColor.withOpacity(0.4),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Floating orbs background effect
          Positioned(
            top: -20,
            left: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).moveX(begin: 0, end: 20, duration: 4.seconds),
          ),
          Positioned(
            bottom: -30,
            right: -10,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: 0, end: -15, duration: 3.seconds),
          ),
          
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(
                projectIcon,
                size: 48,
                color: Colors.white.withOpacity(0.9),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .shake(hz: 4, curve: Curves.easeInOut, rotation: 0.1, duration: 2.seconds)
               .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds)
               .shimmer(delay: 1.seconds, duration: 1.seconds, color: Colors.white),
               const SizedBox(height: 12),
               Text(
                 initials,
                 style: const TextStyle(
                   fontSize: 42,
                   fontWeight: FontWeight.w900,
                   color: Colors.white54,
                   letterSpacing: 4,
                 ),
               ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tags
          Row(
            children: widget.project.tags
                .take(3)
                .map((tag) => _buildTag(tag, isDark))
                .toList(),
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            widget.project.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  letterSpacing: -0.5,
                  color: isDark ? Colors.white : const Color(0xFF2D2D2D),
                ),
          ),

          const SizedBox(height: 8),

          // Description
          Expanded(
            child: Text(
              widget.project.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.white70 : Colors.black54,
                    height: 1.5,
                  ),
            ),
          ),

          const SizedBox(height: 12),

          // "View Project" CTA
          Row(
            children: [
              Text(
                "View Details",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor.withOpacity(
                    0.2 + (activeFactor * 0.8),
                  ),
              boxShadow: [
                if (activeFactor > 0.5)
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
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

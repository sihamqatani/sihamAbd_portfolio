import 'dart:ui' as ui; // Added for ImageFilter

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/core/theme/purple_theme.dart';
import 'package:purple_portfolio/core/widgets/glass_container.dart';
import 'package:purple_portfolio/features/portfolio/domain/entities/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0D0815) : const Color(0xFFF5F5F7),
      body: CustomScrollView(
        slivers: [
          // 1. Immersive Sliver AppBar
          SliverAppBar(
            expandedHeight: 400.0,
            floating: false,
            pinned: true,
            backgroundColor: isDark ? const Color(0xFF0D0815) : Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.3),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Blurred Background
                  if (project.imageUrl != null)
                    ImageFiltered(
                      imageFilter: ui.ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Image.asset(
                        project.imageUrl!,
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.5),
                        colorBlendMode: BlendMode.darken,
                      ),
                    )
                  else
                    Container(
                      color: PurpleTheme.primaryPurple,
                    ),

                  // Gradient Fade (Bottom)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            isDark
                                ? const Color(0xFF0D0815)
                                : const Color(0xFFF5F5F7),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Centered Hero Image
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: Hero(
                        tag: 'project_image_${project.id}',
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 280),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 30,
                                spreadRadius: -5,
                                offset: const Offset(0, 20),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: project.imageUrl != null
                                ? Image.asset(
                                    project.imageUrl!,
                                    fit: BoxFit.contain,
                                  )
                                : const Icon(Icons.broken_image,
                                    size: 100, color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Content Body
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Links Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          project.title,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 32,
                                height: 1.1,
                              ),
                        ).animate().fadeIn().slideY(begin: 0.2),
                      ),

                      // Links
                      Row(
                        children: [
                          if (project.link != null && project.link!.isNotEmpty)
                            _StoreButton(
                              icon: Icons.play_circle_fill,
                              url: project.link!,
                            ),
                          if (project.appStoreLink != null)
                            _StoreButton(
                              icon: Icons.apple,
                              url: project.appStoreLink!,
                            ),
                          if (project.playStoreLink != null)
                            _StoreButton(
                              icon: Icons
                                  .android, // Using android icon for play store generic
                              url: project.playStoreLink!,
                            ),
                        ],
                      ).animate().fadeIn(delay: 100.ms),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Tags Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.tags
                        .map((tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color:
                                    PurpleTheme.primaryPurple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: PurpleTheme.primaryPurple
                                      .withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  color: PurpleTheme.primaryPurple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ))
                        .toList(),
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 32),

                  // About Section
                  Text(
                    "About Project",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ).animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 12),

                  GlassContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            color: isDark ? Colors.white70 : Colors.black87,
                            fontSize: 16,
                          ),
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreButton extends StatelessWidget {
  final IconData icon;
  final String url;

  const _StoreButton({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url)),
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: PurpleTheme.primaryPurple,
            boxShadow: [
              BoxShadow(
                color: PurpleTheme.primaryPurple.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

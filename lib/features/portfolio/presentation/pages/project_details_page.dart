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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.black26,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Section (Premium Aligned Icon)
            Container(
              height: isMobile ? 250 : 300,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    PurpleTheme.primaryPurple.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Hero(
                      tag: 'project_image_${project.id}',
                      child: Container(
                        width: isMobile ? 100 : 120,
                        height: isMobile ? 100 : 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(isMobile ? 24 : 30),
                          boxShadow: [
                            BoxShadow(
                              color: PurpleTheme.primaryPurple.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(isMobile ? 14 : 18),
                        child: project.imageUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: project.imageUrl!.startsWith('http')
                                    ? Image.network(
                                        project.imageUrl!,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.asset(
                                        project.imageUrl!,
                                        fit: BoxFit.contain,
                                      ),
                              )
                            : Icon(Icons.apps,
                                size: isMobile ? 50 : 60,
                                color: PurpleTheme.primaryPurple),
                      ),
                    ).animate().fadeIn().scale(delay: 100.ms),
                    SizedBox(width: isMobile ? 16 : 20),
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile ? 26 : 32,
                                ),
                          ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1),
                          const SizedBox(height: 8),
                          Text(
                            'Project Overview',
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white54
                                  : PurpleTheme.primaryPurple.withOpacity(0.7),
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                              fontSize: isMobile ? 10 : 12,
                            ),
                          ).animate().fadeIn(delay: 300.ms),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Floating Store Icons
                      if (project.appStoreLink != null ||
                          project.playStoreLink != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: PurpleTheme.primaryPurple.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              if (project.appStoreLink != null)
                                _StoreIconButton(
                                  icon: Icons.apple,
                                  onPressed: () => launchUrl(
                                      Uri.parse(project.appStoreLink!)),
                                ),
                              if (project.playStoreLink != null)
                                _StoreIconButton(
                                  icon: Icons.play_arrow,
                                  onPressed: () => launchUrl(
                                      Uri.parse(project.playStoreLink!)),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ).animate().fadeIn().slideY(begin: 0.2),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.tags
                        .map(
                          (tag) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: PurpleTheme.primaryPurple.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    PurpleTheme.primaryPurple.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: PurpleTheme.primaryPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        )
                        .toList(),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 32),
                  Text(
                    'About Project',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 12),
                  GlassContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _StoreIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: PurpleTheme.primaryPurple.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: PurpleTheme.primaryPurple.withOpacity(0.3),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: PurpleTheme.primaryPurple),
        onPressed: onPressed,
      ),
    );
  }
}

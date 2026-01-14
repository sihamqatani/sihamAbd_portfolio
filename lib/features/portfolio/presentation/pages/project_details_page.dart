import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/features/portfolio/domain/entities/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;
  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0710) : Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: isMobile ? 300.0 : 400.0,
            pinned: true,
            backgroundColor: isDark ? const Color(0xFF0D0815) : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Atmospheric background
                  if (project.imageUrl != null)
                    Image.asset(project.imageUrl!, fit: BoxFit.cover),
                  Container(
                      decoration: BoxDecoration(
                          color: (isDark ? Colors.black : Colors.white)
                              .withOpacity(0.6))),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: isMobile ? 50 : 60,
                        bottom: isMobile ? 10 : 20,
                      ),
                      child: Hero(
                        tag: 'project_image_${project.id}',
                        child: Container(
                          constraints:
                              BoxConstraints(maxHeight: isMobile ? 200 : 280),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 20)
                              ]),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: project.imageUrl != null
                                  ? Image.asset(project.imageUrl!,
                                      fit: BoxFit.contain)
                                  : const Icon(Icons.image_not_supported)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 24.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(project.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: isMobile ? 26 : 32))
                            .animate()
                            .fadeIn()
                            .slideY(begin: 0.2),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          if (project.link != null && project.link!.isNotEmpty)
                            _StoreButton(
                                icon: Icons.play_circle_fill,
                                url: project.link!),
                          if (project.appStoreLink != null)
                            _StoreButton(
                                icon: Icons.apple, url: project.appStoreLink!),
                          if (project.playStoreLink != null)
                            _StoreButton(
                                icon: Icons.android,
                                url: project.playStoreLink!),
                        ],
                      ).animate().fadeIn(delay: 100.ms),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(project.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(height: 1.6))
                      .animate()
                      .fadeIn(delay: 200.ms),
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
    return IconButton(
      icon: Icon(icon, color: Theme.of(context).primaryColor, size: 28),
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
    );
  }
}

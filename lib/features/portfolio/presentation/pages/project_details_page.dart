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
                    project.imageUrl!.startsWith('http')
                        ? Image.network(project.imageUrl!, fit: BoxFit.cover)
                        : Image.asset(project.imageUrl!, fit: BoxFit.cover)
                  else
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.8),
                            Theme.of(context).primaryColor.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
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
                                  ? (project.imageUrl!.startsWith('http')
                                      ? Image.network(project.imageUrl!,
                                          fit: BoxFit.contain)
                                      : Image.asset(project.imageUrl!,
                                          fit: BoxFit.contain))
                                  : _buildDynamicPlaceholder(context)),
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
                          if (project.videoLink != null &&
                              project.videoLink!.isNotEmpty)
                            _StoreButton(
                                icon: Icons.ondemand_video_rounded,
                                url: project.videoLink!),
                          if (project.link != null && project.link!.isNotEmpty)
                            _StoreButton(icon: Icons.link, url: project.link!),
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

  Widget _buildDynamicPlaceholder(BuildContext context) {
    // Generate initials from project title
    String initials = "";
    if (project.title.isNotEmpty) {
      final words = project.title.trim().split(RegExp(r'\s+'));
      if (words.length > 1) {
        initials = '${words[0][0]}${words[1][0]}'.toUpperCase();
      } else {
        initials = words[0]
            .substring(0, words[0].length >= 2 ? 2 : 1)
            .toUpperCase();
      }
    }

    // Determine icon based on tags
    IconData projectIcon = Icons.code_rounded;
    final tagsStr = project.tags.join(' ').toLowerCase();
    if (tagsStr.contains('flutter') ||
        tagsStr.contains('app') ||
        tagsStr.contains('mobile')) {
      projectIcon = Icons.phone_iphone_rounded;
    } else if (tagsStr.contains('web') ||
        tagsStr.contains('react') ||
        tagsStr.contains('angular')) {
      projectIcon = Icons.language_rounded;
    } else if (tagsStr.contains('api') ||
        tagsStr.contains('backend') ||
        tagsStr.contains('node')) {
      projectIcon = Icons.api_rounded;
    } else if (tagsStr.contains('ui') ||
        tagsStr.contains('design') ||
        tagsStr.contains('figma')) {
      projectIcon = Icons.design_services_rounded;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background subtle fill
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
          
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                projectIcon,
                size: 64,
                color: Theme.of(context).primaryColor,
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .shake(hz: 4, curve: Curves.easeInOut, rotation: 0.1, duration: 2.seconds)
               .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds)
               .shimmer(delay: 1.seconds, duration: 1.seconds, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                initials,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  letterSpacing: 4,
                ),
              ),
            ],
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

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purple_portfolio/core/theme/purple_theme.dart';
import 'package:purple_portfolio/core/widgets/glass_container.dart';
import 'package:purple_portfolio/features/portfolio/domain/entities/project.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'project_image_${project.id}',
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black26
                      : PurpleTheme.primaryPurple.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Icon(Icons.image,
                      size: 100,
                      color: isDark ? Colors.white24 : Colors.black12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    children: project.tags
                        .map(
                          (tag) => Chip(
                            label: Text(tag),
                            backgroundColor:
                                PurpleTheme.primaryPurple.withOpacity(0.5),
                          ),
                        )
                        .toList(),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 30),
                  GlassContainer(
                    width: double.infinity,
                    child: Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

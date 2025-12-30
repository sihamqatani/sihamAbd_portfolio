import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/language_cubit.dart';
import '../../../../core/bloc/theme_cubit.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../bloc/portfolio_cubit.dart';
import '../bloc/portfolio_state.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          if (state.status == PortfolioStatus.loading) {
            return const PurpleLoadingIndicator();
          } else if (state.status == PortfolioStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          // Using a ListView allows for lazy building, which triggers
          // admission animations (FlyIn/FadeIn) correctly as you scroll.
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  const SizedBox(height: 50),
                  // NavBar
                  _buildNavBar(context),
                  const SizedBox(height: 50),

                  // Sections
                  const HeroSection(),
                  const SizedBox(height: 100),
                  SkillsSection(skills: state.skills),
                  const SizedBox(height: 100),
                  ExperienceSection(experiences: state.experiences),
                  const SizedBox(height: 100),
                  EducationSection(educations: state.educations),
                  const SizedBox(height: 100),
                  ProjectsSection(projects: state.projects),
                  const SizedBox(height: 100),
                  const ContactSection(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavBar(BuildContext context) {
    // Check current theme mode to show appropriate icon
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                    turns: child.key == const ValueKey('dark_icon')
                        ? Tween<double>(begin: 1, end: 0.75).animate(animation)
                        : Tween<double>(begin: 0.75, end: 1).animate(animation),
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  key: ValueKey(isDark ? 'light_icon' : 'dark_icon'),
                  color: primaryColor,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.language, color: primaryColor),
              onPressed: () {
                context.read<LanguageCubit>().toggleLanguage();
              },
            ),
          ],
        ),
      ],
    );
  }
}

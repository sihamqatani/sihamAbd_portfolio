import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purple_portfolio/core/theme/purple_theme.dart';

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
      body: Stack(
        children: [
          // Premium Background Base
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: Theme.of(context).brightness == Brightness.dark
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0A0710),
                          Color(0xFF130B1D),
                          Color(0xFF07050A),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFBEDEF),
                          Color(0xFFFFF5F7),
                          Color(0xFFFBEDEF),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
              ),
            ),
          ),
          // Vibrant Animated Glows
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(
                  top: -150,
                  right: -100,
                  child: Container(
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? PurpleTheme.primaryPurple.withOpacity(0.12)
                          : PurpleTheme.primaryPurple.withOpacity(0.06),
                    ),
                  ).animate(onPlay: (c) => c.repeat(reverse: true)).move(
                      begin: const Offset(0, 0),
                      end: const Offset(-80, 80),
                      duration: 10.seconds,
                      curve: Curves.easeInOut),
                ),
                Positioned(
                  bottom: -150,
                  left: -100,
                  child: Container(
                    width: 600,
                    height: 600,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? PurpleTheme.lightPurple.withOpacity(0.08)
                          : PurpleTheme.lightPurple.withOpacity(0.12),
                    ),
                  ).animate(onPlay: (c) => c.repeat(reverse: true)).move(
                      begin: const Offset(0, 0),
                      end: const Offset(100, -100),
                      duration: 15.seconds,
                      curve: Curves.easeInOut),
                ),
                // Middle floating orb
                Positioned(
                  top: 200,
                  left: 200,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? PurpleTheme.primaryPurple.withOpacity(0.05)
                          : PurpleTheme.primaryPurple.withOpacity(0.03),
                    ),
                  ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.5, 1.5),
                      duration: 12.seconds,
                      curve: Curves.easeInOut),
                ),
              ],
            ),
          ),
          BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, state) {
              if (state.status == PortfolioStatus.loading) {
                return const PurpleLoadingIndicator();
              } else if (state.status == PortfolioStatus.failure) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    children: [
                      const SizedBox(height: 50),
                      const HomeNavBar(),
                      const SizedBox(height: 50),
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
        ],
      ),
    );
  }
}

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
      ],
    );
  }
}

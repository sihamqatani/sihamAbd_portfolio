import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/purple_theme.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../bloc/portfolio_cubit.dart';
import '../bloc/portfolio_state.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/home_nav_bar.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
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
                          Color(0xFF07050A)
                        ],
                        stops: [0.0, 0.5, 1.0],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFBEDEF),
                          Color(0xFFFFF5F7),
                          Color(0xFFFBEDEF)
                        ],
                      ),
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRect(
              child: Stack(
                children: [
                  Positioned(
                    top: -150,
                    right: isMobile ? -150 : -100,
                    child: RepaintBoundary(
                      child: _buildGlowOrb(
                          context,
                          isMobile ? 300 : 500,
                          PurpleTheme.primaryPurple.withOpacity(0.12),
                          10.seconds,
                          Offset(isMobile ? -40 : -80, isMobile ? 40 : 80)),
                    ),
                  ),
                  Positioned(
                    bottom: -150,
                    left: isMobile ? -150 : -100,
                    child: RepaintBoundary(
                      child: _buildGlowOrb(
                          context,
                          isMobile ? 350 : 600,
                          PurpleTheme.lightPurple.withOpacity(0.08),
                          15.seconds,
                          Offset(isMobile ? 50 : 100, isMobile ? -50 : -100)),
                    ),
                  ),
                  if (!isMobile)
                    Positioned(
                      top: 200,
                      left: 200,
                      child: RepaintBoundary(
                        child: Container(
                          width: 400,
                          height: 400,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: PurpleTheme.primaryPurple.withOpacity(0.05),
                          ),
                        ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.5, 1.5),
                            duration: 12.seconds),
                      ),
                    ),
                ],
              ),
            ),
          ),
          BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, state) {
              if (state.status == PortfolioStatus.loading) {
                return const PurpleLoadingIndicator();
              }
              if (state.status == PortfolioStatus.success) {
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16.0 : 20.0),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              children: [
                                SizedBox(height: isMobile ? 30 : 50),
                                const Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: HomeNavBar(),
                                ),
                                SizedBox(height: isMobile ? 30 : 50),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16.0 : 20.0),
                          sliver: const SliverToBoxAdapter(
                            child: HeroSection(),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(height: isMobile ? 60 : 100)),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16.0 : 20.0),
                          sliver: SliverToBoxAdapter(
                            child: SkillsSection(skills: state.skills),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(height: isMobile ? 60 : 100)),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16.0 : 20.0),
                          sliver: SliverToBoxAdapter(
                            child: ExperienceSection(
                                experiences: state.experiences),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(height: isMobile ? 60 : 100)),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16.0 : 20.0),
                          sliver: SliverToBoxAdapter(
                            child:
                                EducationSection(educations: state.educations),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(height: isMobile ? 60 : 100)),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16.0 : 20.0),
                          sliver: SliverToBoxAdapter(
                            child: ProjectsSection(projects: state.projects),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(height: isMobile ? 60 : 100)),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16.0 : 20.0),
                          sliver: const SliverToBoxAdapter(
                            child: ContactSection(),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(height: isMobile ? 30 : 50)),
                      ],
                    ),
                  ),
                );
              }
              if (state.status == PortfolioStatus.failure) {
                return Center(child: Text(state.errorMessage ?? 'Error'));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGlowOrb(BuildContext context, double size, Color color,
      Duration duration, Offset endOffset) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).move(
        begin: Offset.zero,
        end: endOffset,
        duration: duration,
        curve: Curves.easeInOut);
  }
}

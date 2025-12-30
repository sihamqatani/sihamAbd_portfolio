import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purple_portfolio/features/portfolio/domain/entities/education.dart';
import 'package:purple_portfolio/features/portfolio/domain/entities/experience.dart';
import 'package:purple_portfolio/features/portfolio/domain/entities/project.dart';
import 'package:purple_portfolio/features/portfolio/domain/entities/skill.dart';

import '../../domain/usecases/get_educations.dart';
import '../../domain/usecases/get_experiences.dart';
import '../../domain/usecases/get_projects.dart';
import '../../domain/usecases/get_skills.dart';
import 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final GetProjects getProjects;
  final GetSkills getSkills;
  final GetExperiences getExperiences;
  final GetEducations getEducations;

  PortfolioCubit({
    required this.getProjects,
    required this.getSkills,
    required this.getExperiences,
    required this.getEducations,
  }) : super(const PortfolioState());

  Future<void> loadPortfolioData() async {
    emit(state.copyWith(status: PortfolioStatus.loading));
    try {
      // Execute all use cases in parallel
      final results = await Future.wait([
        getProjects(),
        getSkills(),
        getExperiences(),
        getEducations(),
      ]);

      final projects = results[0] as List<Project>;
      final skills = results[1] as List<Skill>;
      final experiences = results[2] as List<Experience>;
      final educations = results[3] as List<Education>;

      emit(
        state.copyWith(
          status: PortfolioStatus.success,
          projects: projects,
          skills: skills,
          experiences: experiences,
          educations: educations,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PortfolioStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

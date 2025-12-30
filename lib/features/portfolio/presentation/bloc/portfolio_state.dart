import 'package:equatable/equatable.dart';

import '../../domain/entities/education.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill.dart';

enum PortfolioStatus { initial, loading, success, failure }

class PortfolioState extends Equatable {
  final PortfolioStatus status;
  final List<Project> projects;
  final List<Skill> skills;
  final List<Experience> experiences;
  final List<Education> educations;
  final String? errorMessage;

  const PortfolioState({
    this.status = PortfolioStatus.initial,
    this.projects = const [],
    this.skills = const [],
    this.experiences = const [],
    this.educations = const [],
    this.errorMessage,
  });

  PortfolioState copyWith({
    PortfolioStatus? status,
    List<Project>? projects,
    List<Skill>? skills,
    List<Experience>? experiences,
    List<Education>? educations,
    String? errorMessage,
  }) {
    return PortfolioState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      skills: skills ?? this.skills,
      experiences: experiences ?? this.experiences,
      educations: educations ?? this.educations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, projects, skills, experiences, educations, errorMessage];
}

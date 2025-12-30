import '../../domain/entities/education.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioDataSource dataSource;

  PortfolioRepositoryImpl({required this.dataSource});

  @override
  Future<List<Project>> getProjects() async {
    return await dataSource.getProjects();
  }

  @override
  Future<List<Skill>> getSkills() async {
    return await dataSource.getSkills();
  }

  @override
  Future<List<Experience>> getExperiences() async {
    return await dataSource.getExperiences();
  }

  @override
  Future<List<Education>> getEducations() async {
    return await dataSource.getEducations();
  }
}

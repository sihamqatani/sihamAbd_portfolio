import '../../domain/entities/experience.dart';
import '../../domain/repositories/portfolio_repository.dart';

class GetExperiences {
  final PortfolioRepository repository;

  GetExperiences(this.repository);

  Future<List<Experience>> call() async {
    return await repository.getExperiences();
  }
}

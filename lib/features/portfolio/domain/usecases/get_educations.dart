import '../../domain/entities/education.dart';
import '../../domain/repositories/portfolio_repository.dart';

class GetEducations {
  final PortfolioRepository repository;

  GetEducations(this.repository);

  Future<List<Education>> call() async {
    return await repository.getEducations();
  }
}

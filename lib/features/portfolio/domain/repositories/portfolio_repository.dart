// Let's stick to simple Futures for simplicity in this prompt, OR return a simple Result class.
// Actually, simple Future<List<Entity>> is fine for a portfolio.

import '../entities/education.dart';
import '../entities/experience.dart';
import '../entities/project.dart';
import '../entities/skill.dart';

abstract class PortfolioRepository {
  Future<List<Project>> getProjects();
  Future<List<Skill>> getSkills();
  Future<List<Experience>> getExperiences();
  Future<List<Education>> getEducations();
}

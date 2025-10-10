import '../entities/celestial_body.dart';
import '../repositories/planet_repository.dart';

/// Use case for getting all planets
/// Implements Clean Architecture use case pattern
class GetAllPlanets {
  final PlanetRepository repository;

  GetAllPlanets(this.repository);

  Future<List<Planet>> call() async {
    return await repository.getAllPlanets();
  }
}

import '../repositories/planet_repository.dart';
import '../../data/datasources/solar_system_data.dart';

/// Use case for seeding solar system data into database
class SeedSolarSystem {
  final PlanetRepository repository;

  SeedSolarSystem(this.repository);

  /// Seed all solar system planets into database
  Future<void> call() async {
    final planets = SolarSystemData.getAllPlanets();

    for (final planet in planets) {
      await repository.savePlanet(planet);
    }
  }

  /// Check if database is already seeded
  Future<bool> isSeeded() async {
    final planets = await repository.getAllPlanets();
    return planets.isNotEmpty;
  }
}

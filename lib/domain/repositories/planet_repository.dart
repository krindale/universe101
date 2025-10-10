import '../entities/celestial_body.dart';

/// Repository interface for Planet data
/// Defines contract for data operations (Clean Architecture)
abstract class PlanetRepository {
  /// Get all planets
  Future<List<Planet>> getAllPlanets();

  /// Get planet by ID
  Future<Planet?> getPlanetById(String id);

  /// Insert or update planet
  Future<void> savePlanet(Planet planet);

  /// Delete planet
  Future<void> deletePlanet(String id);

  /// Search planets by name
  Future<List<Planet>> searchPlanets(String query);
}

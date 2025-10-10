import '../../domain/entities/celestial_body.dart';
import '../../domain/repositories/planet_repository.dart';
import '../datasources/database_helper.dart';

/// Implementation of PlanetRepository
/// Handles data persistence using DatabaseHelper
class PlanetRepositoryImpl implements PlanetRepository {
  final DatabaseHelper _databaseHelper;

  PlanetRepositoryImpl(this._databaseHelper);

  @override
  Future<List<Planet>> getAllPlanets() async {
    return await _databaseHelper.getAllPlanets();
  }

  @override
  Future<Planet?> getPlanetById(String id) async {
    return await _databaseHelper.getPlanetById(id);
  }

  @override
  Future<void> savePlanet(Planet planet) async {
    final existing = await _databaseHelper.getPlanetById(planet.id);
    if (existing != null) {
      await _databaseHelper.updatePlanet(planet);
    } else {
      await _databaseHelper.insertPlanet(planet);
    }
  }

  @override
  Future<void> deletePlanet(String id) async {
    await _databaseHelper.deletePlanet(id);
  }

  @override
  Future<List<Planet>> searchPlanets(String query) async {
    final allPlanets = await getAllPlanets();
    return allPlanets
        .where((planet) =>
            planet.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

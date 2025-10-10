import '../../data/datasources/space_exploration_data.dart';
import '../../data/datasources/database_helper.dart';

/// Use case for seeding space exploration data into the database
/// Implements Clean Architecture use case pattern
class SeedSpaceExplorations {
  final DatabaseHelper databaseHelper;

  SeedSpaceExplorations(this.databaseHelper);

  /// Seed all space exploration missions into the database
  Future<void> call() async {
    final explorations = SpaceExplorationData.getAllExplorations();
    for (final exploration in explorations) {
      await databaseHelper.insertExploration(exploration);
    }
  }

  /// Check if explorations have been seeded
  Future<bool> isSeeded() async {
    final explorations = await databaseHelper.getAllExplorations();
    return explorations.isNotEmpty;
  }
}

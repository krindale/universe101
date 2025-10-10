import '../../data/datasources/cosmic_phenomena_data.dart';
import '../../data/datasources/database_helper.dart';

/// Use case for seeding cosmic phenomena data into the database
/// Implements Clean Architecture use case pattern
class SeedCosmicPhenomena {
  final DatabaseHelper databaseHelper;

  SeedCosmicPhenomena(this.databaseHelper);

  /// Seed all cosmic phenomena into the database
  Future<void> call() async {
    final phenomena = CosmicPhenomenaData.getAllPhenomena();
    for (final phenomenon in phenomena) {
      await databaseHelper.insertPhenomenon(phenomenon);
    }
  }

  /// Check if phenomena have been seeded
  Future<bool> isSeeded() async {
    final phenomena = await databaseHelper.getAllPhenomena();
    return phenomena.isNotEmpty;
  }
}

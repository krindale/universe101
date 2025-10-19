import '../../domain/entities/cosmic_phenomenon.dart';
import 'phenomena/solar_eclipse.dart';
import 'phenomena/lunar_eclipse.dart';
import 'phenomena/aurora.dart';
import 'phenomena/supernova.dart';
import 'phenomena/black_hole.dart';
import 'phenomena/gravitational_lensing.dart';
import 'phenomena/meteor_shower.dart';
import 'phenomena/nebula_formation.dart';
import 'phenomena/comet_orbital_change.dart';

/// Cosmic phenomena data aggregator
/// Provides access to all cosmic phenomena
class CosmicPhenomenaData {
  CosmicPhenomenaData._();

  /// Get all cosmic phenomena
  static List<CosmicPhenomenon> getAllPhenomena() {
    return [
      solarEclipse,
      lunarEclipse,
      aurora,
      supernova,
      blackHole,
      gravitationalLensing,
      meteorShower,
      nebulaFormation,
      cometOrbitalChange,
    ];
  }
}

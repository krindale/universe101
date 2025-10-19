import '../../domain/entities/celestial_body.dart';
import 'solar_system/sun.dart';
import 'solar_system/mercury.dart';
import 'solar_system/venus.dart';
import 'solar_system/earth.dart';
import 'solar_system/mars.dart';
import 'solar_system/jupiter.dart';
import 'solar_system/saturn.dart';
import 'solar_system/uranus.dart';
import 'solar_system/neptune.dart';

/// Solar system data aggregator
/// Provides access to all solar system bodies
class SolarSystemData {
  SolarSystemData._();

  /// Get all solar system planets
  static List<Planet> getAllPlanets() {
    return [
      mercury,
      venus,
      earth,
      mars,
      jupiter,
      saturn,
      uranus,
      neptune,
    ];
  }

  /// Get the Sun
  static Star getSun() {
    return sun;
  }
}

import '../../domain/entities/space_exploration.dart';
import 'explorations/sputnik1.dart';
import 'explorations/apollo11.dart';
import 'explorations/voyager1.dart';
import 'explorations/voyager2.dart';
import 'explorations/hubble.dart';
import 'explorations/iss.dart';
import 'explorations/curiosity.dart';
import 'explorations/new_horizons.dart';
import 'explorations/perseverance.dart';
import 'explorations/jwst.dart';
import 'explorations/artemis1.dart';

/// Space exploration mission data aggregator
/// Provides access to all space exploration missions
class SpaceExplorationData {
  SpaceExplorationData._();

  /// Get all space exploration missions
  static List<SpaceExploration> getAllExplorations() {
    return [
      sputnik1,
      apollo11,
      voyager1,
      voyager2,
      hubble,
      iss,
      curiosity,
      newHorizons,
      perseverance,
      jwst,
      artemis1,
    ];
  }
}

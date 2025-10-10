class CelestialBody {
  final String name;
  final String description;
  final String imageUrl;
  final Map<String, String> facts;
  final List<String> episodes;

  CelestialBody({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.facts,
    required this.episodes,
  });
}

class Planet extends CelestialBody {
  final double diameter;
  final double distanceFromSun;
  final List<String> moons;

  Planet({
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.facts,
    required super.episodes,
    required this.diameter,
    required this.distanceFromSun,
    required this.moons,
  });
}

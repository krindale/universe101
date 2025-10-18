/// Base class for all celestial bodies (planets, stars, moons, etc.)
class CelestialBody {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String? modelUrl; // 3D model URL
  final Map<String, String> facts;
  final List<String> episodes;
  final CelestialBodyType type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CelestialBody({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.modelUrl,
    required this.facts,
    required this.episodes,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });

  /// Convert to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'modelUrl': modelUrl,
      'facts': facts,
      'episodes': episodes,
      'type': type.toString(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Create from JSON from database
  factory CelestialBody.fromJson(Map<String, dynamic> json) {
    return CelestialBody(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      modelUrl: json['modelUrl'] as String?,
      facts: Map<String, String>.from(json['facts'] as Map),
      episodes: List<String>.from(json['episodes'] as List),
      type: CelestialBodyType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => CelestialBodyType.planet,
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}

/// Types of celestial bodies
enum CelestialBodyType {
  planet,
  star,
  moon,
  asteroid,
  comet,
  galaxy,
  nebula,
}

/// Planet-specific model
class Planet extends CelestialBody {
  final double diameter; // in km
  final double distanceFromSun; // in AU (Astronomical Units)
  final double orbitalPeriod; // in Earth days
  final double rotationPeriod; // in Earth hours
  final double mass; // in Earth masses
  final double gravity; // in m/s²
  final List<String> moons;
  final bool hasRings;
  final String composition;

  Planet({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    super.modelUrl,
    required super.facts,
    required super.episodes,
    super.createdAt,
    super.updatedAt,
    required this.diameter,
    required this.distanceFromSun,
    required this.orbitalPeriod,
    required this.rotationPeriod,
    required this.mass,
    required this.gravity,
    required this.moons,
    this.hasRings = false,
    required this.composition,
  }) : super(type: CelestialBodyType.planet);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'diameter': diameter,
      'distanceFromSun': distanceFromSun,
      'orbitalPeriod': orbitalPeriod,
      'rotationPeriod': rotationPeriod,
      'mass': mass,
      'gravity': gravity,
      'moons': moons,
      'hasRings': hasRings,
      'composition': composition,
    });
    return json;
  }

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      modelUrl: json['modelUrl'] as String?,
      facts: Map<String, String>.from(json['facts'] as Map),
      episodes: List<String>.from(json['episodes'] as List),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      diameter: (json['diameter'] as num).toDouble(),
      distanceFromSun: (json['distanceFromSun'] as num).toDouble(),
      orbitalPeriod: (json['orbitalPeriod'] as num).toDouble(),
      rotationPeriod: (json['rotationPeriod'] as num).toDouble(),
      mass: (json['mass'] as num).toDouble(),
      gravity: (json['gravity'] as num).toDouble(),
      moons: List<String>.from(json['moons'] as List),
      hasRings: json['hasRings'] as bool? ?? false,
      composition: json['composition'] as String,
    );
  }
}

/// Star-specific model (for Sun and other stars)
class Star extends CelestialBody {
  final double diameter; // in km
  final double mass; // in solar masses
  final double surfaceTemperature; // in Kelvin
  final double luminosity; // in solar luminosities
  final String spectralType;
  final int age; // in billions of years
  final String composition;

  Star({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    super.modelUrl,
    required super.facts,
    required super.episodes,
    super.createdAt,
    super.updatedAt,
    required this.diameter,
    required this.mass,
    required this.surfaceTemperature,
    required this.luminosity,
    required this.spectralType,
    required this.age,
    required this.composition,
  }) : super(type: CelestialBodyType.star);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'diameter': diameter,
      'mass': mass,
      'surfaceTemperature': surfaceTemperature,
      'luminosity': luminosity,
      'spectralType': spectralType,
      'age': age,
      'composition': composition,
    });
    return json;
  }

  factory Star.fromJson(Map<String, dynamic> json) {
    return Star(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      modelUrl: json['modelUrl'] as String?,
      facts: Map<String, String>.from(json['facts'] as Map),
      episodes: List<String>.from(json['episodes'] as List),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      diameter: (json['diameter'] as num).toDouble(),
      mass: (json['mass'] as num).toDouble(),
      surfaceTemperature: (json['surfaceTemperature'] as num).toDouble(),
      luminosity: (json['luminosity'] as num).toDouble(),
      spectralType: json['spectralType'] as String,
      age: json['age'] as int,
      composition: json['composition'] as String,
    );
  }
}

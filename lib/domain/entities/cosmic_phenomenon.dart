/// Represents cosmic phenomena like eclipses, auroras, supernovas, etc.
class CosmicPhenomenon {
  final String id;
  final String name;
  final String description;
  final PhenomenonType type;
  final String imageUrl;
  final String? videoUrl;
  final Map<String, String> facts;
  final List<String> episodes;
  final DateTime? nextOccurrence;
  final String location; // Where it can be observed
  final int rarity; // 1-10 scale
  final List<String> relatedBodies; // IDs of related celestial bodies
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CosmicPhenomenon({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.imageUrl,
    this.videoUrl,
    required this.facts,
    required this.episodes,
    this.nextOccurrence,
    required this.location,
    required this.rarity,
    required this.relatedBodies,
    this.createdAt,
    this.updatedAt,
  });

  /// Convert to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.toString(),
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'facts': facts,
      'episodes': episodes,
      'nextOccurrence': nextOccurrence?.toIso8601String(),
      'location': location,
      'rarity': rarity,
      'relatedBodies': relatedBodies,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Create from JSON from database
  factory CosmicPhenomenon.fromJson(Map<String, dynamic> json) {
    // Handle facts - support both legacy List format and new Map format
    Map<String, String> parsedFacts;
    if (json['facts'] is List) {
      // Legacy format: List<String> - convert to Map with index as key
      final factsList = List<String>.from(json['facts'] as List);
      parsedFacts = {};
      for (int i = 0; i < factsList.length; i++) {
        parsedFacts['Fact ${i + 1}'] = factsList[i];
      }
    } else if (json['facts'] is Map) {
      // New format: Map<String, String>
      parsedFacts = Map<String, String>.from(json['facts'] as Map);
    } else {
      parsedFacts = {};
    }

    return CosmicPhenomenon(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: PhenomenonType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => PhenomenonType.other,
      ),
      imageUrl: json['imageUrl'] as String,
      videoUrl: json['videoUrl'] as String?,
      facts: parsedFacts,
      episodes: List<String>.from(json['episodes'] as List),
      nextOccurrence: json['nextOccurrence'] != null
          ? DateTime.parse(json['nextOccurrence'] as String)
          : null,
      location: json['location'] as String,
      rarity: json['rarity'] as int,
      relatedBodies: List<String>.from(json['relatedBodies'] as List),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}

/// Types of cosmic phenomena
enum PhenomenonType {
  atmospheric, // Atmospheric phenomena (aurora, meteor showers)
  stellar, // Star-related (supernova, nebula formation)
  gravitational, // Gravitational phenomena (black holes, lensing)
  orbital, // Orbital changes (comets, planetary motion)
  eclipse, // Solar or Lunar eclipse
  aurora, // Northern/Southern lights
  supernova, // Star explosion
  meteorShower, // Meteor shower
  comet, // Comet appearance
  transit, // Planetary transit
  conjunction, // Planetary alignment
  blackHole, // Black hole phenomena
  nebula, // Nebula formation
  other,
}

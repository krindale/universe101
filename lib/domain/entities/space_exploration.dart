/// Represents space exploration missions, spacecraft, and timeline events
class SpaceExploration {
  final String id;
  final String name;
  final String description;
  final ExplorationType type;
  final String? spacecraftName;
  final String agency; // NASA, ESA, SpaceX, etc.
  final DateTime launchDate;
  final DateTime? endDate;
  final String? destination;
  final Map<String, String> facts; // Changed from List to Map, renamed from achievements
  final List<String> episodes; // Added episodes field like CosmicPhenomenon
  final String imageUrl;
  final List<String> crewMembers;
  final ExplorationStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SpaceExploration({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.spacecraftName,
    required this.agency,
    required this.launchDate,
    this.endDate,
    this.destination,
    required this.facts,
    required this.episodes,
    required this.imageUrl,
    required this.crewMembers,
    required this.status,
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
      'spacecraftName': spacecraftName,
      'agency': agency,
      'launchDate': launchDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'destination': destination,
      'facts': facts,
      'episodes': episodes,
      'imageUrl': imageUrl,
      'crewMembers': crewMembers,
      'status': status.toString(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Create from JSON from database
  factory SpaceExploration.fromJson(Map<String, dynamic> json) {
    // Handle facts - support both legacy achievements format and new facts format
    Map<String, String> parsedFacts;
    final factsData = json['facts'] ?? json['achievements']; // Support both field names
    if (factsData is List) {
      // Legacy format: List<String> - convert to Map with index as key
      final factsList = List<String>.from(factsData as List);
      parsedFacts = {};
      for (int i = 0; i < factsList.length; i++) {
        parsedFacts['Fact ${i + 1}'] = factsList[i];
      }
    } else if (factsData is Map) {
      // New format: Map<String, String>
      parsedFacts = Map<String, String>.from(factsData as Map);
    } else {
      parsedFacts = {};
    }

    return SpaceExploration(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: ExplorationType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => ExplorationType.other,
      ),
      spacecraftName: json['spacecraftName'] as String?,
      agency: json['agency'] as String,
      launchDate: DateTime.parse(json['launchDate'] as String),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      destination: json['destination'] as String?,
      facts: parsedFacts,
      episodes: List<String>.from(json['episodes'] as List),
      imageUrl: json['imageUrl'] as String,
      crewMembers: List<String>.from(json['crewMembers'] as List),
      status: ExplorationStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => ExplorationStatus.completed,
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

/// Types of space exploration
enum ExplorationType {
  satellite, // Satellite missions
  probe, // Space probes
  rover, // Planetary rovers
  telescope, // Space telescopes
  mannedMission, // Human spaceflight
  unmannedMission, // Robotic/probe missions
  satelliteLaunch, // Satellite deployments
  spaceStation, // Space station programs
  lunarMission, // Moon missions
  marsMission, // Mars missions
  deepSpace, // Deep space exploration
  other,
}

/// Status of exploration mission
enum ExplorationStatus {
  planned,
  active,
  completed,
  failed,
  ongoing,
}

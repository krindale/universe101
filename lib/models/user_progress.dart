/// Represents user progress, favorites, and learning tracking
class UserProgress {
  final String id;
  final String userId;
  final List<String> favoriteCelestialBodies;
  final List<String> favoritePhenomena;
  final List<String> favoriteExplorations;
  final Map<String, bool> completedLearningCards; // cardId: completed
  final int totalCardsViewed;
  final int totalTimeSpentMinutes;
  final DateTime? lastActiveAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProgress({
    required this.id,
    required this.userId,
    required this.favoriteCelestialBodies,
    required this.favoritePhenomena,
    required this.favoriteExplorations,
    required this.completedLearningCards,
    required this.totalCardsViewed,
    required this.totalTimeSpentMinutes,
    this.lastActiveAt,
    this.createdAt,
    this.updatedAt,
  });

  /// Convert to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'favoriteCelestialBodies': favoriteCelestialBodies,
      'favoritePhenomena': favoritePhenomena,
      'favoriteExplorations': favoriteExplorations,
      'completedLearningCards': completedLearningCards,
      'totalCardsViewed': totalCardsViewed,
      'totalTimeSpentMinutes': totalTimeSpentMinutes,
      'lastActiveAt': lastActiveAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Create from JSON from database
  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      id: json['id'] as String,
      userId: json['userId'] as String,
      favoriteCelestialBodies:
          List<String>.from(json['favoriteCelestialBodies'] as List),
      favoritePhenomena: List<String>.from(json['favoritePhenomena'] as List),
      favoriteExplorations:
          List<String>.from(json['favoriteExplorations'] as List),
      completedLearningCards:
          Map<String, bool>.from(json['completedLearningCards'] as Map),
      totalCardsViewed: json['totalCardsViewed'] as int,
      totalTimeSpentMinutes: json['totalTimeSpentMinutes'] as int,
      lastActiveAt: json['lastActiveAt'] != null
          ? DateTime.parse(json['lastActiveAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  /// Add a favorite celestial body
  UserProgress addFavoriteCelestialBody(String bodyId) {
    if (favoriteCelestialBodies.contains(bodyId)) return this;

    return UserProgress(
      id: id,
      userId: userId,
      favoriteCelestialBodies: [...favoriteCelestialBodies, bodyId],
      favoritePhenomena: favoritePhenomena,
      favoriteExplorations: favoriteExplorations,
      completedLearningCards: completedLearningCards,
      totalCardsViewed: totalCardsViewed,
      totalTimeSpentMinutes: totalTimeSpentMinutes,
      lastActiveAt: DateTime.now(),
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// Remove a favorite celestial body
  UserProgress removeFavoriteCelestialBody(String bodyId) {
    return UserProgress(
      id: id,
      userId: userId,
      favoriteCelestialBodies: favoriteCelestialBodies
          .where((id) => id != bodyId)
          .toList(),
      favoritePhenomena: favoritePhenomena,
      favoriteExplorations: favoriteExplorations,
      completedLearningCards: completedLearningCards,
      totalCardsViewed: totalCardsViewed,
      totalTimeSpentMinutes: totalTimeSpentMinutes,
      lastActiveAt: DateTime.now(),
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// Mark a learning card as completed
  UserProgress completeCard(String cardId) {
    final updatedCards = Map<String, bool>.from(completedLearningCards);
    updatedCards[cardId] = true;

    return UserProgress(
      id: id,
      userId: userId,
      favoriteCelestialBodies: favoriteCelestialBodies,
      favoritePhenomena: favoritePhenomena,
      favoriteExplorations: favoriteExplorations,
      completedLearningCards: updatedCards,
      totalCardsViewed: totalCardsViewed + 1,
      totalTimeSpentMinutes: totalTimeSpentMinutes,
      lastActiveAt: DateTime.now(),
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// Get completion percentage
  double get completionPercentage {
    if (completedLearningCards.isEmpty) return 0.0;
    final completed =
        completedLearningCards.values.where((v) => v == true).length;
    return (completed / completedLearningCards.length) * 100;
  }
}

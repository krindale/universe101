/// Represents user progress, favorites, and learning tracking
class UserProgress {
  final String id;
  final String userId;
  final List<String> favoriteCelestialBodies;
  final List<String> favoritePhenomena;
  final List<String> favoriteExplorations;
  final Map<String, bool> completedLearningCards; // cardId: completed
  final Map<String, bool> reviewLaterCards; // cardId: marked for review
  final List<String> hiddenCards; // cardId: hidden/archived cards
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
    this.reviewLaterCards = const {},
    this.hiddenCards = const [],
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
      'reviewLaterCards': reviewLaterCards,
      'hiddenCards': hiddenCards,
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
      reviewLaterCards: json['reviewLaterCards'] != null
          ? Map<String, bool>.from(json['reviewLaterCards'] as Map)
          : {},
      hiddenCards: json['hiddenCards'] != null
          ? List<String>.from(json['hiddenCards'] as List)
          : [],
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

  /// Mark a card for review later
  UserProgress markForReviewLater(String cardId) {
    final updatedReviewCards = Map<String, bool>.from(reviewLaterCards);
    updatedReviewCards[cardId] = true;

    return UserProgress(
      id: id,
      userId: userId,
      favoriteCelestialBodies: favoriteCelestialBodies,
      favoritePhenomena: favoritePhenomena,
      favoriteExplorations: favoriteExplorations,
      completedLearningCards: completedLearningCards,
      reviewLaterCards: updatedReviewCards,
      hiddenCards: hiddenCards,
      totalCardsViewed: totalCardsViewed,
      totalTimeSpentMinutes: totalTimeSpentMinutes,
      lastActiveAt: DateTime.now(),
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// Unmark a card from review later
  UserProgress unmarkForReviewLater(String cardId) {
    final updatedReviewCards = Map<String, bool>.from(reviewLaterCards);
    updatedReviewCards.remove(cardId);

    return UserProgress(
      id: id,
      userId: userId,
      favoriteCelestialBodies: favoriteCelestialBodies,
      favoritePhenomena: favoritePhenomena,
      favoriteExplorations: favoriteExplorations,
      completedLearningCards: completedLearningCards,
      reviewLaterCards: updatedReviewCards,
      hiddenCards: hiddenCards,
      totalCardsViewed: totalCardsViewed,
      totalTimeSpentMinutes: totalTimeSpentMinutes,
      lastActiveAt: DateTime.now(),
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// Hide a card (archive it)
  UserProgress hideCard(String cardId) {
    if (hiddenCards.contains(cardId)) return this;

    return UserProgress(
      id: id,
      userId: userId,
      favoriteCelestialBodies: favoriteCelestialBodies,
      favoritePhenomena: favoritePhenomena,
      favoriteExplorations: favoriteExplorations,
      completedLearningCards: completedLearningCards,
      reviewLaterCards: reviewLaterCards,
      hiddenCards: [...hiddenCards, cardId],
      totalCardsViewed: totalCardsViewed,
      totalTimeSpentMinutes: totalTimeSpentMinutes,
      lastActiveAt: DateTime.now(),
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// Unhide a card (restore from archive)
  UserProgress unhideCard(String cardId) {
    return UserProgress(
      id: id,
      userId: userId,
      favoriteCelestialBodies: favoriteCelestialBodies,
      favoritePhenomena: favoritePhenomena,
      favoriteExplorations: favoriteExplorations,
      completedLearningCards: completedLearningCards,
      reviewLaterCards: reviewLaterCards,
      hiddenCards: hiddenCards.where((id) => id != cardId).toList(),
      totalCardsViewed: totalCardsViewed,
      totalTimeSpentMinutes: totalTimeSpentMinutes,
      lastActiveAt: DateTime.now(),
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// Reset progress for a specific card
  UserProgress resetCardProgress(String cardId) {
    final updatedCompletedCards = Map<String, bool>.from(completedLearningCards);
    updatedCompletedCards.remove(cardId);

    final updatedReviewCards = Map<String, bool>.from(reviewLaterCards);
    updatedReviewCards.remove(cardId);

    return UserProgress(
      id: id,
      userId: userId,
      favoriteCelestialBodies: favoriteCelestialBodies,
      favoritePhenomena: favoritePhenomena,
      favoriteExplorations: favoriteExplorations,
      completedLearningCards: updatedCompletedCards,
      reviewLaterCards: updatedReviewCards,
      hiddenCards: hiddenCards,
      totalCardsViewed: totalCardsViewed > 0 ? totalCardsViewed - 1 : 0,
      totalTimeSpentMinutes: totalTimeSpentMinutes,
      lastActiveAt: DateTime.now(),
      createdAt: createdAt,
      updatedAt: DateTime.now(),
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
      reviewLaterCards: reviewLaterCards,
      hiddenCards: hiddenCards,
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
      reviewLaterCards: reviewLaterCards,
      hiddenCards: hiddenCards,
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
      reviewLaterCards: reviewLaterCards,
      hiddenCards: hiddenCards,
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

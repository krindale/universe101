/// User preferences for app settings
class UserPreferences {
  final String userId;
  final bool isDarkMode;
  final bool notificationsEnabled;
  final String language; // 'ko', 'en'
  final String contentDifficulty; // 'easy', 'medium', 'hard', 'all'
  final List<String> favoriteTopics; // ['planets', 'phenomena', 'exploration']
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserPreferences({
    required this.userId,
    this.isDarkMode = true,
    this.notificationsEnabled = true,
    this.language = 'ko',
    this.contentDifficulty = 'all',
    this.favoriteTopics = const [],
    this.createdAt,
    this.updatedAt,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'isDarkMode': isDarkMode,
      'notificationsEnabled': notificationsEnabled,
      'language': language,
      'contentDifficulty': contentDifficulty,
      'favoriteTopics': favoriteTopics,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Create from JSON
  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      userId: json['userId'] as String,
      isDarkMode: json['isDarkMode'] as bool? ?? true,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      language: json['language'] as String? ?? 'ko',
      contentDifficulty: json['contentDifficulty'] as String? ?? 'all',
      favoriteTopics: json['favoriteTopics'] != null
          ? List<String>.from(json['favoriteTopics'] as List)
          : [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  /// Create a copy with updated values
  UserPreferences copyWith({
    String? userId,
    bool? isDarkMode,
    bool? notificationsEnabled,
    String? language,
    String? contentDifficulty,
    List<String>? favoriteTopics,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserPreferences(
      userId: userId ?? this.userId,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      contentDifficulty: contentDifficulty ?? this.contentDifficulty,
      favoriteTopics: favoriteTopics ?? this.favoriteTopics,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// Check if user has a specific favorite topic
  bool hasFavoriteTopic(String topic) {
    return favoriteTopics.contains(topic);
  }

  /// Add a favorite topic
  UserPreferences addFavoriteTopic(String topic) {
    if (favoriteTopics.contains(topic)) return this;
    return copyWith(
      favoriteTopics: [...favoriteTopics, topic],
      updatedAt: DateTime.now(),
    );
  }

  /// Remove a favorite topic
  UserPreferences removeFavoriteTopic(String topic) {
    return copyWith(
      favoriteTopics: favoriteTopics.where((t) => t != topic).toList(),
      updatedAt: DateTime.now(),
    );
  }
}

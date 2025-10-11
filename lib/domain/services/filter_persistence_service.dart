import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/learning_card_filter.dart';

/// Service for persisting learning card filter preferences
class FilterPersistenceService {
  static const String _filterKey = 'learning_card_filter';

  /// Save current filter to persistent storage
  Future<void> saveFilter(LearningCardFilter filter) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(filter.toJson());
      await prefs.setString(_filterKey, jsonString);
    } catch (e) {
      // Silently fail - filter persistence is not critical
      // In production, this could be logged
    }
  }

  /// Load saved filter from persistent storage
  Future<LearningCardFilter> loadFilter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_filterKey);

      if (jsonString == null) {
        return LearningCardFilter.empty();
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return LearningCardFilter.fromJson(json);
    } catch (e) {
      // If loading fails, return empty filter
      return LearningCardFilter.empty();
    }
  }

  /// Clear saved filter from persistent storage
  Future<void> clearFilter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_filterKey);
    } catch (e) {
      // Silently fail
    }
  }

  /// Check if a saved filter exists
  Future<bool> hasFilter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_filterKey);
    } catch (e) {
      return false;
    }
  }
}

/// Number formatting utility for planet metrics
/// Formats large numbers with K suffix for better readability
class NumberFormatter {
  /// Formats a number with K suffix if >= 1000
  /// Examples:
  /// - 4879 -> "4.9K"
  /// - 500 -> "500"
  /// - 12742 -> "12.7K"
  static String format(double number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }

  /// Formats a number without suffix (for precise values)
  static String formatPrecise(double number, {int decimals = 2}) {
    return number.toStringAsFixed(decimals);
  }
}

extension StringExtensions on String {
  String get camelCaseToNormal {
    return this.replaceAllMapped(
        RegExp(r'(?<=[a-z])[A-Z]'), (match) => ' ${match.group(0)}');
  }

  String get capitalizeFirst => '${this[0].toUpperCase()}${substring(1)}';
}

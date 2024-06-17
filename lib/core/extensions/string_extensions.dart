import 'package:intl/intl.dart';

extension StringExtensions on String {
  String get camelCaseToNormal {
    return this.replaceAllMapped(
        RegExp(r'(?<=[a-z])[A-Z]'), (match) => ' ${match.group(0)}');
  }

  String get capitalizeFirst => '${this[0].toUpperCase()}${substring(1)}';

  String get toPriceFormat {
    final numberFormat = NumberFormat("#,##0.00", "en_US");
    return '\$${numberFormat.format(double.parse(this))}';
  }
}

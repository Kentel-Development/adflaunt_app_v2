extension DateParserExtension on String {
  DateTime parseDate() {
    return DateTime(
      int.parse(substring(6, 10)),
      int.parse(substring(3, 5)),
      int.parse(substring(0, 2)),
    );
  }
}

extension DateParserExtension on String {
  DateTime parseDate() {
    return DateTime(
      int.parse(substring(6, 10)),
      int.parse(substring(3, 5)),
      int.parse(substring(0, 2)),
    );
  }

  DateTime parseBookingDate() {
    return DateTime(
      int.parse(substring(0, 4)),
      int.parse(substring(5, 7)),
      int.parse(substring(8, 10)),
    );
  }
}

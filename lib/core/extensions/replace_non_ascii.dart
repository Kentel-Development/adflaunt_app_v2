extension ReplaceNonAscii on String {
  String replaceNonAscii() {
    final Map<String, String> asciiEquivalents = {
      'ı': 'i',
      'İ': 'I',
      'ş': 's',
      'Ş': 'S',
      'ğ': 'g',
      'Ğ': 'G',
      'ü': 'u',
      'Ü': 'U',
      'ö': 'o',
      'Ö': 'O',
      'ç': 'c',
      'Ç': 'C',
    };
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      String char = this[i];
      if (asciiEquivalents.containsKey(char)) {
        buffer.write(asciiEquivalents[char]);
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }
}

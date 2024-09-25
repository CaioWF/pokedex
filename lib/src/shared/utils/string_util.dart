class StringUtil {
  static String capitalizeFirst(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  static String removeByRegex(String input, String pattern) {
    final regex = RegExp(pattern);
    return input.replaceAll(regex, '');
  }
}
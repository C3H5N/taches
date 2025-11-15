class Validators {
  static String? notEmpty(String? value, {String field = 'Ce champ'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field est requis';
    }
    return null;
  }
}

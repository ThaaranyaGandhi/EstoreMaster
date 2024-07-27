extension StringMethods on String{

  String addSpacesBeforeCapitalLetters() {
    return replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
  }

}
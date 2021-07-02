class LanguageData {
  static List<LanguageDataModel> getLanguageList() {
    List<LanguageDataModel> languageList = [
      LanguageDataModel(name: "English", initial: "EN"),
      LanguageDataModel(name: "Hindi", initial: "HN"),
      LanguageDataModel(name: "German", initial: "GR"),
      LanguageDataModel(name: "Italian", initial: "IT"),
      LanguageDataModel(name: "Tamil", initial: "TL"),
      LanguageDataModel(name: "China", initial: "CH"),
      LanguageDataModel(name: "Japanese", initial: "JPN"),
      LanguageDataModel(name: "Russian", initial: "RSA"),
      LanguageDataModel(name: "Bengali", initial: "BN"),
    ];

    return languageList;
  }
}

class LanguageDataModel {
  late String name;
  late String initial;
  late bool checked = false;

  LanguageDataModel({
    required this.name,
    required this.initial,
  });
}

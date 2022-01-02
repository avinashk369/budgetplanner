import 'package:flutter/material.dart';

class LanguageData {
  static List<LanguageDataModel> getLanguageList() {
    List<LanguageDataModel> languageList = [
      LanguageDataModel(
          name: "English",
          initial: "US",
          code: 'en',
          locale: Locale('en', 'US')),
      LanguageDataModel(
        name: "Hindi",
        initial: "IN",
        code: 'hi',
        locale: Locale('hi', 'IN'),
      ),
      LanguageDataModel(
          name: "Spanish",
          initial: "ES",
          code: 'es',
          locale: Locale('es', 'ES')),
      LanguageDataModel(
          name: "German",
          initial: "DE",
          code: 'de',
          locale: Locale('de', 'DE')),
      LanguageDataModel(
          name: "Italian",
          initial: "IT",
          code: 'it',
          locale: Locale('it', 'IT')),
      LanguageDataModel(
        name: "China",
        initial: "CN",
        code: 'zh',
        locale: Locale('zh', 'CN'),
      ),
      LanguageDataModel(
          name: "Japanese",
          initial: "JP",
          code: 'ja',
          locale: Locale('ja', 'JP')),
      LanguageDataModel(
          name: "Russian",
          initial: "RU",
          code: 'ru',
          locale: Locale('ru', 'RU')),
      LanguageDataModel(
        name: "Bengali",
        initial: "IN",
        code: 'bn',
        locale: Locale('bn', 'IN'),
      ),
      LanguageDataModel(
        name: "Tamil",
        initial: "Tamil",
        code: 'ta',
        locale: Locale('ta', 'Tamil'),
      ),
    ];

    return languageList;
  }
}

class LanguageDataModel {
  late String name;
  late String initial;
  late String code;
  late Locale locale;
  late bool checked = false;

  LanguageDataModel(
      {required this.name,
      required this.initial,
      required this.code,
      required this.locale});
}

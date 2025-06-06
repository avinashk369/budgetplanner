import 'package:get/get.dart';

import 'en.dart';
import 'es.dart';
import 'ja.dart';
import 'pt.dart';
import 'hi.dart';
import 'ta.dart';
import 'it.dart';
import 'de.dart';
import 'ru.dart';
import 'zh.dart';
import 'bn.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en': en,
      'pt': pt,
      'es': es,
      'hi': hi,
      'ta': ta,
      'de': de,
      'it': it,
      'ru': ru,
      'ja': ja,
      'zh': zh,
      'bn': bn
    };
  }
}

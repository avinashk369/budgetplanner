import 'package:get/get.dart';

import 'en.dart';
import 'es.dart';
import 'pt.dart';
import 'hi.dart';
import 'ta.dart';
import 'de.dart';

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
    };
  }
}

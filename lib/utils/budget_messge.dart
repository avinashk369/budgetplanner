import 'package:budgetplanner/utils/string_constants.dart';

class BudgetMessage {
  static Map<String, String> getBudgetMessage(double val) {
    int value = val.toInt();
    Map<String, String> message = _getMessage("Normal");

    if (value < 1) {
      message = _getMessage("Normal");
    }
    if (value > 3000 && value < 4000) {
      message = _getMessage("Standard");
    }
    if (value > 4000) {
      message = _getMessage("Hyper");
    }
    return message;
  }

  static Map<String, Map<String, String>> _messageKeys = {
    'Normal': {'Normal': normalBudget},
    'Standard': {'Standard': standardBudget},
    'Hyper': {'Hyper': hyperBudget},
  };

  static Map<String, String> _getMessage(String key) {
    return _messageKeys[key]!;
  }
}

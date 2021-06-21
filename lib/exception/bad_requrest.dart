import 'package:budgetplanner/exception/Appexceptions.dart';

class BadRequestException extends AppException {
  BadRequestException(String message, String url)
      : super(message, url, 'Bad request');
}

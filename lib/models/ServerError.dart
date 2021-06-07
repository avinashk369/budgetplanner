import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  late int _errorCode;
  String _errorMessage = "";

  ServerError.withError({required Object error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(Object error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          _errorMessage = "Request was cancelled";
          break;
        case DioErrorType.connectTimeout:
          _errorMessage = "Connection timeout";
          break;
        case DioErrorType.other:
          _errorMessage = "Unexpected value returned from API";
          break;
        case DioErrorType.receiveTimeout:
          _errorMessage = "Receive timeout in connection";
          break;
        case DioErrorType.response:
          final body = json.decode(error.response.toString());
          _errorMessage = body['error'] ?? body['message'];
          //"Received invalid status code: ${error.response.statusCode} ${body['error_description']}";
          break;
        case DioErrorType.sendTimeout:
          _errorMessage = "Receive timeout in send request";
          break;
        case DioErrorType.connectTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.sendTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.receiveTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.response:
          // TODO: Handle this case.
          break;
        case DioErrorType.cancel:
          // TODO: Handle this case.
          break;
        case DioErrorType.other:
          // TODO: Handle this case.
          break;
      }
      return _errorMessage;
    }
  }
}

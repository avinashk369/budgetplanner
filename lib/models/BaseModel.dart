import 'ServerError.dart';

class BaseModel<T> {
  ServerError? _error;
  T? data;
  String? errorMessage;

  setErrorMessage(String message) {
    errorMessage = message;
  }

  get getErrorMessage {
    return errorMessage;
  }

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data!;
  }

  get getException {
    return _error;
  }
}

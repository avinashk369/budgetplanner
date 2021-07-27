class BaseModel<T> {
  T? data;
  String? errorMessage;

  setErrorMessage(String message) {
    errorMessage = message;
  }

  get getErrorMessage {
    return errorMessage;
  }

  setData(T data) {
    this.data = data!;
  }
}

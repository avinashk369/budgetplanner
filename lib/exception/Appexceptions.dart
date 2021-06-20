class AppException implements Exception {
  final String message;
  final String url;
  final String prefix;

  AppException(this.message, this.url, this.prefix);
}

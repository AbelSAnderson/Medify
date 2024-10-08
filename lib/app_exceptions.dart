
/// App Exceptions
class AppException implements Exception {
  final message;
  final _prefix;

  AppException([this.message, this._prefix]);

  String toString() {
    return "$_prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

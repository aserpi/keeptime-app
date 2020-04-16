/// General network error.
abstract class NetworkException implements Exception {}

/// Indicates there is no internet connection.
class NoInternetException extends NetworkException {}

/// Indicates the server is not complying with the protocol.
class NoServerException extends NetworkException {}

/// Indicates the user is not authorized to perform an action.
///
/// Usually, the error is caused by invalid credentials.
class UnauthorizedException extends NetworkException {}

/// Indicates an unknown network error.
class UnknownNetworkException extends NetworkException {}

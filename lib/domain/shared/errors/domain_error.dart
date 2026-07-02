abstract class DomainError implements Exception {
  final String message;
  DomainError(this.message);

  String get code;

  @override
  String toString() => '$runtimeType($code): $message';
}
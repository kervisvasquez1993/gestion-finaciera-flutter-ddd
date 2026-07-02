
import 'package:gestao_financeira/domain/shared/errors/domain_error.dart';

class InvalidCredentialsError extends DomainError {
  InvalidCredentialsError() : super('Credenciais inválidas');
  @override
  String get code => 'INVALID_CREDENTIALS';
}

class EmailAlreadyExistsError extends DomainError {
  EmailAlreadyExistsError(super.message);
  @override
  String get code => 'EMAIL_ALREADY_EXISTS';
}

class InvalidEmailError extends DomainError {
  InvalidEmailError(super.message);
  @override
  String get code => 'INVALID_EMAIL';
}

class InvalidPasswordError extends DomainError {
  InvalidPasswordError(super.message);
  @override
  String get code => 'INVALID_PASSWORD';
}

class InvalidNameError extends DomainError {
  InvalidNameError(super.message);
  @override
  String get code => 'INVALID_NAME';
}

class SessionExpiredError extends DomainError {
  SessionExpiredError() : super('Sessão expirada');
  @override
  String get code => 'SESSION_EXPIRED';
}
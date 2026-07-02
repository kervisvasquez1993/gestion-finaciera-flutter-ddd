
import 'package:gestao_financeira/domain/shared/errors/auth_errors.dart';

class Email {
  final String value;
  const Email._(this.value);

  static final _regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  factory Email.create(String input) {
    final trimmed = input.trim().toLowerCase();
    if (!_regex.hasMatch(trimmed)) {
      throw InvalidEmailError('Email inválido: $input');
    }
    return Email._(trimmed);
  }

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Email && other.value == value);

  @override
  int get hashCode => value.hashCode;
}
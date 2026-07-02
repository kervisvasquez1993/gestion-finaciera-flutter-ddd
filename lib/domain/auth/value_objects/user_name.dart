
import 'package:gestao_financeira/domain/shared/errors/auth_errors.dart';

class UserName {
  final String value;
  const UserName._(this.value);

  factory UserName.create(String input) {
    final trimmed = input.trim();
    if (trimmed.length < 2) {
      throw InvalidNameError('O nome deve ter ao menos 2 caracteres');
    }
    if (trimmed.length > 150) {
      throw InvalidNameError('O nome não pode superar 150 caracteres');
    }
    return UserName._(trimmed);
  }

  @override
  String toString() => value;
}

import 'package:gestao_financeira/domain/shared/errors/auth_errors.dart';

class Password {
  final String value;
  const Password._(this.value);

  factory Password.create(String input) {
    if (input.length < 6) {
      throw InvalidPasswordError('A senha deve ter ao menos 6 caracteres');
    }
    return Password._(input);
  }

  @override
  String toString() => '******'; // nunca expõe o valor real em toString
}
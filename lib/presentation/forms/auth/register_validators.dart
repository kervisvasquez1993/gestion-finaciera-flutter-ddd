import 'package:gestao_financeira/presentation/forms/auth/login_validators.dart';

class RegisterValidators {
  RegisterValidators._();

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return 'O nome é obrigatório';
    if (value.trim().length < 2) return 'O nome deve ter ao menos 2 caracteres';
    return null;
  }

  static String? email(String? value) => LoginValidators.email(value);

  static String? password(String? value) => LoginValidators.password(value);
}
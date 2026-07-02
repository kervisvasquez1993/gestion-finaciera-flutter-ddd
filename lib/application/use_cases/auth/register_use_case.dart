

import 'package:gestao_financeira/domain/auth/dto/register_dto.dart';
import 'package:gestao_financeira/domain/auth/entities/user_entity.dart';
import 'package:gestao_financeira/domain/auth/repositories/auth_repository.dart';
import 'package:gestao_financeira/domain/auth/value_objects/email.dart';
import 'package:gestao_financeira/domain/auth/value_objects/password.dart';
import 'package:gestao_financeira/domain/auth/value_objects/user_name.dart';

class RegisterUseCase {
  final IAuthRepository _repository;
  RegisterUseCase(this._repository);

  Future<UserEntity> call(RegisterRequest data) async {
    // valida invariantes construindo os VOs antes de chamar o repo
    UserName.create(data.name);
    Email.create(data.email);
    Password.create(data.password);

    return _repository.register(data);
  }
}
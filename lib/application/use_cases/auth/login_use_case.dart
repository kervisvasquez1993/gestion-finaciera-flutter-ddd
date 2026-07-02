

import 'package:gestao_financeira/domain/auth/dto/login_dto.dart';
import 'package:gestao_financeira/domain/auth/entities/session_entity.dart';
import 'package:gestao_financeira/domain/auth/repositories/auth_repository.dart';
import 'package:gestao_financeira/domain/auth/value_objects/email.dart';
import 'package:gestao_financeira/domain/auth/value_objects/password.dart';
import 'package:gestao_financeira/infrastructure/api/auth_token_storage.dart';

class LoginUseCase {
  final IAuthRepository _repository;
  LoginUseCase(this._repository);

  Future<SessionEntity> call(LoginRequest data) async {
    Email.create(data.email);
    Password.create(data.password);

    final session = await _repository.login(data);
    AuthTokenStorage.instance.setToken(session.accessToken);
    return session;
  }
}
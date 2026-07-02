

import 'package:gestao_financeira/domain/auth/dto/login_dto.dart';
import 'package:gestao_financeira/domain/auth/dto/register_dto.dart';
import 'package:gestao_financeira/domain/auth/entities/session_entity.dart';
import 'package:gestao_financeira/domain/auth/entities/user_entity.dart';

abstract class IAuthRepository {
  Future<UserEntity> register(RegisterRequest data);
  Future<SessionEntity> login(LoginRequest data);
  Future<UserEntity> me();
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gestao_financeira/domain/auth/dto/login_dto.dart';
import 'package:gestao_financeira/domain/auth/dto/register_dto.dart';
import 'package:gestao_financeira/domain/auth/entities/session_entity.dart';
import 'package:gestao_financeira/domain/auth/entities/user_entity.dart';
import 'package:gestao_financeira/domain/auth/repositories/auth_repository.dart';
import 'package:gestao_financeira/domain/shared/errors/auth_errors.dart';
import 'package:gestao_financeira/infrastructure/actions/auth/register_action.dart';
import 'package:gestao_financeira/infrastructure/api/normalize_http_error.dart';
import 'package:gestao_financeira/infrastructure/mappers/auth/auth_mapper.dart';
import 'package:gestao_financeira/infrastructure/mappers/auth/login_action.dart';
import 'package:gestao_financeira/infrastructure/mappers/auth/me_action.dart';

class AuthRepositoryImpl implements IAuthRepository {
  @override
  @override
Future<UserEntity> register(RegisterRequest data) async {
  try {
    final model = await registerAction(data);
    return AuthMapper.toUserEntity(model);
  } on DioException catch (e) {
    debugPrint('❌ DioException: ${e.message}');
    debugPrint('❌ Response: ${e.response?.data}');
    debugPrint('❌ Status: ${e.response?.statusCode}');
    debugPrint('❌ URL: ${e.requestOptions.uri}');

    final err = normalizeHttpError(e);
    if (err.statusCode == 409) {
      throw EmailAlreadyExistsError(err.messages.join(', '));
    }
    rethrow;
  }
}

  @override
  Future<SessionEntity> login(LoginRequest data) async {
    try {
      final model = await loginAction(data);
      return AuthMapper.toSessionEntity(model);
    } on DioException catch (e) {
      final err = normalizeHttpError(e);
      if (err.statusCode == 401) {
        throw InvalidCredentialsError();
      }
      rethrow;
    }
  }

  @override
  Future<UserEntity> me() async {
    try {
      final model = await meAction();
      return AuthMapper.toUserEntity(model);
    } on DioException catch (e) {
      final err = normalizeHttpError(e);
      if (err.statusCode == 401) {
        throw SessionExpiredError();
      }
      rethrow;
    }
  }
}
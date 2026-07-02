
import 'package:gestao_financeira/domain/auth/entities/session_entity.dart';
import 'package:gestao_financeira/domain/auth/entities/user_entity.dart';
import 'package:gestao_financeira/domain/auth/value_objects/email.dart';
import 'package:gestao_financeira/domain/auth/value_objects/user_name.dart';
import 'package:gestao_financeira/infrastructure/models/auth/session_model.dart';
import 'package:gestao_financeira/infrastructure/models/auth/user_model.dart';

class AuthMapper {
  static UserEntity toUserEntity(UserModel model) => UserEntity(
        id: model.id,
        name: UserName.create(model.name),
        email: Email.create(model.email),
        createdAt: model.createdAt != null ? DateTime.parse(model.createdAt!) : null,
      );

  static SessionEntity toSessionEntity(SessionModel model) => SessionEntity(
        accessToken: model.accessToken,
        user: toUserEntity(model.user),
      );
}
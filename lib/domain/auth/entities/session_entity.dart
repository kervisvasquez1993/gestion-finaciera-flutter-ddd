
import 'package:gestao_financeira/domain/auth/entities/user_entity.dart';

class SessionEntity {
  final String accessToken;
  final UserEntity user;

  const SessionEntity({required this.accessToken, required this.user});
}
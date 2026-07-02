
import 'package:gestao_financeira/domain/auth/value_objects/email.dart';
import 'package:gestao_financeira/domain/auth/value_objects/user_name.dart';

class UserEntity {
  final String id;
  final UserName name;
  final Email email;
  final DateTime? createdAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });
}
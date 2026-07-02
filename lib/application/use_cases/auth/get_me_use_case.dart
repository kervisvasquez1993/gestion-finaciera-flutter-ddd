
import 'package:gestao_financeira/domain/auth/entities/user_entity.dart';
import 'package:gestao_financeira/domain/auth/repositories/auth_repository.dart';

class GetMeUseCase {
  final IAuthRepository _repository;
  GetMeUseCase(this._repository);

  Future<UserEntity> call() => _repository.me();
}
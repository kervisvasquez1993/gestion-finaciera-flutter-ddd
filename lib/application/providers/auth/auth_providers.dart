
import 'package:gestao_financeira/application/use_cases/auth/get_me_use_case.dart';
import 'package:gestao_financeira/application/use_cases/auth/login_use_case.dart';
import 'package:gestao_financeira/application/use_cases/auth/logout_use_case.dart';
import 'package:gestao_financeira/application/use_cases/auth/register_use_case.dart';
import 'package:gestao_financeira/domain/auth/repositories/auth_repository.dart';
import 'package:gestao_financeira/infrastructure/repositories/auth/auth_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.watch(authRepositoryProvider));
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final getMeUseCaseProvider = Provider<GetMeUseCase>((ref) {
  return GetMeUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase();
});
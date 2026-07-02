
import 'package:gestao_financeira/application/providers/auth/auth_providers.dart';
import 'package:gestao_financeira/domain/auth/dto/login_dto.dart';
import 'package:gestao_financeira/domain/auth/entities/user_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SessionNotifier extends AsyncNotifier<UserEntity?> {
  @override
  Future<UserEntity?> build() async => null; // sem sessão ao iniciar

  Future<void> login(LoginRequest data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = await ref.read(loginUseCaseProvider).call(data);
      return session.user;
    });
  }

  void logout() {
    ref.read(logoutUseCaseProvider).call();
    state = const AsyncData(null);
  }
}

final sessionNotifierProvider =
    AsyncNotifierProvider<SessionNotifier, UserEntity?>(SessionNotifier.new);
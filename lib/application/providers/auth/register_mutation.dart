
import 'package:gestao_financeira/application/providers/auth/auth_providers.dart';
import 'package:gestao_financeira/domain/auth/dto/register_dto.dart';
import 'package:gestao_financeira/domain/auth/entities/user_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterMutation extends AsyncNotifier<UserEntity?> {
  @override
  Future<UserEntity?> build() async => null;

  Future<void> submit(RegisterRequest data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(registerUseCaseProvider).call(data),
    );
  }
}

final registerMutationProvider =
    AsyncNotifierProvider<RegisterMutation, UserEntity?>(RegisterMutation.new);
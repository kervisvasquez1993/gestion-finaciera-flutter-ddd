import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gestao_financeira/application/providers/auth/register_mutation.dart';
import 'package:gestao_financeira/domain/auth/dto/register_dto.dart';
import 'package:gestao_financeira/domain/shared/errors/auth_errors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UseRegisterFormResult {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onSubmit;

  const UseRegisterFormResult({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.errorMessage,
    required this.onSubmit,
  });
}

UseRegisterFormResult useRegisterForm(WidgetRef ref, {required VoidCallback onSuccess}) {
  final nameController = useTextEditingController();
  final emailController = useTextEditingController();
  final passwordController = useTextEditingController();
  final formKey = useMemoized(() => GlobalKey<FormState>());
  final errorMessage = useState<String?>(null);

  final mutationState = ref.watch(registerMutationProvider);
  final isLoading = mutationState.isLoading;

  useEffect(() {
    mutationState.whenOrNull(
      data: (user) {
        if (user != null) onSuccess();
      },
      error: (err, _) {
        if (err is EmailAlreadyExistsError) {
          errorMessage.value = err.message;
        } else {
          errorMessage.value = 'Erro ao criar conta. Tente novamente.';
        }
      },
    );
    return null;
  }, [mutationState]);

  void handleSubmit() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    errorMessage.value = null;

    ref.read(registerMutationProvider.notifier).submit(
          RegisterRequest(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }

  return UseRegisterFormResult(
    nameController: nameController,
    emailController: emailController,
    passwordController: passwordController,
    formKey: formKey,
    isLoading: isLoading,
    errorMessage: errorMessage.value,
    onSubmit: handleSubmit,
  );
}
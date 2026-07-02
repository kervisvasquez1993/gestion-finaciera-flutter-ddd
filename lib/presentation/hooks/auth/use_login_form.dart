import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gestao_financeira/application/providers/auth/session_notifier.dart';
import 'package:gestao_financeira/domain/auth/dto/login_dto.dart';
import 'package:gestao_financeira/domain/shared/errors/auth_errors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UseLoginFormResult {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final bool obscurePassword;
  final String? errorMessage;
  final VoidCallback onSubmit;
  final VoidCallback togglePasswordVisibility;

  const UseLoginFormResult({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.obscurePassword,
    required this.errorMessage,
    required this.onSubmit,
    required this.togglePasswordVisibility,
  });
}

UseLoginFormResult useLoginForm(WidgetRef ref, {required VoidCallback onSuccess}) {
  final emailController = useTextEditingController();
  final passwordController = useTextEditingController();
  final formKey = useMemoized(() => GlobalKey<FormState>());
  final errorMessage = useState<String?>(null);
  final obscurePassword = useState(true);

  final sessionState = ref.watch(sessionNotifierProvider);
  final isLoading = sessionState.isLoading;

  useEffect(() {
    sessionState.whenOrNull(
      data: (user) {
        if (user != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) => onSuccess());
        }
      },
      error: (err, _) {
        if (err is InvalidCredentialsError) {
          errorMessage.value = err.message;
        } else {
          errorMessage.value = 'Erro ao entrar. Tente novamente.';
        }
      },
    );
    return null;
  }, [sessionState]);

  void handleSubmit() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    errorMessage.value = null;

    ref.read(sessionNotifierProvider.notifier).login(
          LoginRequest(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }

  return UseLoginFormResult(
    emailController: emailController,
    passwordController: passwordController,
    formKey: formKey,
    isLoading: isLoading,
    obscurePassword: obscurePassword.value,
    errorMessage: errorMessage.value,
    onSubmit: handleSubmit,
    togglePasswordVisibility: () => obscurePassword.value = !obscurePassword.value,
  );
}
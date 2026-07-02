import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gestao_financeira/presentation/forms/auth/login_validators.dart';
import 'package:gestao_financeira/presentation/hooks/auth/use_login_form.dart';
import 'package:gestao_financeira/presentation/hooks/auth/use_register_form.dart';
import 'package:gestao_financeira/presentation/forms/auth/register_validators.dart';
import 'package:gestao_financeira/presentation/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = useLoginForm(ref, onSuccess: () => context.go('/'));

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: form.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Bem-vindo de volta', style: AppTextStyles.heading1),
              const Text('Entre na sua conta', style: AppTextStyles.caption)
                  .padding(top: AppSpacing.xs),

              TextFormField(
                controller: form.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: LoginValidators.email,
                decoration: const InputDecoration(labelText: 'Email'),
              ).padding(top: AppSpacing.lg),

              TextFormField(
                controller: form.passwordController,
                obscureText: true,
                validator: LoginValidators.password,
                decoration: const InputDecoration(labelText: 'Senha'),
              ).padding(top: AppSpacing.md),

              if (form.errorMessage != null)
                Text(form.errorMessage!, style: const TextStyle(color: AppColors.danger))
                    .padding(top: AppSpacing.sm),

              ElevatedButton(
                onPressed: form.isLoading ? null : form.onSubmit,
                child: form.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Entrar'),
              ).padding(top: AppSpacing.lg),

              TextButton(
                onPressed: () => context.go('/register'),
                child: const Text('Não tem conta? Cadastre-se'),
              ).padding(top: AppSpacing.sm),
            ],
          ),
        ).padding(all: AppSpacing.lg),
      ),
    );
  }
}
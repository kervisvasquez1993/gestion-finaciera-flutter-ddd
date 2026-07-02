import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gestao_financeira/presentation/hooks/auth/use_register_form.dart';
import 'package:gestao_financeira/presentation/forms/auth/register_validators.dart';
import 'package:gestao_financeira/presentation/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = useRegisterForm(ref, onSuccess: () => context.go('/login'));

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: form.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Criar conta', style: AppTextStyles.heading1),
              const Text('Preencha os dados abaixo', style: AppTextStyles.caption)
                  .padding(top: AppSpacing.xs),

              TextFormField(
                controller: form.nameController,
                validator: RegisterValidators.name,
                decoration: const InputDecoration(labelText: 'Nome'),
              ).padding(top: AppSpacing.lg),

              TextFormField(
                controller: form.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: RegisterValidators.email,
                decoration: const InputDecoration(labelText: 'Email'),
              ).padding(top: AppSpacing.md),

              TextFormField(
                controller: form.passwordController,
                obscureText: true,
                validator: RegisterValidators.password,
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
                    : const Text('Cadastrar'),
              ).padding(top: AppSpacing.lg),

              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('Já tem conta? Entrar'),
              ).padding(top: AppSpacing.sm),
            ],
          ),
        ).padding(all: AppSpacing.lg),
      ),
    );
  }
}
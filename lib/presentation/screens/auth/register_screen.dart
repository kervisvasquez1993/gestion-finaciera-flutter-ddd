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

  InputDecoration _decoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.danger),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messenger = ScaffoldMessenger.of(context);

    final form = useRegisterForm(
      ref,
      onSuccess: () {
        messenger.showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Text('Cadastro realizado com sucesso!'),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            margin: const EdgeInsets.all(AppSpacing.md),
            duration: const Duration(seconds: 2),
          ),
        );
        context.go('/login');
      },
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: form.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xl),

                const Text('Criar conta', style: AppTextStyles.heading1),
                const Text('Preencha os dados abaixo', style: AppTextStyles.caption)
                    .padding(top: AppSpacing.xs),

                TextFormField(
                  controller: form.nameController,
                  textInputAction: TextInputAction.next,
                  validator: RegisterValidators.name,
                  decoration: _decoration(label: 'Nome', icon: Icons.person_outline),
                ).padding(top: AppSpacing.xl),

                TextFormField(
                  controller: form.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: RegisterValidators.email,
                  decoration: _decoration(label: 'Email', icon: Icons.mail_outline),
                ).padding(top: AppSpacing.md),

                TextFormField(
                  controller: form.passwordController,
                  obscureText: form.obscurePassword,
                  textInputAction: TextInputAction.done,
                  validator: RegisterValidators.password,
                  onFieldSubmitted: (_) => form.isLoading ? null : form.onSubmit(),
                  decoration: _decoration(
                    label: 'Senha',
                    icon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        form.obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: form.togglePasswordVisibility,
                    ),
                  ),
                ).padding(top: AppSpacing.md),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: form.errorMessage != null
                      ? Container(
                          key: ValueKey(form.errorMessage),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline, color: AppColors.danger, size: 18),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  form.errorMessage!,
                                  style: const TextStyle(color: AppColors.danger, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ).padding(top: AppSpacing.md),

                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: form.isLoading ? null : form.onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      elevation: 0,
                    ),
                    child: form.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Text('Cadastrar', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ).padding(top: AppSpacing.lg),

                TextButton(
                  onPressed: () => context.go('/login'),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                      children: [
                        TextSpan(text: 'Já tem conta? '),
                        TextSpan(
                          text: 'Entrar',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ).padding(top: AppSpacing.sm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
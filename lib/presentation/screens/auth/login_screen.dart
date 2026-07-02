import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gestao_financeira/presentation/forms/auth/login_validators.dart';
import 'package:gestao_financeira/presentation/hooks/auth/use_login_form.dart';
import 'package:gestao_financeira/presentation/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

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
    final form = useLoginForm(ref, onSuccess: () => context.go('/'));

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
                const SizedBox(height: AppSpacing.xxl),

                const Text('Bem-vindo de volta', style: AppTextStyles.heading1),
                const Text('Entre na sua conta', style: AppTextStyles.caption)
                    .padding(top: AppSpacing.xs),

                TextFormField(
                  controller: form.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: LoginValidators.email,
                  decoration: _decoration(label: 'Email', icon: Icons.mail_outline),
                ).padding(top: AppSpacing.xl),

                TextFormField(
                  controller: form.passwordController,
                  obscureText: form.obscurePassword,
                  textInputAction: TextInputAction.done,
                  validator: LoginValidators.password,
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
                        : const Text('Entrar', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ).padding(top: AppSpacing.lg),

                TextButton(
                  onPressed: () => context.go('/register'),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                      children: [
                        TextSpan(text: 'Não tem conta? '),
                        TextSpan(
                          text: 'Cadastre-se',
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
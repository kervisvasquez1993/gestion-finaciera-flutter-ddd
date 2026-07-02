import 'package:flutter/material.dart';
import 'package:gestao_financeira/application/providers/auth/session_notifier.dart';
import 'package:gestao_financeira/presentation/theme/app_spacing.dart';
import 'package:gestao_financeira/presentation/theme/app_text_styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Início')),
      body: Center(
        child: session.when(
          data: (user) => Text(
            'Olá, ${user?.name ?? "usuário"}!',
            style: AppTextStyles.heading2,
          ),
          loading: () => const CircularProgressIndicator(),
          error: (err, _) => Text('Erro: $err', style: AppTextStyles.body),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(sessionNotifierProvider.notifier).logout(),
        child: const Icon(Icons.logout),
      ).padding(bottom: AppSpacing.md),
    );
  }
}
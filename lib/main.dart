import 'package:flutter/material.dart';
import 'package:gestao_financeira/app/router.dart';
import 'package:gestao_financeira/presentation/theme/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(const ProviderScope(child: App()));

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: AppTheme.light,
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
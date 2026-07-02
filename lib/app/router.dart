import 'package:flutter/material.dart';
import 'package:gestao_financeira/app/go_router_refresh_notifier.dart';
import 'package:gestao_financeira/application/providers/auth/session_notifier.dart';
import 'package:gestao_financeira/presentation/screens/auth/login_screen.dart';
import 'package:gestao_financeira/presentation/screens/auth/register_screen.dart';
import 'package:gestao_financeira/presentation/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final sessionState = ref.watch(sessionNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshNotifier(ref),
    redirect: (context, state) {
      final isLoggedIn = sessionState.value != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      // todavía cargando sesión inicial (bootstrap) -> no redirigir aún
      if (sessionState.isLoading) return null;

      if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && isAuthRoute) return '/';

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    ],
  );
});
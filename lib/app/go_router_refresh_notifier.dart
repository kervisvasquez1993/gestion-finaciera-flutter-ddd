import 'package:flutter/foundation.dart';
import 'package:gestao_financeira/application/providers/auth/session_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(Ref ref) {
    ref.listen(sessionNotifierProvider, (_, __) => notifyListeners());
  }
}
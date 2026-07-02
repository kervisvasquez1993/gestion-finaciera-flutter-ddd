
import 'package:gestao_financeira/infrastructure/api/auth_token_storage.dart';

class LogoutUseCase {
  void call() => AuthTokenStorage.instance.clearSession();
}
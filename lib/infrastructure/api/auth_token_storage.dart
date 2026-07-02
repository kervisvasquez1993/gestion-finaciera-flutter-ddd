class AuthTokenStorage {
  AuthTokenStorage._();
  static final AuthTokenStorage instance = AuthTokenStorage._();

  String? _accessToken;

  String? get accessToken => _accessToken;

  void setToken(String? token) => _accessToken = token;
  void clearSession() => _accessToken = null;
}
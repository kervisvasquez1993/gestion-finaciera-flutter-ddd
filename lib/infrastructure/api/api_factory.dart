import 'package:dio/dio.dart';
import 'adapters/dio_adapter.dart';
import 'auth_token_storage.dart';
import 'http_adapter.dart';

class ApiFactoryOptions {
  final String baseUrl;
  final Map<String, dynamic>? headers;
  final bool useInterceptors;

  ApiFactoryOptions({
    required this.baseUrl,
    this.headers,
    this.useInterceptors = false,
  });
}

HttpAdapter createApiClient(ApiFactoryOptions options) {
  InterceptorHandlers? interceptors;

  if (options.useInterceptors) {
    interceptors = InterceptorHandlers(
      onRequest: (config) {
        final token = AuthTokenStorage.instance.accessToken;
        if (token != null) {
          config.headers['Authorization'] = 'Bearer $token';
        }
        return config;
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          AuthTokenStorage.instance.clearSession();
        }
        handler.next(error);
      },
    );
  }

  return DioAdapter(
    DioAdapterOptions(
      baseUrl: options.baseUrl,
      headers: options.headers,
      interceptors: interceptors,
    ),
  );
}
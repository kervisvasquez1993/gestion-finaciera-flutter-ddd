import 'api_factory.dart';
import 'http_adapter.dart';

const String _baseUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:3000/api',
);

const Map<String, String> _baseHeaders = {
  'Content-Type': 'application/json',
};

final HttpAdapter publicApi = createApiClient(
  ApiFactoryOptions(baseUrl: _baseUrl, useInterceptors: false, headers: _baseHeaders),
);

final HttpAdapter authApi = createApiClient(
  ApiFactoryOptions(baseUrl: _baseUrl, useInterceptors: true, headers: _baseHeaders),
);
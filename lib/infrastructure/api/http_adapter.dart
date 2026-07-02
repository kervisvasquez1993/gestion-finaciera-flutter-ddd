abstract class HttpAdapter {
  Future<T> get<T>(String url, {Map<String, dynamic>? options});
  Future<T> post<T>(String url, dynamic data, {Map<String, dynamic>? options});
  Future<T> put<T>(String url, dynamic data, {Map<String, dynamic>? options});
  Future<T> delete<T>(String url, {Map<String, dynamic>? options});
  Future<T> patch<T>(String url, dynamic data, {Map<String, dynamic>? options});
}
import 'dart:async';
import 'package:dio/dio.dart';
import '../http_adapter.dart';

class InterceptorHandlers {
  final FutureOr<RequestOptions> Function(RequestOptions options)? onRequest;
  final FutureOr<Response> Function(Response response)? onResponse;
  final FutureOr<void> Function(DioException error, ErrorInterceptorHandler handler)? onError;

  InterceptorHandlers({this.onRequest, this.onResponse, this.onError});
}

class DioAdapterOptions {
  final String baseUrl;
  final Map<String, dynamic>? headers;
  final InterceptorHandlers? interceptors;

  DioAdapterOptions({required this.baseUrl, this.headers, this.interceptors});
}

class DioAdapter implements HttpAdapter {
  late final Dio _dio;

  DioAdapter(DioAdapterOptions options) {
    _dio = Dio(
      BaseOptions(
        baseUrl: options.baseUrl,
        headers: options.headers,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    if (options.interceptors != null) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (opts, handler) async {
            final result = options.interceptors!.onRequest != null
                ? await options.interceptors!.onRequest!(opts)
                : opts;
            handler.next(result);
          },
          onResponse: (response, handler) async {
            final result = options.interceptors!.onResponse != null
                ? await options.interceptors!.onResponse!(response)
                : response;
            handler.next(result);
          },
          onError: (error, handler) async {
            if (options.interceptors!.onError != null) {
              await options.interceptors!.onError!(error, handler);
            } else {
              handler.next(error);
            }
          },
        ),
      );
    }
  }

  @override
  Future<T> get<T>(String url, {Map<String, dynamic>? options}) async {
    final res = await _dio.get<T>(url, queryParameters: options);
    return res.data as T;
  }

  @override
  Future<T> post<T>(String url, dynamic data, {Map<String, dynamic>? options}) async {
    final res = await _dio.post<T>(url, data: data, queryParameters: options);
    return res.data as T;
  }

  @override
  Future<T> put<T>(String url, dynamic data, {Map<String, dynamic>? options}) async {
    final res = await _dio.put<T>(url, data: data, queryParameters: options);
    return res.data as T;
  }

  @override
  Future<T> delete<T>(String url, {Map<String, dynamic>? options}) async {
    final res = await _dio.delete<T>(url, queryParameters: options);
    return res.data as T;
  }

  @override
  Future<T> patch<T>(String url, dynamic data, {Map<String, dynamic>? options}) async {
    final res = await _dio.patch<T>(url, data: data, queryParameters: options);
    return res.data as T;
  }
}
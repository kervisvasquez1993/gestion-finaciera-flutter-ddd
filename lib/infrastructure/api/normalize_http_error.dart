import 'package:dio/dio.dart';

class NormalizedHttpError {
  final int statusCode;
  final List<String> messages;

  NormalizedHttpError({required this.statusCode, required this.messages});
}

NormalizedHttpError normalizeHttpError(Object error) {
  if (error is DioException) {
    final data = error.response?.data;
    final statusCode = error.response?.statusCode ?? 0;

    dynamic rawMessage;
    if (data is Map<String, dynamic>) {
      rawMessage = data['message'];
    }

    final messages = rawMessage is List
        ? rawMessage.map((e) => e.toString()).toList()
        : rawMessage != null
            ? [rawMessage.toString()]
            : ['Ocorreu um erro inesperado'];

    return NormalizedHttpError(statusCode: statusCode, messages: messages);
  }

  return NormalizedHttpError(statusCode: 0, messages: ['Ocorreu um erro inesperado']);
}
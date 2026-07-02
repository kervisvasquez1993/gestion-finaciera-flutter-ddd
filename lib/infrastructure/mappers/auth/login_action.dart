
import 'package:gestao_financeira/domain/auth/dto/login_dto.dart';
import 'package:gestao_financeira/infrastructure/api/api_client.dart';
import 'package:gestao_financeira/infrastructure/models/api_response.dart';
import 'package:gestao_financeira/infrastructure/models/auth/session_model.dart';

Future<SessionModel> loginAction(LoginRequest data) async {
  final json = await publicApi.post<Map<String, dynamic>>('/auth/login', {
    'email': data.email,
    'password': data.password,
  });

  final api = ApiResponse<SessionModel>.fromJson(
    json,
    (d) => SessionModel.fromJson(d as Map<String, dynamic>),
  );

  return api.data;
}
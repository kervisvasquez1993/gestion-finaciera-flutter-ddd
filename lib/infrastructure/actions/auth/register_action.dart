
import 'package:gestao_financeira/domain/auth/dto/register_dto.dart';
import 'package:gestao_financeira/infrastructure/api/api_client.dart';
import 'package:gestao_financeira/infrastructure/models/api_response.dart';
import 'package:gestao_financeira/infrastructure/models/auth/user_model.dart';

Future<UserModel> registerAction(RegisterRequest data) async {
  final json = await publicApi.post<Map<String, dynamic>>('/auth/register', {
    'name': data.name,
    'email': data.email,
    'password': data.password,
  });

  final api = ApiResponse<UserModel>.fromJson(
    json,
    (d) => UserModel.fromJson(d as Map<String, dynamic>),
  );

  return api.data;
}
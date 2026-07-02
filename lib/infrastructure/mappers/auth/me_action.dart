
import 'package:gestao_financeira/infrastructure/api/api_client.dart';
import 'package:gestao_financeira/infrastructure/models/api_response.dart';
import 'package:gestao_financeira/infrastructure/models/auth/user_model.dart';

Future<UserModel> meAction() async {
  final json = await authApi.get<Map<String, dynamic>>('/users/me');

  final api = ApiResponse<UserModel>.fromJson(
    json,
    (d) => UserModel.fromJson(d as Map<String, dynamic>),
  );

  return api.data;
}
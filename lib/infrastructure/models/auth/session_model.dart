import 'user_model.dart';

class SessionModel {
  final String accessToken;
  final UserModel user;

  SessionModel({required this.accessToken, required this.user});

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        accessToken: json['accessToken'] as String,
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      );
}
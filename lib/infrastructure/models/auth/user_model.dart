class UserModel {
  final String id;
  final String name;
  final String email;
  final String? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        createdAt: json['createdAt'] as String?,
      );
}
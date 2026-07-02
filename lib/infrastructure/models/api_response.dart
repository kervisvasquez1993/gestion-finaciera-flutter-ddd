class ApiResponse<T> {
  final bool success;
  final T data;

  ApiResponse({required this.success, required this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromData,
  ) {
    return ApiResponse(
      success: json['success'] as bool,
      data: fromData(json['data']),
    );
  }
}
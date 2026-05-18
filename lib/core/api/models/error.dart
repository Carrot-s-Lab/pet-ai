class ApiError {
  ApiError({this.errorMessage = const []});

  final List<String>? errorMessage;

  factory ApiError.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return ApiError();
    }
    return ApiError(
      errorMessage: map['error_message'] != null ? List<String>.from(map['error_message']) : null,
    );
  }
}
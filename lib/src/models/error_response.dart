class ErrorResponse {
  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      statusCode: map['statusCode'] as int,
      message: map['message'] as String,
      name: map['name'] as String,
    );
  }

  ErrorResponse({
    required this.statusCode,
    required this.message,
    required this.name,
  });

  final int statusCode;
  final String message;
  final String name;

  Exception returnMessage() {
    return Exception('Error response: ${statusCode} - ${message}');
  }
}

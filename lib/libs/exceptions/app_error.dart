abstract class AppError implements Exception{
  final String title;
  final String message;
  final String? code;

  AppError({
    required this.title,
    required this.message,
    this.code,
  });
}

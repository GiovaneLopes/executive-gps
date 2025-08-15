import 'package:executive_gps/libs/exceptions/app_error.dart';

class AppGenericErrors extends AppError {
  AppGenericErrors({
    required super.title,
    required super.message,
    super.code,
  });

  static final noConnectionError = AppGenericErrors(
    title: 'Sem Conexão',
    message: 'Dispositivo sem conexão com a internet.',
    code: 'no_connection',
  );

  static final genericError = AppGenericErrors(
    title: 'Tivemos um problema',
    message: 'Por favor, tente novamente em instantes.',
    code: 'generic_error',
  );

  @override
  String toString() {
    return 'AppGenericErrors(title: $title, message: $message, code: $code)';
  }
}

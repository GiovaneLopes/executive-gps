import 'package:firebase_auth/firebase_auth.dart';
import 'package:executive_gps/libs/exceptions/app_error.dart';

class UserExceptions extends AppError {
  UserExceptions({
    required super.title,
    required super.message,
    super.code,
  });

  static final emailNotVerified = UserExceptions(
    title: 'Email não verificado',
    message: 'O email ainda não foi verificado.',
  );

  factory UserExceptions.fromFirebaseAuthException(FirebaseAuthException e) {
    String title;
    String message;
    String? code = e.code;
    switch (e.code) {
      case 'user-not-found':
        title = 'Usuário não encontrado';
        message = 'Nenhum usuário encontrado com esse e-mail.';
        break;
      case 'wrong-password':
        title = 'Senha incorreta';
        message = 'A senha fornecida está incorreta.';
        break;
      case 'invalid-email':
        title = 'Email inválido';
        message = 'O email fornecido é inválido';
        break;
      case 'email-already-in-use':
        title = 'Email já cadastrado';
        message = 'O email já está sendo utilizado';
        break;
      case 'user-disabled':
        title = 'Usuário desabilitado';
        message =
            'Este usuário está desabilitado. Entre em contato com o suporte.';
        break;
      case 'operation-not-allowed':
        title = 'Operação não permitida';
        message = 'Esta operação não é permitida.';
        break;
      case 'weak-password':
        title = 'Senha fraca';
        message = 'A senha é muito fraca.';
        break;
      case 'invalid-credential':
        title = 'Credencial inválida';
        message = 'A credencial fornecida é inválida.';
        break;
      default:
        title = 'Erro de Autenticação';
        message = 'Ocorreu um erro de autenticação: ${e.message}';
    }
    return UserExceptions(
      title: title,
      message: message,
      code: code,
    );
  }
}

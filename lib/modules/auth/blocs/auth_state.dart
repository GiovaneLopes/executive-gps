part of './auth_bloc.dart';

class AuthState extends Equatable {
  final AppRoute? route;
  final UserModel? user;
  final AuthStatus status;
  final bool obscurePassword;
  final AppError? error;
  const AuthState({
    this.route,
    this.user,
    this.status = AuthStatus.initial,
    this.obscurePassword = true,
    this.error,
  });

  AuthState copyWith({
    AppRoute? route,
    UserModel? Function()? user,
    AuthStatus? status,
    bool? obscurePassword,
    AppError? error,
  }) {
    return AuthState(
      route: route?..navigate(),
      user: user != null ? user() : this.user,
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        route,
        user,
        status,
        obscurePassword,
        error,
      ];
}

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:executive_gps/modules/home/home_routes.dart';
import 'package:executive_gps/modules/auth/auth_routes.dart';
import 'package:executive_gps/libs/exceptions/app_error.dart';
import 'package:executive_gps/modules/shared/utils/app_route.dart';
import 'package:executive_gps/libs/modules/user/models/user_model.dart';
import 'package:executive_gps/libs/modules/user/repositories/user_repository.dart';

part './auth_state.dart';

enum AuthStatus {
  initial,
  loading,
  loaded,
  authenticated,
  unauthenticated,
  error,
}

class AuthBloc extends Cubit<AuthState> {
  final UserRepository repository;
  AuthBloc(this.repository) : super(const AuthState()) {
    init();
  }

  void init() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final user = await repository.getCurrentUser();
      emit(
        state.copyWith(
          route: user != null ? HomeRoutes.home : AuthRoutes.signIn,
          status: user != null
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
        ),
      );
    } catch (e) {
      debugPrint('Sign in failed: $e');
    }
  }

  void signIn(String email, String password) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final user = await repository.signIn(email, password);
      emit(
        state.copyWith(
          route: user != null ? HomeRoutes.home : AuthRoutes.signIn,
          status: user != null
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: e as AppError,
          status: AuthStatus.error,
        ),
      );
    }
  }

  Future<void> recoverPassword(String email) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await repository.recoverPassword(email);
      emit(state.copyWith(status: AuthStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          error: e as AppError,
          status: AuthStatus.error,
        ),
      );
    }
  }

  void updateObscurePassword() async {
    emit(
      state.copyWith(
        status: AuthStatus.initial,
        obscurePassword: !state.obscurePassword,
      ),
    );
  }

  void logout() async {
    try {
      await repository.logout();
      emit(
        state.copyWith(
          route: AuthRoutes.signIn,
          status: AuthStatus.unauthenticated,
        ),
      );
    } catch (e) {
      debugPrint('Logout failed: $e');
    }
  }
}

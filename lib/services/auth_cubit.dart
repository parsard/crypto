import 'package:crypto_app/services/nobitex_service.dart';
import 'package:crypto_app/services/token_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? token;
  final String? error;

  AuthState({this.isLoading = true, this.isAuthenticated = false, this.token, this.error});

  AuthState copyWith({bool? isLoading, bool? isAuthenticated, String? token}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      error: error ?? error,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  final NobitexService _nobitexService;

  AuthCubit({required NobitexService nobitexService})
      : _nobitexService = nobitexService,
        super(AuthState(isLoading: true));

  Future<void> checkAuth() async {
    emit(state.copyWith(isLoading: true));
    final token = await TokenStorage.readToken();
    if (token != null && token.isNotEmpty) {
      emit(AuthState(isAuthenticated: true, isLoading: false, token: token));
    } else {
      emit(AuthState(isAuthenticated: false, isLoading: false));
    }
  }

  Future<void> login(String token) async {
    emit(state.copyWith(isLoading: true));
    await TokenStorage.saveToken(token);
    emit(AuthState(isAuthenticated: true, isLoading: false, token: token));
  }

  Future<void> logout() async {
    if (!state.isAuthenticated || state.token == null) return;
    emit(state.copyWith(isLoading: true));
    try {
      await _nobitexService.logout(state.token!);
      await TokenStorage.deleteToken();
      emit(AuthState(isAuthenticated: false, isLoading: false, token: null));
    } catch (e) {
      debugPrint('An error occurred during logout process: $e');
      await TokenStorage.deleteToken(); // اطمینان از پاک شدن توکن محلی
      emit(AuthState(
          isAuthenticated: false,
          isLoading: false,
          token: null,
          error: 'Logout failed on server, but you have been logged out locally.'));
    }
  }
}

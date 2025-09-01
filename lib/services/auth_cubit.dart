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

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? token,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      error: error,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  final NobitexService _nobitexService;

  AuthCubit({required NobitexService nobitexService})
      : _nobitexService = nobitexService,
        super(AuthState(isLoading: true)) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    emit(state.copyWith(isLoading: true));
    try {
      final token = await TokenStorage.readToken();
      if (token != null && token.isNotEmpty) {
        emit(state.copyWith(isAuthenticated: true, isLoading: false, token: token, error: null));
      } else {
        emit(state.copyWith(isAuthenticated: false, isLoading: false, token: null, error: null));
      }
    } catch (e) {
      debugPrint('Error during initial auth check: $e');
      emit(state.copyWith(
          isAuthenticated: false,
          isLoading: false,
          token: null,
          error: 'Failed to check authentication status. Please try logging in again.'));
    }
  }

  Future<void> loginFromStorage() async {
    emit(state.copyWith(isLoading: true));
    try {
      final token = await TokenStorage.readToken();
      if (token != null && token.isNotEmpty) {
        emit(state.copyWith(isAuthenticated: true, isLoading: false, token: token, error: null));
      } else {
        emit(state.copyWith(
            isAuthenticated: false, isLoading: false, token: null, error: 'No token found after login attempt.'));
      }
    } catch (e) {
      debugPrint('Error during loginFromStorage: $e');
      emit(state.copyWith(
          isAuthenticated: false, isLoading: false, token: null, error: 'Failed to load token from storage.'));
    }
  }

  Future<void> logout({String? error}) async {
    if (!state.isAuthenticated && error == null) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      await TokenStorage.deleteToken();
      emit(state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        token: null,
        error: error,
      ));
    } catch (e) {
      debugPrint('An error occurred during logout process: $e');
      await TokenStorage.deleteToken();
      emit(state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        token: null,
        error: error ?? 'Logout failed locally.',
      ));
    }
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }
}

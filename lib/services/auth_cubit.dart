import 'package:crypto_app/services/token_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? token;

  AuthState({this.isLoading = true, this.isAuthenticated = false, this.token});

  AuthState copyWith({bool? isLoading, bool? isAuthenticated, String? token}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

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
    // optionally verify server here
    emit(AuthState(isAuthenticated: true, isLoading: false, token: token));
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoading: true));
    await TokenStorage.deleteToken();
    emit(AuthState(isAuthenticated: false, isLoading: false, token: null));
  }
}

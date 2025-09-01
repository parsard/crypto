import 'package:crypto_app/services/auth_cubit.dart';
import 'package:crypto_app/services/nobitex_service.dart';
import 'package:crypto_app/services/token_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_key_state.dart';

class ApiKeyCubit extends Cubit<ApiKeyState> {
  final NobitexService _service;
  final AuthCubit _authCubit;

  ApiKeyCubit(this._service, this._authCubit) : super(const ApiKeyState());

  void apiKeyChanged(String value) {
    emit(state.copyWith(apiKey: value, error: null, isSuccess: false));
  }

  void toggleObscure() {
    emit(state.copyWith(isObscured: !state.isObscured));
  }

  Future<void> submit() async {
    if (state.apiKey.trim().isEmpty) {
      emit(state.copyWith(error: "API Key cannot be empty", isSuccess: false));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

    try {
      final cleanedToken = _service.cleanToken(state.apiKey.trim());
      final isValid = await _service.validateToken(cleanedToken);

      if (isValid) {
        await TokenStorage.saveToken(state.apiKey.trim());
        await _authCubit.loginFromStorage();

        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, error: "Invalid API Key"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Validation failed: $e"));
    }
  }
}

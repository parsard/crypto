import 'package:crypto_app/services/nobitex_service.dart';
import 'package:crypto_app/services/token_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_key_state.dart';

class ApiKeyCubit extends Cubit<ApiKeyState> {
  final NobitexService _service;

  ApiKeyCubit(this._service) : super(const ApiKeyState());

  void apiKeyChanged(String value) {
    emit(state.copyWith(apiKey: value, error: null));
  }

  void toggleObscure() {
    emit(state.copyWith(isObscured: !state.isObscured));
  }

  Future<void> submit() async {
    if (state.apiKey.trim().isEmpty) {
      emit(state.copyWith(error: "API Key cannot be empty"));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final isValid = await _service.validateToken(state.apiKey.trim());

      if (isValid) {
        // Persist token securely
        await TokenStorage.saveToken(state.apiKey.trim());

        emit(state.copyWith(isLoading: false, isSuccess: true)); // UI can check success by error == null
      } else {
        emit(state.copyWith(isLoading: false, error: "Invalid API Key"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Validation failed: $e"));
    }
  }
}

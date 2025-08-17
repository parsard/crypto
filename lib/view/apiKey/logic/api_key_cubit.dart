import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_key_state.dart';

class ApiKeyCubit extends Cubit<ApiKeyState> {
  ApiKeyCubit() : super(const ApiKeyState());

  void apiKeyChanged(String value) {
    emit(state.copyWith(apiKey: value, error: null));
  }

  void toggleObscure() {
    emit(state.copyWith(isObscured: !state.isObscured));
  }

  Future<void> submit() async {
    if (state.apiKey.isEmpty) {
      emit(state.copyWith(error: "API Key cannot be empty"));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isLoading: false));
  }
}

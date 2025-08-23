import 'package:equatable/equatable.dart';

class ApiKeyState extends Equatable {
  final String apiKey;
  final String? error;
  final bool isObscured;
  final bool isLoading;
  final bool isSuccess;

  const ApiKeyState({
    this.apiKey = '',
    this.error,
    this.isObscured = true,
    this.isLoading = false,
    this.isSuccess = false,
  });

  ApiKeyState copyWith({String? apiKey, String? error, bool? isObscured, bool? isLoading, bool? isSuccess}) {
    return ApiKeyState(
      apiKey: apiKey ?? this.apiKey,
      error: error,
      isObscured: isObscured ?? this.isObscured,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [apiKey, error, isObscured, isLoading, isSuccess];
}

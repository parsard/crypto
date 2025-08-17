import 'package:equatable/equatable.dart';

class ApiKeyState extends Equatable {
  final String apiKey;
  final String? error;
  final bool isObscured;
  final bool isLoading;

  const ApiKeyState({this.apiKey = '', this.error, this.isObscured = true, this.isLoading = false});

  ApiKeyState copyWith({String? apiKey, String? error, bool? isObscured, bool? isLoading}) {
    return ApiKeyState(
      apiKey: apiKey ?? this.apiKey,
      error: error,
      isObscured: isObscured ?? this.isObscured,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [apiKey, error, isObscured, isLoading];
}

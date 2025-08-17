import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void pageChanged(int index) => emit(state.copyWith(currentPage: index));

  void skipOnboarding(context) {
    Navigator.pushReplacementNamed(context, '/api-key');
  }

  void completeOnboarding(context) {
    Navigator.pushReplacementNamed(context, '/api-key');
  }
}

import 'package:crypto_app/services/profile_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService profileService;
  final String token;

  ProfileCubit({required this.profileService, required this.token}) : super(const ProfileState());

  Future<void> fetchProfile() async {
    // Avoid fetching again if it's already loading or successful
    if (state.status == ProfileStatus.loading) return;

    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final userProfile = await profileService.fetchUserProfile(token: token);
      emit(state.copyWith(
        status: ProfileStatus.success,
        userProfile: userProfile,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        error: e.toString(),
      ));
    }
  }
}

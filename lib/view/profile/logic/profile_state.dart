import 'package:crypto_app/model/user_profile.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserProfile? userProfile;
  final String? error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.userProfile,
    this.error,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserProfile? userProfile,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, userProfile, error];
}

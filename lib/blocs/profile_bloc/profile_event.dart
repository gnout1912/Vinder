part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class CompleteProfileButtonPressed extends ProfileEvent {}

// ✅ THÊM SỰ KIỆN NÀY VÀO
class LoadSexualOrientations extends ProfileEvent {}

class OrientationSelected extends ProfileEvent {
  final String orientation;

  const OrientationSelected(this.orientation);

  @override
  List<Object> get props => [orientation];
}

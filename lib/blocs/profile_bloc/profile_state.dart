part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  final double completionPercentage;

  const ProfileInitial({this.completionPercentage = 80.0});

  @override
  List<Object> get props => [completionPercentage];
}

class ProfileCompletionNotice extends ProfileState {
  final double completionPercentage;

  const ProfileCompletionNotice({required this.completionPercentage});

  @override
  List<Object> get props => [completionPercentage];
}

class SexualOrientationSelection extends ProfileState {
  final Map<String, String> orientations;
  final String? selectedOrientation;

  const SexualOrientationSelection({
    required this.orientations,
    this.selectedOrientation,
  });

  SexualOrientationSelection copyWith({String? selectedOrientation}) {
    return SexualOrientationSelection(
      orientations: orientations,
      selectedOrientation: selectedOrientation ?? this.selectedOrientation,
    );
  }

  @override
  List<Object?> get props => [orientations, selectedOrientation];
}

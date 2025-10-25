import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial(completionPercentage: 80.0)) {
    // Sự kiện khi màn hình "Complete Profile" được nhấn
    on<CompleteProfileButtonPressed>((event, emit) {
      print('Nút Hoàn thành hồ sơ đã được nhấn!');
      add(LoadSexualOrientations());
    });

    // Sự kiện tải dữ liệu cho màn hình "Sexual Orientation"
    on<LoadSexualOrientations>((event, emit) {
      const Map<String, String> orientationsData = {
        'Heterosexual': 'Attraction to people of the opposite gender.',
        'Homosexual': 'Attraction to people of the same gender.',
        'Bisexual': 'Attraction to both men and women.',
        'Pansexual':
            'Attraction to people regardless of their gender identity.',
        'Asexual': 'Experiences little or no sexual attraction to others.',
      };

      // Phát ra state với lựa chọn mặc định là mục đầu tiên
      emit(
        SexualOrientationSelection(
          orientations: orientationsData,
          selectedOrientation: orientationsData.keys.first,
        ),
      );
    });

    // Sự kiện khi người dùng nhấn vào một lựa chọn khác
    on<OrientationSelected>((event, emit) {
      final currentState = state;
      if (currentState is SexualOrientationSelection) {
        // Cập nhật state với lựa chọn mới
        emit(currentState.copyWith(selectedOrientation: event.orientation));
      }
    });
  }
}

import 'package:ct312h_project/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SexualOrientationScreen extends StatelessWidget {
  const SexualOrientationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Định nghĩa các màu sắc chủ đạo từ hình ảnh
    const Color primaryPink = Color(0xFFFF78CE);
    const Color lightPink = Color(0xFFFF78CE);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Nút quay lại
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: primaryPink),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Nút Bỏ qua (Skip)
        actions: [
          TextButton(
            onPressed: () {
              print('Skip button pressed');
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: lightPink,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      // Dùng BlocBuilder để xây dựng UI dựa trên trạng thái của ProfileBloc
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // Nếu state chưa phải là SexualOrientationSelection, hiển thị loading
          if (state is! SexualOrientationSelection) {
            // Hoặc bạn có thể hiển thị một màn hình trống
            return const Center(child: CircularProgressIndicator());
          }

          // Khi state đã đúng, xây dựng giao diện chính
          return Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tiêu đề chính
                const Text(
                  'Sexual Orientation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryPink,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Dùng Expanded để danh sách lựa chọn chiếm hết không gian còn lại
                Expanded(
                  child: ListView.builder(
                    itemCount: state.orientations.length,
                    itemBuilder: (context, index) {
                      final title = state.orientations.keys.elementAt(index);
                      final description = state.orientations.values.elementAt(
                        index,
                      );
                      final isSelected = state.selectedOrientation == title;

                      return _OrientationOptionCard(
                        title: title,
                        description: description,
                        isSelected: isSelected,
                        onTap: () {
                          context.read<ProfileBloc>().add(
                            OrientationSelected(title),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Nút NEXT
                ElevatedButton(
                  onPressed: () {
                    print(
                      'Next button pressed with selection: ${state.selectedOrientation}',
                    ); 
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: primaryPink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Widget tùy chỉnh cho mỗi ô lựa chọn để tái sử dụng code
class _OrientationOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _OrientationOptionCard({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryPink = Color(0xFFFF78CE);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: isSelected ? primaryPink.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? primaryPink : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? primaryPink : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? primaryPink : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

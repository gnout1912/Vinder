import 'package:ct312h_project/blocs/profile_bloc/profile_bloc.dart';
import 'package:ct312h_project/screens/profile/sexual_orientation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LetCompleteProfileScreen extends StatelessWidget {
  const LetCompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                print('Nut skip da duoc nhan');
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Color(0xFFFF78CE),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final percentage = (state is ProfileInitial)
                  ? state.completionPercentage
                  : 0.0;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "LET'S COMPLETE PROFILE",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF78CE),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 3,
                    width: 100,
                    color: const Color(0xFFFF78CE),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'It looks like you’ve only completed ${percentage.toInt()}% of your profile. Finish the rest so we can give you better, more accurate matches!',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(
                        CompleteProfileButtonPressed(),
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<ProfileBloc>(),
                            child: const SexualOrientationScreen(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF78CE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Complete Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

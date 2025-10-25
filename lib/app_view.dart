import 'package:ct312h_project/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ct312h_project/screens/auth/welcome_screen.dart';
import 'package:ct312h_project/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vinder',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Colors.white,
          onSurface: Colors.black,
          primary: Colors.pink,
          onPrimary: Colors.black,
          secondary: Colors.pinkAccent,
          onSecondary: Colors.white,
          tertiary: Colors.pink,
          error: Colors.red,
          outline: Color(0xFF424242),
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return const HomeScreen();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}

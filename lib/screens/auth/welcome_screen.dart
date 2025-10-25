import 'dart:ui';
import 'package:ct312h_project/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ct312h_project/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:ct312h_project/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ct312h_project/screens/auth/sign_in_screen.dart';
import 'package:ct312h_project/screens/auth/sign_up_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pink = const Color(0xFFFF6FA4);
    final softPink = const Color(0xFFFFB6C7);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🎨 Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFF1F1), Color(0xFFFFE7DA)],
              ),
            ),
          ),

          // ☁️ Blurry circles
          Positioned(
            top: -120,
            left: -80,
            child: _blurBall(220, softPink.withOpacity(0.45), 40),
          ),
          Positioned(
            bottom: -140,
            right: -100,
            child: _blurBall(260, pink.withOpacity(0.35), 40),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  // 💖 Heart logo
                  Center(
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withOpacity(0.9),
                                  Colors.white.withOpacity(0.2),
                                ],
                              ),
                            ),
                          ),
                          Icon(Icons.favorite, size: 72, color: pink),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 26),

                  // 🩷 Tab Switch (Sign In / Sign Up)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: tabController,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black54,
                      indicatorSize: TabBarIndicatorSize
                          .tab, // 👈 make indicator fill half
                      dividerColor: Colors
                          .transparent, // 👈 removes the black line (Flutter ≥3.13)
                      indicator: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [softPink, pink],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      tabs: const [
                        Tab(text: "Sign In"),
                        Tab(text: "Sign Up"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 👇 Tab Views for both forms
                  SizedBox(
                    height: 600, // ensure enough space for forms
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(
                            userRepository: context
                                .read<AuthenticationBloc>()
                                .userRepository,
                          ),
                          child: const SignInScreen(),
                        ),
                        BlocProvider<SignUpBloc>(
                          create: (context) => SignUpBloc(
                            userRepository: context
                                .read<AuthenticationBloc>()
                                .userRepository,
                          ),
                          child: const SignUpScreen(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helpers
  Widget _blurBall(double size, Color color, double sigma) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
      ),
    );
  }
}

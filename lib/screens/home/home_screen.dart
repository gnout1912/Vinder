import 'package:ct312h_project/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ct312h_project/blocs/chat_bloc/chat_bloc.dart';
import 'package:ct312h_project/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.unauthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Đã đăng xuất!")),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.green[300],
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          elevation: 0,
          title: const Text(
            'Trang chủ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                context.read<AuthenticationBloc>().userRepository.logOut();
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Đây là HomeScreen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // ⭐ NÚT TEST CHATSCREEN
              ElevatedButton(
                onPressed: () {
                  final authUser =
                      context.read<AuthenticationBloc>().state.user!;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => ChatBloc(),
                        child: ChatScreen(
                          currentUserId: authUser.uid,   // UID thật
                          peerUserId: "TEST12345",      // tạm test
                          peerName: "Tester",
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green[600],
                ),
                child: const Text("Test Chat"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

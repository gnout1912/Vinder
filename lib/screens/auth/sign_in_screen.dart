import 'package:ct312h_project/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:ct312h_project/screens/auth/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  String? _errorMsg;

  final pink = const Color(0xFFFF6FA4);
  final softPink = const Color(0xFFFFB6C7);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),

          // 🔹 Email field
          MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(
              CupertinoIcons.envelope,
              color: Colors.black54,
              size: 20,
            ),
            errorMsg: _errorMsg,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Email cannot be empty';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // 🔹 Password field
          MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: const Icon(
              CupertinoIcons.lock_fill,
              color: Colors.black54,
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                  iconPassword = obscurePassword
                      ? CupertinoIcons.eye_fill
                      : CupertinoIcons.eye_slash_fill;
                });
              },
              icon: Icon(iconPassword, color: Colors.grey[600], size: 20),
            ),
            errorMsg: _errorMsg,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Password cannot be empty';
              }
              if (val.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          // 🔹 Forgot password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot password',
                style: TextStyle(color: pink, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 Sign In button
          !signInRequired
              ? Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [softPink, pink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: pink.withOpacity(0.28),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignInBloc>().add(
                          SignInRequired(
                            emailController.text,
                            passwordController.text,
                          ),
                        );
                        print('✅ Email: ${emailController.text}');
                        print('✅ Password: ${passwordController.text}');
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),

          const SizedBox(height: 16),

          // 🔹 Register link
          Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.black.withOpacity(0.7)),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Register',
                    style: TextStyle(color: pink, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:ct312h_project/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:ct312h_project/screens/auth/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool signUpRequired = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  IconData iconConfirmPassword = CupertinoIcons.eye_fill;
  String? _errorMsg;

  final pink = const Color(0xFFFF6FA4);
  final softPink = const Color(0xFFFFB6C7);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state is SignUpSuccess){
          setState(() {
            signUpRequired = false;
          });
          // Navigator.pop(context);
        } else if (state is SignUpProcess){
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure){
          return;
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // 🔹 Full name field
            MyTextField(
              controller: nameController,
              hintText: 'Full Name',
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(
                CupertinoIcons.person,
                color: Colors.black54,
                size: 20,
              ),
              errorMsg: _errorMsg,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Name cannot be empty';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

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
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(val)) {
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
                icon: Icon(iconPassword, color: Colors.grey[600], size: 20),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                    iconPassword = obscurePassword
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill;
                  });
                },
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

            const SizedBox(height: 16),

            // 🔹 Confirm password field
            MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: obscureConfirmPassword,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: const Icon(
                CupertinoIcons.lock_rotation,
                color: Colors.black54,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  iconConfirmPassword,
                  color: Colors.grey[600],
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                    iconConfirmPassword = obscureConfirmPassword
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill;
                  });
                },
              ),
              errorMsg: _errorMsg,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please confirm your password';
                }
                if (val != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // 🔹 Sign Up button
            !signUpRequired
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
                          MyUser myUser = MyUser.empty;
                          myUser = myUser.copyWith(
                            email: emailController.text,
                            name: nameController.text,
                          );
                          setState(() {
                            context.read<SignUpBloc>().add(
                              SignUpRequired(myUser, passwordController.text),
                            );
                          });
                          print('✅ Name: ${nameController.text}');
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
                        'Sign Up',
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

            // 🔹 Already have an account
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.black.withOpacity(0.7)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // or navigate to SignInScreen
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: pink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

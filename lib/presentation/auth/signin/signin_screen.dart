import 'package:crew_match/presentation/auth/createaccout/signup_screen.dart';
import 'package:crew_match/presentation/auth/forgotaccount/forgot_password_screen.dart';
import 'package:crew_match/presentation/main/main_screen.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:crew_match/utility/parth_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;
      print('Email: $email, Password: $password, Remember: $rememberMe');
      Get.off(() => MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 90.h),
                  SvgPicture.asset(
                    PathUtils.logoColor,
                    width: 0.7.sw,
                    semanticsLabel: 'App Logo',
                  ),
                  SizedBox(height: 40.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email', style: TextStyle(fontSize: 16.sp)),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(
                      hintText: 'Enter your Email',
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter your Email';
                      }
                      // Basic email format validation
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(text)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Password', style: TextStyle(fontSize: 16.sp)),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter your Password';
                      }
                      if (text.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return const Color(0xFFD30579);
                                }
                                return Colors.transparent;
                              },
                            ),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 135, 132, 134),
                              width: 2,
                            ),
                            checkColor: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          const Text('Remember Password'),
                        ],
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.off(() => const ForgotPasswordScreen());
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h),
                  TextWidgetButton(text: 'Sign In', onPressed: _handleSignIn),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {
                          Get.off(() => const SignupScreen());
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

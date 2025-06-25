import 'package:crew_match/presentation/auth/signin/signin_screen.dart';
import 'package:crew_match/presentation/main/main_screen.dart';
import 'package:crew_match/utility/parth_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => const SigninScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFD30579), Color(0xFFFAB558)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SvgPicture.asset(
              PathUtils.logoBland,
              width: .6.sw,
              semanticsLabel: 'App Logo',
            ),
          ),
        ),
      ),
    );
  }
}

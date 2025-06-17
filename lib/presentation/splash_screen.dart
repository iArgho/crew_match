import 'package:crew_match/utility/parth_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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

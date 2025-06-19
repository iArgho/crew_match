import 'package:crew_match/utility/parth_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crew_match/presentation/splash_screen.dart';

class CrewMatch extends StatelessWidget {
  const CrewMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Crew Match',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: PathUtils.manropeFont,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
            useMaterial3: true,
            badgeTheme: const BadgeThemeData(backgroundColor: Colors.white),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.grey, width: 2),
              ),
              hintStyle: TextStyle(fontSize: 14.sp),
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

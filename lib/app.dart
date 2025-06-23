import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crew_match/presentation/splash_screen.dart';
// Import other screens as needed, e.g.:
// import 'package:crew_match/presentation/home_screen.dart';

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
          theme: _buildLightTheme(),

          home: const SplashScreen(),
        );
      },
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'manrope',
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.grey,
      ), // Grey-based color scheme
      badgeTheme: const BadgeThemeData(
        backgroundColor: Colors.white,
      ), // White badges1
      checkboxTheme: CheckboxThemeData(
        shape:
            const CircleBorder(), // Circular checkbox (replaces rounded rectangle)
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFFD30579); // Pink when checked
          }
          return Colors.transparent; // Transparent when unchecked
        }),
        side: const BorderSide(
          color: Color.fromARGB(255, 135, 132, 134), // Grey border
          width: 2,
        ),
        checkColor: MaterialStateProperty.all(Colors.white), // White checkmark
        visualDensity: VisualDensity.compact, // Compact size
      ),

      // Consolidated input decoration theme (replaces getTextFieldDecoration)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.08), // Subtle grey background
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey.shade600, // Subtle hint text
        ),
        labelStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
        ), // Floating label style
        errorStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.red,
        ), // Error text style
      ),

      // Text styles for consistent typography
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 16.sp),
        bodyMedium: TextStyle(fontSize: 14.sp),
        bodySmall: TextStyle(fontSize: 12.sp),
        titleLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        labelLarge: TextStyle(fontSize: 14.sp),
      ),

      // AppBar styling for clean look
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0, // No shadow
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

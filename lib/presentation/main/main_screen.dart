import 'package:crew_match/presentation/main/chat/chat_page.dart';
import 'package:crew_match/presentation/main/home/home_page.dart';
import 'package:crew_match/presentation/main/match/match_tile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppColors {
  static const primary = Color(0xFFD30579);
  static const unselected = Colors.black54;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MatchTileScreen(),
    ChatScreen(),
  ];

  Widget _navIcon(String asset, int index) {
    return SvgPicture.asset(
      asset,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? AppColors.primary : AppColors.unselected,
        BlendMode.srcIn,
      ),
      height: 24.sp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            _currentIndex < _screens.length
                ? _screens[_currentIndex]
                : const SizedBox(),
      ),
      bottomNavigationBar: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: SizedBox(
            height: 80.h,
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.unselected,
              selectedLabelStyle: TextStyle(fontSize: 12.sp),
              unselectedLabelStyle: TextStyle(fontSize: 12.sp),
              onTap: (index) => setState(() => _currentIndex = index),
              iconSize: 25.sp,
              items: [
                BottomNavigationBarItem(
                  icon: _navIcon('assets/icons/home.svg', 0),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: _navIcon('assets/icons/user-switch.svg', 1),
                  label: 'Match Tile',
                ),
                BottomNavigationBarItem(
                  icon: _navIcon('assets/icons/message.svg', 24),
                  label: 'Chat',
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 2,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }
}

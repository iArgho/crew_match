import 'package:crew_match/presentation/main/chat/chat_page.dart';
import 'package:crew_match/presentation/main/home/home_page.dart';
import 'package:crew_match/presentation/main/match/match_tile_page.dart';
import 'package:crew_match/presentation/main/notification_screen.dart';
import 'package:crew_match/presentation/user/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart' show rootBundle;

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

  // Function to check if asset exists
  Future<bool> _assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 1:
        return 'Match';
      case 2:
        return 'Chats';
      default:
        return 'Argho!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.8,
            automaticallyImplyLeading: false,
            titleSpacing: 25.w,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getAppBarTitle(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none),
                      color: Colors.black87,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: FutureBuilder<bool>(
                        future: _assetExists('assets/images/samplepice.jpg'),
                        builder: (context, snapshot) {
                          final hasImage = snapshot.data ?? false;

                          if (hasImage) {
                            return CircleAvatar(
                              radius: 22.r,
                              backgroundImage: const AssetImage(
                                'assets/images/samplepice.jpg',
                              ),
                            );
                          } else {
                            return Container(
                              width: 44.r,
                              height: 44.r,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFD30579),
                                    Color(0xFFFAB558),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 24.sp,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        child: SizedBox(
          height: 95.h,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: const Color(0xFFD30579),
            unselectedItemColor: Colors.black54,
            iconSize: 25.sp,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Match',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            ],
            backgroundColor: Colors.white,
            elevation: 8,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}

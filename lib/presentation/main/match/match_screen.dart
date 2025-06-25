import 'package:crew_match/presentation/main/chat/chat_page.dart';
import 'package:crew_match/presentation/main/home/home_page.dart';
import 'package:crew_match/presentation/main/main_screen.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchScreen extends StatefulWidget {
  final String matchName;
  final String matchImageUrl;
  final String myImageUrl;

  const MatchScreen({
    super.key,
    required this.matchName,
    required this.matchImageUrl,
    required this.myImageUrl,
  });

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen>
    with TickerProviderStateMixin {
  late AnimationController _leftController;
  late AnimationController _rightController;
  late Animation<Offset> _leftAnimation;
  late Animation<Offset> _rightAnimation;
  bool _showCongrats = false;

  @override
  void initState() {
    super.initState();

    _leftController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _rightController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _leftAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: const Offset(-0.2, 0.1),
    ).animate(CurvedAnimation(parent: _leftController, curve: Curves.easeOut));

    _rightAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: const Offset(0.2, -0.1),
    ).animate(CurvedAnimation(parent: _rightController, curve: Curves.easeOut));

    _leftController.forward().whenComplete(() {
      _rightController.forward().whenComplete(() {
        setState(() {
          _showCongrats = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Match Screen',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Matched user image with love icon half overlapping top-left
                    SlideTransition(
                      position: _leftAnimation,
                      child: Stack(
                        clipBehavior: Clip.none, // allow overflow
                        children: [
                          _buildRoundedImage(widget.matchImageUrl, imageWidth),
                          Positioned(
                            bottom: -12.h,
                            left: -12.w,
                            child: _buildLoveIcon(),
                          ),
                        ],
                      ),
                    ),
                    // Your image with love icon half overlapping top-right
                    SlideTransition(
                      position: _rightAnimation,
                      child: Stack(
                        clipBehavior: Clip.none, // allow overflow
                        children: [
                          _buildRoundedImage(widget.myImageUrl, imageWidth),
                          Positioned(
                            top: -12.h,
                            right: -12.w,
                            child: _buildLoveIcon(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80.h),
                AnimatedOpacity(
                  opacity: _showCongrats ? 1 : 0,
                  duration: const Duration(milliseconds: 600),
                  child: Column(
                    children: [
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'You matched with,  ${widget.matchName} !',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60.h),
                TextWidgetButton(
                  text: 'Say Hi!',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatScreen()),
                    );
                  },
                ),
                SizedBox(height: 20.h),

                // White background button with gradient border
                Container(
                  height: 58.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD30579), Color(0xFFFAB558)],
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MainPage()),
                        );
                      },
                      child: Text(
                        'Return to home',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFD30579),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedImage(String url, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: width,
        height: width * 1.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8.r,
              offset: const Offset(0, 4),
            ),
          ],
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildLoveIcon() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.r,
            offset: Offset(0, 3),
          ),
        ],
        // border removed here
      ),
      child: Icon(Icons.favorite, color: Colors.pinkAccent, size: 36.r),
    );
  }
}

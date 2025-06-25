import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'conversation_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
            automaticallyImplyLeading: false,
            title: Text(
              'Chat',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(12.w),
        children: const [
          ChatTile(
            name: 'Emma Watson',
            message: 'Hey, how are you?',
            time: '3 min ago',
            messageCount: 2,
            imageUrl: 'https://i.pravatar.cc/150?img=5',
          ),
          ChatTile(
            name: 'Liam',
            message: 'Let’s meet tomorrow.',
            time: '10 min ago',
            messageCount: 5,
            imageUrl: 'https://i.pravatar.cc/150?img=12',
          ),
          ChatTile(
            name: 'Sophia',
            message: 'Can you send me the report?',
            time: '20 min ago',
            messageCount: 1,
            imageUrl: 'https://i.pravatar.cc/150?img=33',
          ),
          ChatTile(
            name: 'Emma',
            message: 'Hey, how are you?',
            time: '3 min ago',
            messageCount: 2,
            imageUrl: 'https://i.pravatar.cc/150?img=5',
          ),
          ChatTile(
            name: 'Liam',
            message: 'Let’s meet tomorrow.',
            time: '10 min ago',
            messageCount: 5,
            imageUrl: 'https://i.pravatar.cc/150?img=12',
          ),
          ChatTile(
            name: 'Sophia',
            message: 'Can you send me the report?',
            time: '20 min ago',
            messageCount: 1,
            imageUrl: 'https://i.pravatar.cc/150?img=33',
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int messageCount;
  final String imageUrl;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.messageCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConversationScreen(name: name, imageUrl: imageUrl),
          ),
        );
      },
      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
      leading: Container(
        padding: EdgeInsets.all(2.r),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFFAB558), Color(0xFFD30579)],
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(2.5.r),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 24.r,
            backgroundImage: NetworkImage(imageUrl),
            backgroundColor: Colors.white,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
          Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),

      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ),
          if (messageCount > 0)
            Container(
              margin: EdgeInsets.only(left: 10.w),
              width: 18.w,
              height: 18.h,
              decoration: const BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$messageCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

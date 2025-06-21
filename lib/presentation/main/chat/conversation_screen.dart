import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class ConversationScreen extends StatefulWidget {
  final String name;
  final String imageUrl;

  const ConversationScreen({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hey there!',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(minutes: 15)),
    },
    {
      'text': 'Hi! How are you?',
      'isMe': true,
      'isRead': true,
      'time': DateTime.now().subtract(const Duration(minutes: 14)),
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        'text': _controller.text.trim(),
        'isMe': true,
        'isRead': false,
        'time': DateTime.now(),
      });
    });

    _controller.clear();
    _focusNode.requestFocus();
  }

  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 8,
          backgroundColor: Theme.of(context).colorScheme.surface,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 6.h,
                    horizontal: 10.w,
                  ),
                ),

                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 4.h,
                  ),
                  title: Text(
                    'View Profile',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('View Profile clicked')),
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 4.h,
                  ),
                  title: Text('Block', style: TextStyle(fontSize: 16.sp)),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User Blocked')),
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 4.h,
                  ),
                  title: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Chat Deleted')),
                    );
                  },
                ),

                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFAB558), Color(0xFFD30579)],
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(3.r),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl),
                  radius: 19.r,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: Theme.of(
                    context,
                  ).appBarTheme.titleTextStyle?.copyWith(fontSize: 18.sp),
                ),
                Row(
                  children: [
                    Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Online",
                      style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showOptionsDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment:
                      msg['isMe']
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          msg['isMe']
                              ? Theme.of(context).colorScheme.surfaceVariant
                              : const Color(0xFFD30579).withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(msg['isMe'] ? 16.r : 0),
                        bottomRight: Radius.circular(msg['isMe'] ? 0 : 16.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          msg['isMe']
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg['text'],
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${msg['time'].hour.toString().padLeft(2, '0')}:${msg['time'].minute.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            if (msg['isMe']) ...[
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.done_all,
                                size: 14.sp,
                                color:
                                    (msg['isRead'] ?? false)
                                        ? Colors.green
                                        : Colors.grey,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 14.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.r),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey, width: 2),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    splashRadius: 34,
                    icon: ShaderMask(
                      shaderCallback:
                          (bounds) => const LinearGradient(
                            colors: [Color(0xFFFAB558), Color(0xFFD30579)],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: Transform.rotate(
                        angle: 315 * math.pi / 180,
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'conversation_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          ChatTile(
            name: 'Emma Watson',
            message: 'Hey, how are you?',
            time: '3 min ago',
            messageCount: 2,
            imageUrl: 'https://i.pravatar.cc/150?img=5',
          ),
          ChatTile(
            name: 'Liam Smith',
            message: 'Let’s meet tomorrow.',
            time: '10 min ago',
            messageCount: 5,
            imageUrl: 'https://i.pravatar.cc/150?img=12',
          ),
          ChatTile(
            name: 'Sophia Lee',
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
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          if (messageCount > 0)
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$messageCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

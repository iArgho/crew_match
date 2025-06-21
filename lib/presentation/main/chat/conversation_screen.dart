import 'package:flutter/material.dart';

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
      'time': DateTime.now().subtract(const Duration(minutes: 14)),
    },
    {
      'text': 'I’m good, thanks. What about you?',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(days: 1, minutes: 5)),
    },
    {
      'text': 'Doing well! Working on a Flutter project.',
      'isMe': true,
      'time': DateTime.now().subtract(const Duration(days: 1, minutes: 3)),
    },
    {
      'text': 'That’s awesome!',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(days: 2)),
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
        'time': DateTime.now(),
      });
    });

    _controller.clear();
    _focusNode.requestFocus();
  }

  String getDateLabel(DateTime date) {
    final now = DateTime.now();
    final msgDate = DateTime(date.year, date.month, date.day);
    final today = DateTime(now.year, now.month, now.day);
    final difference = today.difference(msgDate).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.imageUrl),
              radius: 16,
            ),
            const SizedBox(width: 10),
            Text('Chat with ${widget.name}'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final msgDate = DateTime(
                  msg['time'].year,
                  msg['time'].month,
                  msg['time'].day,
                );

                bool showDateHeader = false;
                if (index == 0) {
                  showDateHeader = true;
                } else {
                  final prevMsg = messages[index - 1];
                  final prevMsgDate = DateTime(
                    prevMsg['time'].year,
                    prevMsg['time'].month,
                    prevMsg['time'].day,
                  );
                  showDateHeader =
                      msgDate.isBefore(prevMsgDate) ||
                      msgDate.isAfter(prevMsgDate);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (showDateHeader)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                getDateLabel(msg['time']),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Align(
                      alignment:
                          msg['isMe']
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: msg['isMe'] ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(msg['isMe'] ? 16 : 0),
                            bottomRight: Radius.circular(msg['isMe'] ? 0 : 16),
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
                                color:
                                    msg['isMe'] ? Colors.white : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${msg['time'].hour.toString().padLeft(2, '0')}:${msg['time'].minute.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                color:
                                    msg['isMe']
                                        ? Colors.white70
                                        : Colors.black54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

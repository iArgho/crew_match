import 'package:crew_match/presentation/main/chat/chat_page.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';

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
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rightController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _leftAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset(0.1, 0.1),
    ).animate(CurvedAnimation(parent: _leftController, curve: Curves.easeOut));

    _rightAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset(-.3, -.2),
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
    final imageWidth = MediaQuery.of(context).size.width * 0.35;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SlideTransition(
                    position: _leftAnimation,
                    child: _buildRoundedImage(widget.matchImageUrl, imageWidth),
                  ),
                  SlideTransition(
                    position: _rightAnimation,
                    child: _buildRoundedImage(widget.myImageUrl, imageWidth),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              AnimatedOpacity(
                opacity: _showCongrats ? 1 : 0,
                duration: const Duration(milliseconds: 600),
                child: Column(
                  children: [
                    Text(
                      'Congratulations!',
                      style: TextStyle(fontSize: 20, color: Colors.pink),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You matched with, ${widget.matchName}',
                      style: TextStyle(fontSize: 28, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextWidgetButton(
                  text: 'Say Hi!',
                  onPressed: () => ChatScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedImage(String url, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: width,
        height: width * 1.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

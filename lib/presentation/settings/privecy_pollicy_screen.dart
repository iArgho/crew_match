import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              "1. What data we collect?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "• Personal details: Name, phone number, email\n• Profile data: Photos, preferences, bio\n• Activity data: Likes, messages, views",
            ),
            SizedBox(height: 16),
            Text(
              "2. Why we collect data?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "• To personalize matches\n• To improve features\n• To notify updates",
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              "1. What type of data we collect?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Lorem ipsum dolor sit amet..."),
            SizedBox(height: 16),
            Text(
              "2. Why we collect data?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Lorem ipsum dolor sit amet..."),
            SizedBox(height: 16),
            Text(
              "3. How we use your data?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Lorem ipsum dolor sit amet..."),
          ],
        ),
      ),
    );
  }
}

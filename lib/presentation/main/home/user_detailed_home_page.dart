import 'package:flutter/material.dart';

class UserDetailedHomePage extends StatelessWidget {
  const UserDetailedHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: const Center(
        child: Text("User Detailed Home Page", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

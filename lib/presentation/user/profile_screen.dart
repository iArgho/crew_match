import 'package:crew_match/presentation/auth/createaccout/personal_details_screen.dart';
import 'package:crew_match/presentation/auth/createaccout/upload_photos_screen.dart';
import 'package:crew_match/presentation/settings/setting_screens.dart';
import 'package:crew_match/presentation/user/privecy_mode.dart';
import 'package:crew_match/presentation/user/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Information"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UploadPhotosScreen(),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PersonalDetailsScreen(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "John Doe",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "ACME Corp • Ship Titan",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.subscriptions),
              title: const Text("Subscription"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.off(() => const SubscriptionScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Privacy Mode"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.off(() => const PrivacyModeScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Account Information"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.off(() => PersonalDetailsScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.off(() => SettingScreens());
              },
            ),
            const ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Log Out", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

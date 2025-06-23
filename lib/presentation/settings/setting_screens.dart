import 'package:crew_match/presentation/settings/change_password_screen.dart';
import 'package:crew_match/presentation/settings/privecy_pollicy_screen.dart';
import 'package:crew_match/presentation/settings/terms_of_service.dart';
import 'package:flutter/material.dart';
import 'about_screen.dart';

class SettingScreens extends StatelessWidget {
  const SettingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text("Change Password"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text("Privacy Policy"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: const Text("Terms of Service"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TermsScreen()),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About Us"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text(
              "Delete Account",
              style: TextStyle(color: Colors.red),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.red,
            ),
            onTap: () {
              // Confirm delete account
            },
          ),
        ],
      ),
    );
  }
}

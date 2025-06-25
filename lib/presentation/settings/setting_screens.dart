import 'package:crew_match/presentation/settings/change_password_screen.dart';
import 'package:crew_match/presentation/settings/privecy_pollicy_screen.dart';
import 'package:crew_match/presentation/settings/terms_of_service.dart';
import 'package:crew_match/presentation/user/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'about_screen.dart';

class SettingScreens extends StatelessWidget {
  const SettingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settinngs",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ?? Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.off(ProfileScreen());
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/changepass.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              "Change Password",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
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
            leading: SvgPicture.asset(
              'assets/icons/privecy 2.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              "Privacy Policy",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
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
            leading: SvgPicture.asset(
              'assets/icons/terms and service.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              "Terms of Service",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
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
            leading: SvgPicture.asset(
              'assets/icons/about.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              "About Us",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
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
            leading: SvgPicture.asset(
              'assets/icons/delete.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
            ),
            title: const Text(
              "Delete Account",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.red,
            ),
            onTap: () {
              // TODO: Confirm and handle delete account
            },
          ),
        ],
      ),
    );
  }
}

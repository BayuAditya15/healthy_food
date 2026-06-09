import 'package:flutter/material.dart';
import '../../themes/theme_controller.dart';
import '../../services/user_profile_service.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.isDark,
      builder: (context, isDark, _) {
        return FutureBuilder<UserProfile>(
          future: UserProfileService.loadProfile(),
          builder: (context, snapshot) {
            final profile =
                snapshot.data ?? const UserProfile(name: 'User', email: '');

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // 🔙 balik
                  },
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          "assets/images/profile.jpg",
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        profile.email,
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Welcome back! Here are your account details.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 25),
                      _info("Full Name", profile.name, isDark),
                      _info("Email Address", profile.email, isDark),
                      _info("Phone", "-", isDark),
                      _info("Shipping Address", "-", isDark),
                      _info("Total Order", "-", isDark),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _info(String title, String value, bool isDark) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

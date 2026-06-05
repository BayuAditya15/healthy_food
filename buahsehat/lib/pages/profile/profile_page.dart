import 'package:flutter/material.dart';
import '../../widgets/profile_menu_item.dart';
import '../../widgets/bottom_to_top_route.dart';
import 'profile_detail_page.dart';
import '../message/messages_page.dart';
import '../elements/elements_page.dart';
import 'color_skins_page.dart';
import '../../widgets/bottom_nav.dart';
import '../category/categories_page.dart';
import '../../pages/wishlist/wishlist_page.dart';
import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../notification/notification_page.dart';
import 'package:healthyfood_app/pages/auth/landing_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onBackground),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          "User",
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),

        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ProfileMenuItem(
              icon: Icons.person,
              title: "MY PROFILE",
              onTap: () {
                Navigator.push(
                  context,
                  BottomToTopRoute(page: const ProfileDetailPage()),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.notifications,
              title: "NOTIFICATIONS",
              onTap: () {
                Navigator.push(
                  context,
                  BottomToTopRoute(page: const NotificationPage()),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.message,
              title: "MESSAGE",
              onTap: () {
                Navigator.push(
                  context,
                  BottomToTopRoute(page: const MessagesPage()),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.widgets,
              title: "ELEMENTS",
              onTap: () {
                Navigator.push(
                  context,
                  BottomToTopRoute(page: const ElementsPage()),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.color_lens,
              title: "COLOR SKINS",
              onTap: () {
                Navigator.push(
                  context,
                  BottomToTopRoute(page: const ColorSkinsPage()),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.logout,
              title: "LOGOUT",
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: 4,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoriesPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistPage()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
      ),
    );
  }
}

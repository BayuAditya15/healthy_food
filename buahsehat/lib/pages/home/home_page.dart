import 'package:flutter/material.dart';
import '../../widgets/header.dart';
import '../../widgets/banner.dart';
import '../../widgets/category.dart';
import '../../widgets/trending.dart';
import '../../widgets/bottom_nav.dart';
import '../cart/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final List<Widget> pages = [
      // ================= HOME =================
      SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 20),
            Header(),
            SizedBox(height: 20),
            BannerSection(),
            SizedBox(height: 20),
            Category(),
            SizedBox(height: 20),
            Trending(),
          ],
        ),
      ),

      // ================= CATEGORIES / TRANSAKSI =================
      Center(
        child: Text(
          "Halaman Transaksi",
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
      ),

      // ================= CART =================
      const CartPage(),

      // ================= WISHLIST =================
      Center(
        child: Text(
          "Halaman Favorit",
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
      ),

      // ================= PROFILE =================
      Center(
        child: Text(
          "Halaman Profil",
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

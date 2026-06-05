import 'package:flutter/material.dart';
import '../pages/category/categories_page.dart';
import '../pages/wishlist/wishlist_page.dart';
import '../pages/cart/cart_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/home/home_page.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required int currentIndex,
    required void Function(int index) onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        if (index == 1) {
          // Swap icon → Categories Page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CategoriesPage()),
          );
        } else if (index == 2) {
          // Cart icon → Cart Page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        } else if (index == 3) {
          // Heart/Love icon → Wishlist Page
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
          // Home icon → Home Page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
      ],
    );
  }
}

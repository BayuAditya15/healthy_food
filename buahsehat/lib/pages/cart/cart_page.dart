import 'package:flutter/material.dart';
import '../../widgets/product_item.dart';
import '../../widgets/bottom_nav.dart';
import '../category/categories_page.dart';
import '../../pages/wishlist/wishlist_page.dart';
import '../../pages/home/home_page.dart';
import '../../services/cart_service.dart';
import '../../models/cart_item_model.dart';
import '../checkout/checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      /// ================= BODY =================
      body: SafeArea(
        child: Column(
          children: [
            /// ================= HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Shopping Cart",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            /// ================= LIST =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ValueListenableBuilder<List<CartItemModel>>(
                  valueListenable: CartService.items,
                  builder: (context, items, _) {
                    if (items.isEmpty) {
                      return const Center(child: Text('Keranjang kosong'));
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return ProductItem(
                          id: item.productId,
                          name: item.name,
                          price: item.price,
                          qty: item.quantity,
                          image: item.image,
                          description: item.description,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      /// ================= FOOTER =================
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// CHECKOUT BUTTON
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CheckoutPage()),
                  );
                },
                child: const Text(
                  'CHECKOUT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          /// BOTTOM NAV
          BottomNav(
            currentIndex: 2,
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CategoriesPage()),
                );
              } else if (index == 2) {
                return;
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WishlistPage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

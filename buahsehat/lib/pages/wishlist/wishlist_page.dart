import 'package:flutter/material.dart';
import '../product/product_detail_page.dart';
import '../../services/wishlist_service.dart';
import '../../models/wishlist_item_model.dart';
import '../../widgets/product_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<List<WishlistItemModel>>(
          valueListenable: WishlistService.items,
          builder: (context, items, _) {
            if (items.isEmpty)
              return const Center(child: Text('Wishlist kosong'));

            return GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = items[index];

                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            id: item.productId,
                            name: item.name,
                            price: item.price,
                            image: item.image,
                            description: item.description,
                          ),
                        ),
                      );
                    },
                    child: ProductCard(
                      id: item.productId,
                      title: item.name,
                      price: 'Rp ${item.price}',
                      image: item.image,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

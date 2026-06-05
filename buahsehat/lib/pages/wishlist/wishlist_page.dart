import 'package:flutter/material.dart';
import '../product/product_detail_page.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> wishlist = [
      {
        'name': 'Avocado',
        'price': '\$6.7',
        'image': 'assets/images/alpukat.png',
        'description':
            "Avocad premium ini dipanen pada tingkat kematangan yang optimal untuk memastikan tekstur daging buah yang lembut, pulen, dan cita rasa manis yang legit di lidah. Sebagai salah satu sumber kalium dan energi instan terbaik, pisang ini menjadi pilihan favorit bagi mereka yang memiliki gaya hidup aktif karena kepraktisannya untuk dikonsumsi kapan saja dan di mana saja. Selain lezat dinikmati secara langsung, pisang ini juga sangat ideal diolah menjadi berbagai menu sarapan bernutrisi seperti smoothie, oatmeal, hingga bahan dasar kue yang memberikan aroma harum alami.",
      },
      {
        'name': 'Broccoli',
        'price': '\$8.7',
        'image': 'assets/images/brokoli.png',
        'description': 'Fresh and juicy tomatoes, perfect for salads and cooking.',},
      {
        'name': 'Tomatoes',
        'price': '\$4.9',
        'image': 'assets/images/tomat.png',
        'description': 'Fresh and juicy grapes, perfect for snacking or making wine.',
      },
      {
        'name': 'Grapes',
        'price': '\$7.2',
        'image': 'assets/images/anggur.png',
          'description': 'A stylish denim jacket perfect for casual outings.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist"), centerTitle: true),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wishlist.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final item = wishlist[index];

          return MouseRegion(
            cursor: SystemMouseCursors.click, // 🔥 cursor jadi tangan
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      name: item['name'] ?? '',
                      price:
                          double.tryParse(
                            (item['price'] ?? '0').replaceAll('\$', ''),
                          ) ??
                          0.0,
                      image: item['image'] ?? '',
                      description: item['description'] ?? '',
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    /// IMAGE
                    Positioned.fill(
                      child: Image.asset(
                        item['image'] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
                      ),
                    ),

                    /// OVERLAY
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),

                    /// TEXT
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item['price'] ?? '',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    /// FAVORITE ICON
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(Icons.favorite, color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

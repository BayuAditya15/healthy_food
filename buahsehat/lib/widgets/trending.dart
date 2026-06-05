import 'package:flutter/material.dart';
import 'product_card.dart';
import '../pages/category/category_page.dart';

class Trending extends StatelessWidget {
  const Trending({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        "title": "Avocado",
        "price": "\$6.7",
        "img": "assets/images/alpukat.png",
      },
      {
        "title": "Broccoli",
        "price": "\$8.7",
        "img": "assets/images/brokoli.png",
      },
      {"title": "Tomatoes", "price": "\$4.9", "img": "assets/images/tomat.png"},
      {"title": "Grapes", "price": "\$7.2", "img": "assets/images/anggur.png"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoryPage(),
                    ),
                  );
                },

                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,

                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending Deals",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.green),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, i) {
              final p = products[i];
              return ProductCard(
                title: p['title']!,
                price: p['price']!,
                image: p['img']!,
              );
            },
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoryPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "LOAD MORE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

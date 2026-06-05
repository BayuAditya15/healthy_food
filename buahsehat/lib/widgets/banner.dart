import 'package:flutter/material.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  static const List<Map<String, String>> _banners = [
    {
      'title': 'Recommended Recipe Today',
      'imagePath': 'assets/images/banner1.jpg',
    },
    {
      'title': 'Fresh Fruits Delivery',
      'imagePath': 'assets/images/banner2.jpg',
    },
    {
      'title': 'Recommended Recipe Today',
      'imagePath': 'assets/images/banner1.jpg',
    },
    {
      'title': 'Fresh Fruits Delivery',
      'imagePath': 'assets/images/banner2.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _banners
            .map(
              (banner) => _bannerCard(banner['title']!, banner['imagePath']!),
            )
            .toList(),
      ),
    );
  }

  Widget _bannerCard(String title, String imagePath) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            // ignore: deprecated_member_use
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

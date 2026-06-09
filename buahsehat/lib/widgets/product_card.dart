import 'package:flutter/material.dart';
import '../../pages/product/product_detail_page.dart';
import '../models/wishlist_item_model.dart';
import '../services/wishlist_service.dart';

class ProductCard extends StatefulWidget {
  final int id;
  final String title;
  final String price;
  final String image;

  const ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _syncFavoriteState();
  }

  Future<void> _syncFavoriteState() async {
    final favorite = await WishlistService.isInWishlistById(widget.id);
    if (!mounted) return;
    setState(() {
      isFavorite = favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // 👉 cursor jadi tangan
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            final parsedPrice =
                double.tryParse(
                  widget.price.replaceAll(RegExp(r'[^0-9.]'), ''),
                ) ??
                0.0;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  id: widget.id,
                  name: widget.title,
                  price: parsedPrice,
                  image: widget.image,
                  description: '',
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
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),

                /// GRADIENT
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),

                /// FAVORITE BUTTON
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: () async {
                      await WishlistService.toggleItem(
                        WishlistItemModel(
                          productId: widget.id,
                          name: widget.title,
                          price:
                              double.tryParse(
                                widget.price.replaceAll(RegExp(r'[^0-9.]'), ''),
                              ) ??
                              0.0,
                          image: widget.image,
                          description: '',
                          category: '',
                        ),
                      );

                      if (!mounted) return;
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 24,
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
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.price,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

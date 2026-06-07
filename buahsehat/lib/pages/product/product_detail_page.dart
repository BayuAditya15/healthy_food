import 'package:flutter/material.dart';
import '../../widgets/quantity_selector.dart';
import '../../widgets/rating_section.dart';
import '../../widgets/tab_section.dart';
import '../../widgets/review_item.dart';
import '../../pages/cart/cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final String name;
  final double price;
  final String image;
  final String description;
  final String category;

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    this.category = "FRUITS",
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int qty = 1;
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ================= IMAGE =================
            Stack(
              children: [
                Image.network(
                  widget.image,
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 280,
                    color: isDark ? const Color(0xFF2A2A2A) : Colors.grey[300],
                    child: const Icon(Icons.image, size: 50),
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: circleIcon(Icons.arrow_back),
                  ),
                ),

                Positioned(top: 40, right: 16, child: circleIcon(Icons.share)),
              ],
            ),

            // ================= CONTENT =================
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardColor, // 🔥 support dark mode
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category.toUpperCase(),
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      widget.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // PRICE + QTY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${widget.price.toStringAsFixed(1)}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: QuantitySelector(
                            qty: qty,
                            onChanged: (val) {
                              setState(() {
                                qty = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const RatingSection(),

                    const SizedBox(height: 15),

                    // ================= TAB =================
                    TabSection(
                      selectedTab: selectedTab,
                      onTap: (i) {
                        setState(() {
                          selectedTab = i;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    // ================= CONTENT =================
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (selectedTab == 0)
                              Text(
                                widget.description,
                                style: TextStyle(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),

                            if (selectedTab == 1) ...[
                              const ReviewItem(
                                name: "James Logan",
                                date: "27 August 2020",
                                comment:
                                    "mantap banget, rasanya enak dan segar. Recommended!",
                                rating: 4,
                                image: 'assets/images/rv1.png',
                              ),
                              const ReviewItem(
                                name: "Leo Tucker",
                                date: "15 June 2020",
                                comment:
                                    "ga bosen dimakan, apalagi pas panas. Seger banget!",
                                rating: 5,
                                image: 'assets/images/rv2.png',
                              ),
                            ],

                            if (selectedTab == 2)
                              const Text(
                                "Belum ada diskusi.",
                                style: TextStyle(color: Colors.grey),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ================= BUTTON =================
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFFFF4D8D)
                                : Colors.pink,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartPage(),
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                "ADD TO CART \$${(widget.price * qty).toStringAsFixed(1)}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

import 'package:flutter/material.dart';
import '../pages/product/product_detail_page.dart';
import 'quantity_selector.dart';

class ProductItem extends StatefulWidget {
  final int id;
  final String name;
  final double price;
  final int qty;
  final String image;
  final String description;

  const ProductItem({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.image,
    required this.description,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late int qty;

  @override
  void initState() {
    super.initState();
    qty = widget.qty;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardColor = theme.cardColor;
    final textColor = colorScheme.onSurface;
    final total = qty * widget.price;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              id: widget.id,
              name: widget.name,
              price: widget.price,
              image: widget.image,
              description: widget.description,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            /// ================= IMAGE =================
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildImage(context, widget.image),
            ),

            const SizedBox(width: 12),

            /// ================= TEXT =================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "\$${total.toStringAsFixed(1)}",
                    style: const TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ],
              ),
            ),

            /// ================= QTY =================
            QuantitySelector(
              qty: qty,
              onChanged: (val) {
                if (val < 1) return; // guard biar nggak minus
                setState(() {
                  qty = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ================= IMAGE HANDLER =================
  Widget _buildImage(BuildContext context, String image) {
    final isNetwork = image.startsWith('http');
    final placeholderColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFEFEFEF);

    final placeholder = Container(
      width: 60,
      height: 60,
      color: placeholderColor,
      child: const Icon(Icons.image, size: 20),
    );

    if (isNetwork) {
      return Image.network(
        image,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return placeholder;
        },
        errorBuilder: (context, error, stackTrace) => placeholder,
      );
    } else {
      return Image.asset(
        image,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => placeholder,
      );
    }
  }
}

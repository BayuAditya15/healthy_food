import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final String date;
  final String comment;
  final double rating;
  final String image;

  const ReviewItem({
    super.key,
    required this.name,
    required this.date,
    required this.comment,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = image.startsWith('http');

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= AVATAR =================
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[200],
            backgroundImage: isNetwork
                ? NetworkImage(image)
                : AssetImage(image) as ImageProvider,
          ),

          const SizedBox(width: 10),

          /// ================= CONTENT =================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),

                Text(date, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 5),

                Text(comment, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 5),

                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 16,
                      color: index < rating ? Colors.orange : Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

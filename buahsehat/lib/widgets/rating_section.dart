import 'package:flutter/material.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 18),
        const SizedBox(width: 4),
        const Text("4.5"),
        const Text(" (128 reviews)", style: TextStyle(color: Colors.grey)),

        const Spacer(),

        /// ================= AVATAR LIST =================
        Row(
          children: const [
            _AvatarImage(image: "assets/images/rt1.png"),
            SizedBox(width: 4),
            _AvatarImage(image: "assets/images/rt2.png"),
            _AvatarImage(image: "assets/images/rt3.png"),
          ],
        ),
      ],
    );
  }
}

/// ================= REUSABLE AVATAR =================
class _AvatarImage extends StatelessWidget {
  final String image;

  const _AvatarImage({required this.image});

  @override
  Widget build(BuildContext context) {
    final isNetwork = image.startsWith('http');

    return CircleAvatar(
      radius: 12,
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: Image(
          image: isNetwork
              ? NetworkImage(image)
              : AssetImage(image) as ImageProvider,
          width: 24,
          height: 24,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, size: 16);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../themes/theme_controller.dart';
import '../pages/message/chat_detail_page.dart';
import '../widgets/bottom_to_top_route.dart';

class MessageItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String imageUrl;
  final bool isRead;

  const MessageItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.isDark,
      builder: (context, isDark, _) {
        return ValueListenableBuilder(
          valueListenable: ThemeController.primaryColor,
          builder: (context, primaryColor, _) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  BottomToTopRoute(
                    page: ChatDetailPage(
                      name: name,
                      imageUrl: imageUrl,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // 🔥 FOTO PROFIL
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(imageUrl),
                        ),
                        const SizedBox(width: 12),
                        // 🔹 TEXT & TIME (EXPANDED)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                time,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? Colors.grey[700] : Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 🔹 STATUS DI SEBELAH KANAN
                        Text(
                          isRead ? "Read ✓" : "Pending ✓",
                          style: TextStyle(
                            fontSize: 12,
                            color: isRead ? primaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Divider
                    Divider(
                      height: 1,
                      color: isDark ? Colors.grey[800] : Colors.grey[300],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
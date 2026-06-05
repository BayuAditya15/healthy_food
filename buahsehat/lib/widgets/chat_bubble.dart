import 'package:flutter/material.dart';
import '../../themes/theme_controller.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String? imageUrl;
  final String? senderName;
  final String? imagePath;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.imageUrl,
    this.senderName,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.isDark,
      builder: (context, isDark, _) {
        return ValueListenableBuilder(
          valueListenable: ThemeController.primaryColor,
          builder: (context, primaryColor, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // 🔹 Nama pengirim (kiri)
                  if (!isMe && senderName != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 50, bottom: 4),
                      child: Text(
                        senderName!,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[500] : Colors.grey,
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // 🔥 FOTO PROFIL
                      if (!isMe)
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(imageUrl!),
                        ),
                      const SizedBox(width: 8),
                      // 🔹 Bubble Chat
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        constraints: const BoxConstraints(maxWidth: 250),
                        decoration: BoxDecoration(
                          color: isMe
                              ? primaryColor
                              : (isDark
                                  ? Colors.grey[700]
                                  : Colors.grey[400]),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(18),
                            topRight: const Radius.circular(18),
                            bottomLeft: isMe
                                ? const Radius.circular(18)
                                : const Radius.circular(0),
                            bottomRight: isMe
                                ? const Radius.circular(0)
                                : const Radius.circular(18),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (imagePath != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    imagePath!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            Text(
                              message,
                              style: TextStyle(
                                color: isMe
                                    ? Colors.white
                                    : (isDark
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
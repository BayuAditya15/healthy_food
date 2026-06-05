import 'package:flutter/material.dart';
import '../../themes/theme_controller.dart';
import '../../widgets/chat_bubble.dart';

class ChatDetailPage extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ChatDetailPage({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.isDark,
      builder: (context, isDark, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Text(
              "Messages",
              style: TextStyle(
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: isDark ? Colors.white : Colors.black,
            ),
            elevation: 0,
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              // 🔹 CHAT LIST (SCROLL)
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Center(
                      child: Text(
                        "Sunday, Feb 9, 12:58",
                        style: TextStyle(
                          color: isDark ? Colors.grey[600] : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 🔹 KAMU (KANAN)
                    const ChatBubble(message: "Hi, Kate", isMe: true),
                    const ChatBubble(message: "How are you?", isMe: true),
                    const SizedBox(height: 10),
                    // 🔹 KATE
                    ChatBubble(
                      message: "Hi, I am good!",
                      isMe: false,
                      imageUrl: "assets/images/foto 1.jpg",
                      senderName: "Kate",
                    ),
                    const SizedBox(height: 10),
                    // 🔹 BLUE NINJA
                    ChatBubble(
                      message:
                          "Hi there, I am also fine, thanks! And how are you?",
                      isMe: false,
                      imageUrl: "assets/images/foto 2.jpg",
                      senderName: "Blue Ninja",
                    ),
                    const SizedBox(height: 10),
                    // 🔹 KAMU
                    const ChatBubble(
                      message: "Hey, Blue Ninja! Glad to see you :)",
                      isMe: true,
                    ),
                    const ChatBubble(
                      message: "Hey, look, cutest kitten ever!",
                      isMe: true,
                    ),
                    const SizedBox(height: 10),
                    ChatBubble(
                      message: "Nice!",
                      isMe: false,
                      imageUrl: "assets/images/foto 1.jpg",
                      senderName: "Kate",
                    ),
                    const SizedBox(height: 10),
                    const ChatBubble(
                      message: "Like it very much!",
                      isMe: true,
                      imagePath: "assets/images/kucing.jpg",
                    ),
                    const SizedBox(height: 10),
                    ChatBubble(
                      message: "Awesome!",
                      isMe: false,
                      imageUrl: "assets/images/foto 2.jpg",
                      senderName: "Blue Ninja",
                    ),
                  ],
                ),
              ),
              // 🔹 INPUT MESSAGE
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                color: isDark ? const Color(0xFF1a1a1a) : Colors.white,
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: isDark ? Colors.grey[400] : Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(
                            color: isDark ? Colors.grey[600] : Colors.grey[400],
                          ),
                          filled: true,
                          fillColor: isDark
                              ? Colors.grey[900]
                              : Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.send,
                      color: isDark ? Colors.grey[400] : Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../../themes/theme_controller.dart';
import '../../widgets/messages_item.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.isDark,
      builder: (context, isDark, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,
            title: Text(
              "Messages",
              style: TextStyle(
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
              ),
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 🔍 SEARCH BAR
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFFE8E8E8) : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: isDark ? Colors.grey[600] : Colors.grey[500],
                      ),
                      hintText: "Search job here...",
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey[500] : Colors.grey[400],
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    style: TextStyle(
                      color: isDark ? Colors.black87 : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 🔥 LIST CHAT (SCROLL)
                Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      final List<String> names = [
                        "Sam Verdinand",
                        "Freddie Ronan",
                        "Ethan Jacoby",
                        "Alfie Mason",
                        "Archie Parker",
                        "Maya Johnson",
                        "Lucas Brown",
                        "Emma Davis",
                        "Oliver Wilson",
                        "Sophia Anderson",
                        "Liam Martinez",
                        "Ava Taylor",
                        "Noah Thomas",
                        "Isabella Garcia",
                        "Elijah Lee"
                      ];
                      
                      final List<String> messages = [
                        "OK. Lorem ipsum dolor sect...",
                        "Roger that sir, thankyou",
                        "Lorem ipsum dolor",
                        "Thanks for the update",
                        "See you tomorrow",
                        "Perfect, let's meet soon",
                        "Got it, will do",
                        "Sounds good to me",
                        "Let me check that",
                        "No problem at all",
                        "That works perfectly",
                        "Looking forward to it",
                        "Absolutely, count me in",
                        "Thanks for letting me know",
                        "Appreciate your help"
                      ];
                      
                      final List<String> profileImages = [
                        "assets/images/foto 1.jpg",
                        "assets/images/foto 2.jpg",
                        "assets/images/foto 3.jpg",
                        "assets/images/foto 4.jpg",
                        "assets/images/foto 5.jpg",
                        "assets/images/foto 6.jpg",
                        "assets/images/foto 7.jpg",
                        "assets/images/foto 8.jpg",
                        "assets/images/foto 9.jpg",
                        "assets/images/foto 10.jpg",
                        "assets/images/foto 11.jpg",
                        "assets/images/foto 12.jpg",
                        "assets/images/foto 13.jpg",
                        "assets/images/foto 14.jpg",
                        "assets/images/foto 15.jpg",
                      ];
                      
                      return MessageItem(
                        name: names[index],
                        message: messages[index],
                        time: "2m ago",
                        imageUrl: profileImages[index],
                        isRead: index % 2 == 0,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
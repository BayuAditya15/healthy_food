import 'package:flutter/material.dart';
import 'category_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final List<Map<String, dynamic>> categories = [
      {'name': 'Fruits', 'items': '87 Items', 'icon': Icons.grain},
      {'name': 'Vegetables', 'items': '24 Items', 'icon': Icons.eco},
      {'name': 'Mushroom', 'items': '43 Items', 'icon': Icons.emoji_nature},
      {'name': 'Dairy', 'items': '22 Items', 'icon': Icons.local_drink},
      {'name': 'Oats', 'items': '64 Items', 'icon': Icons.rice_bowl},
      {'name': 'Bread', 'items': '43 Items', 'icon': Icons.bakery_dining},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: Text(
          'Categories',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ================= BODY =================
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CategoryPage(),
                  settings: RouteSettings(
                    arguments: {'name': item['name'], 'items': item['items']},
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 90,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                /// 🔥 GRADIENT DINAMIS (ikut primary color)
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      theme.brightness == Brightness.dark ? 0.3 : 0.1,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// ================= TEXT =================
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['items'],
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),

                  /// ================= ICON =================
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item['icon'], color: Colors.white, size: 26),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

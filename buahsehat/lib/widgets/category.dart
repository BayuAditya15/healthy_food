import 'package:flutter/material.dart';
import '../pages/category/category_page.dart';
import '../pages/category/categories_page.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedIndex = 0;

  final icons = [
    Icons.apple,
    Icons.eco,
    Icons.restaurant_menu,
    Icons.lunch_dining,
    Icons.bakery_dining,
    Icons.local_dining,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoryPage(),
                    ),
                  );
                },

                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,

                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.green),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: icons.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoriesPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: selectedIndex == i
                              ? Colors.green
                              : theme.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.green.withOpacity(0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(
                                theme.brightness == Brightness.dark
                                    ? 0.3
                                    : 0.05,
                              ),
                            ),
                          ],
                        ),
                        child: Icon(
                          icons[i],
                          color: selectedIndex == i
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';
import '../pages/category/categories_page.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedIndex = 0;

 Future<List<CategoryModel>>? categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = CategoryService.getCategories();
  }

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
                      builder: (context) => const CategoriesPage(),
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
            child: FutureBuilder<List<CategoryModel>>(
              future: categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Gagal memuat kategori'));
                }

                final categories = snapshot.data ?? [];

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, i) {
                    final category = categories[i];

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            selectedIndex = i;
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CategoriesPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selectedIndex == i
                                ? Colors.green
                                : theme.cardColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.green.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            category.name,
                            style: TextStyle(
                              color: selectedIndex == i
                                  ? Colors.white
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

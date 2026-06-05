import 'package:flutter/material.dart';
import 'categories_page.dart';
import '../product/product_detail_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String searchQuery = '';

  List<Map<String, dynamic>> products = [
    {
      'name': 'Avocado',
      'price': '\$6.7',
      'image': 'assets/images/alpukat.png',
      'isFavorite': false,
    },
    {
      'name': 'Broccoli',
      'price': '\$8.7',
      'image': 'assets/images/brokoli.png',
      'isFavorite': false,
    },
    {
      'name': 'Tomatoes',
      'price': '\$4.9',
      'image': 'assets/images/tomat.png',
      'isFavorite': false,
    },
    {
      'name': 'Grapes',
      'price': '\$7.2',
      'image': 'assets/images/anggur.png',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final String categoryName = args?['name'] ?? 'fruits';
    final String totalItems = args?['items'] ?? '87 items';

    final filteredProducts = products.where((product) {
      return product['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= HEADER =================
            Container(
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ICONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CategoriesPage(),
                            ),
                          );
                        },
                        child: const Icon(Icons.tune, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    '$categoryName Category',
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    totalItems,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),

            /// ================= SEARCH =================
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                style: TextStyle(color: colorScheme.onSurface),

                decoration: InputDecoration(
                  hintText: 'Search here',
                  hintStyle: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),

                  prefixIcon: Icon(Icons.search, color: colorScheme.onSurface),

                  filled: true,
                  fillColor: colorScheme.surfaceVariant,

                  contentPadding: const EdgeInsets.symmetric(vertical: 0),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            /// ================= GRID =================
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return GestureDetector(
                  onTap: () {
                    final parsedPrice =
                        double.tryParse(
                          (product['price'] as String).replaceAll(
                            RegExp(r'[^0-9.]'),
                            '',
                          ),
                        ) ??
                        0.0;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(
                          name: product['name'] as String,
                          price: parsedPrice,
                          image: product['image'] as String,
                          description: '          Avocad premium ini dipanen pada tingkat kematangan yang optimal untuk memastikan tekstur daging buah yang lembut, pulen, dan cita rasa manis yang legit di lidah. Sebagai salah satu sumber kalium dan energi instan terbaik, pisang ini menjadi pilihan favorit bagi mereka yang memiliki gaya hidup aktif karena kepraktisannya untuk dikonsumsi kapan saja dan di mana saja. Selain lezat dinikmati secara langsung, pisang ini juga sangat ideal diolah menjadi berbagai menu sarapan bernutrisi seperti smoothie, oatmeal, hingga bahan dasar kue yang memberikan aroma harum alami.,',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(product['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        /// OVERLAY
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),

                        /// FAVORITE
                        Positioned(
                          top: 10,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                product['isFavorite'] = !product['isFavorite'];
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              color: product['isFavorite']
                                  ? Colors.pink
                                  : Colors.white,
                            ),
                          ),
                        ),

                        /// TEXT
                        Positioned(
                          bottom: 15,
                          left: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: textTheme.titleSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                product['price'],
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

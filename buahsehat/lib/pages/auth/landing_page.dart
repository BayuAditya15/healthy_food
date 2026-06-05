import 'package:flutter/material.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _controller = PageController();

  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {'title': 'Welcome to Kede!', 'subtitle': 'Your Grocery Application'},
    {'title': 'Fresh Products', 'subtitle': 'Get fresh groceries anytime'},
    {'title': 'Fast Delivery', 'subtitle': 'Delivered to your home quickly'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            /// ================= PAGE VIEW =================
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,

                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Spacer(),

                        /// ================= LOGO =================
                        Container(
                          width: 120,
                          height: 120,

                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(28),
                          ),

                          child: const Icon(
                            Icons.storefront_rounded,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// ================= TITLE =================
                        Text(
                          pages[index]['title']!,
                          textAlign: TextAlign.center,

                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// ================= SUBTITLE =================
                        Text(
                          pages[index]['subtitle']!,
                          textAlign: TextAlign.center,

                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// ================= DOT INDICATOR =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(
                pages.length,

                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),

                  margin: const EdgeInsets.symmetric(horizontal: 4),

                  width: currentPage == index ? 24 : 8,
                  height: 6,

                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? colorScheme.primary
                        : colorScheme.outline.withOpacity(0.3),

                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            /// ================= BUTTON =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),

              child: SizedBox(
                width: double.infinity,
                height: 56,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: const Text(
                    'GET STARTED',

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

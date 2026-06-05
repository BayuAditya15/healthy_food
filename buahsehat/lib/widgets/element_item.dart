import 'package:flutter/material.dart';
import '../../themes/theme_controller.dart';

class ElementItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const ElementItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.isDark,
      builder: (context, isDark, _) {
        return ValueListenableBuilder(
          valueListenable: ThemeController.primaryColor,
          builder: (context, primaryColor, _) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        // BOX ICON KOTAK (seperti gambar referensi)
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // NAMA KOMPONEN
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                        // ICON PANAH KE KANAN
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF2a2a2a) : const Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: isDark ? Colors.grey[600] : const Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/notification/notification_page.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          /// ================= TEXT =================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Good Morning",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Samuel Witwicky",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          /// ================= NOTIFICATION =================
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
                },

                /// 👉 pakai warna theme
                hoverColor: colorScheme.primary.withOpacity(0.1),
                splashColor: colorScheme.primary.withOpacity(0.2),
                highlightColor: Colors.transparent,

                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Stack(
                    children: [
                      /// ICON
                      Icon(
                        Icons.notifications_none,
                        color: colorScheme.onBackground,
                        size: 24,
                      ),

                      /// DOT NOTIFICATION
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

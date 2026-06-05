import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,

      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.onBackground.withOpacity(0.5),
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ),

      title: Text(
        "User",
        style: TextStyle(
          color: theme.colorScheme.onBackground,
          fontWeight: FontWeight.w600,
        ),
      ),

      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
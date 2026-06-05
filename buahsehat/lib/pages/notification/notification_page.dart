import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: colorScheme.onBackground,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),

        title: Text(
          'Notifications',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      // ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: const [
          NotificationCard(
            title: 'Apply Success',
            description: 'You has apply a job in Queenify Group as UI Designer',
            time: '10h ago',
            dotColor: Color(0xFF2DD4BF),
          ),
          NotificationCard(
            title: 'Interview Calls',
            description: 'Congratulations! You have interview calls',
            time: '9h ago',
          ),
          NotificationCard(
            title: 'Apply Success',
            description: 'You has apply a job in Queenify Group as UI Designer',
            time: '8h ago',
            dotColor: Color(0xFF4ADE80),
          ),
          NotificationCard(
            title: 'Complete your profile',
            description:
                'Please verify your profile information to continue using this app',
            time: '7h ago',
            dotColor: Color(0xFF2DD4BF),
          ),
        ],
      ),
    );
  }
}

// ================= CARD =================
class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final Color? dotColor;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              theme.brightness == Brightness.dark ? 0.3 : 0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= TITLE =================
          Row(
            children: [
              if (dotColor != null) ...[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: dotColor ?? colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// ================= DESCRIPTION =================
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.7),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          /// ================= FOOTER =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// TIME
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    time,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),

              /// MARK AS READ
              GestureDetector(
                onTap: () {
                  // TODO: action
                },
                child: Text(
                  'Mark as read',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

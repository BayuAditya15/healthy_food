import 'package:flutter/material.dart';
import '../../themes/theme_controller.dart';

class ColorSkinsPage extends StatefulWidget {
  const ColorSkinsPage({super.key});

  @override
  State<ColorSkinsPage> createState() => _ColorSkinsPageState();
}

class _ColorSkinsPageState extends State<ColorSkinsPage> {
  late TextEditingController _hexController;

  final List<Map<String, dynamic>> colorThemes = [
    {'name': 'Red', 'color': const Color(0xFFD32F2F)},
    {'name': 'Green', 'color': const Color(0xFF388E3C)},
    {'name': 'Blue', 'color': const Color(0xFF1976D2)},
    {'name': 'Pink', 'color': const Color(0xFFC2185B)},
    {'name': 'Yellow', 'color': const Color(0xFFFBC02D)},
    {'name': 'Orange', 'color': const Color(0xFFF57C00)},
    {'name': 'Purple', 'color': const Color(0xFF7B1FA2)},
    {'name': 'DeepPurple', 'color': const Color(0xFF512DA8)},
    {'name': 'LightBlue', 'color': const Color(0xFF0288D1)},
    {'name': 'Teal', 'color': const Color(0xFF00796B)},
    {'name': 'Lime', 'color': const Color(0xFFC0CA33)},
    {'name': 'DeepOrange', 'color': const Color(0xFFE64A19)},
  ];

  @override
  void initState() {
    super.initState();
    _hexController = TextEditingController(
      text: ThemeController.primaryColor.value.value
          .toRadixString(16)
          .toUpperCase()
          .padLeft(8, '0'),
    );
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  void _updateThemeColor(Color color) {
    ThemeController.primaryColor.value = color;
    _hexController.text =
        color.value.toRadixString(16).toUpperCase().padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return ValueListenableBuilder(
      valueListenable: ThemeController.isDark,
      builder: (context, isDark, _) {
        return ValueListenableBuilder(
          valueListenable: ThemeController.primaryColor,
          builder: (context, primaryColor, _) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "Color Themes",
                  style: textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Center(
                      child: Text(
                        "Link",
                        style: textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),

              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [

                  /// TITLE
                  Text(
                    "Color Themes",
                    style: textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  /// LAYOUT THEME
                  Text(
                    "Layout Themes",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Light and Dark mode available:",
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [

                            /// LIGHT
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    ThemeController.isDark.value = false,
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: !isDark
                                          ? colorScheme.primary
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: !isDark
                                      ? Icon(Icons.check_circle,
                                          color: colorScheme.primary)
                                      : null,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// DARK
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    ThemeController.isDark.value = true,
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isDark
                                          ? colorScheme.primary
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: isDark
                                      ? Icon(Icons.check_circle,
                                          color: colorScheme.primary)
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// DEFAULT COLOR
                  Text(
                    "Default Color Themes",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [

                        Text(
                          "Choose your favorite color:",
                          style: textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 16),

                        Column(
                          children: [
                            for (int i = 0; i < colorThemes.length; i += 3)
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  children: [
                                    for (int j = 0; j < 3; j++)
                                      if (i + j < colorThemes.length)
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(horizontal: 4),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  _updateThemeColor(
                                                      colorThemes[i + j]['color']),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  color:
                                                      colorThemes[i + j]['color'],
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: primaryColor ==
                                                          colorThemes[i + j]['color']
                                                      ? Border.all(
                                                          color: Colors.white,
                                                          width: 3)
                                                      : null,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    colorThemes[i + j]['name'],
                                                    style: textTheme.bodySmall?.copyWith(
                                                      color: colorThemes[i + j]['color']
                                                                  .computeLuminance() >
                                                              0.5
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      else
                                        const Expanded(child: SizedBox()),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// CUSTOM COLOR
                  Text(
                    "Custom Color",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [

                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: TextField(
                            controller: _hexController,
                            onChanged: (value) {
                              try {
                                final hex = value.replaceAll('#', '');
                                final color =
                                    Color(int.parse('FF$hex', radix: 16));
                                _updateThemeColor(color);
                              } catch (_) {}
                            },
                            decoration: InputDecoration(
                              hintText: "#cddc39",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _NavItem(icon: Icons.mail_outline, label: "Inbox"),
                    _NavItem(icon: Icons.calendar_today, label: "Calendar"),
                    _NavItem(icon: Icons.cloud_upload, label: "Upload"),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// COMPONENT NAV ITEM (BIAR CLEAN)
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
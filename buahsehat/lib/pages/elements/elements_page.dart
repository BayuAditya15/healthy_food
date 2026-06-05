import 'package:flutter/material.dart';
import '../../themes/theme_controller.dart';
import '../../widgets/element_item.dart';

class ElementsPage extends StatefulWidget {
  const ElementsPage({super.key});

  @override
  State<ElementsPage> createState() => _ElementsPageState();
}

class _ElementsPageState extends State<ElementsPage> {
  // SEMUA KOMPONEN DENGAN ICON YANG SESUAI REFERENSI
  final List<ComponentItem> allComponents = [
    // DARI GAMBAR 1 (Framework7 - Components)
    ComponentItem(name: 'Accordion', icon: Icons.dashboard),
    ComponentItem(name: 'Action Sheet', icon: Icons.dashboard),
    ComponentItem(name: 'Appbar', icon: Icons.dashboard),
    ComponentItem(name: 'Autocomplete', icon: Icons.dashboard),
    ComponentItem(name: 'Badge', icon: Icons.dashboard),
    ComponentItem(name: 'Buttons', icon: Icons.dashboard),
    ComponentItem(name: 'Calendar / Date Picker', icon: Icons.dashboard),
    ComponentItem(name: 'Cards', icon: Icons.dashboard),
    ComponentItem(name: 'Cards Expandable', icon: Icons.dashboard),
    ComponentItem(name: 'Checkbox', icon: Icons.dashboard),
    
    // DARI GAMBAR 2
    ComponentItem(name: 'Chips / Tags', icon: Icons.dashboard),
    ComponentItem(name: 'Color Picker', icon: Icons.dashboard),
    ComponentItem(name: 'Contacts List', icon: Icons.dashboard),
    ComponentItem(name: 'Content Block', icon: Icons.dashboard),
    ComponentItem(name: 'Data Table', icon: Icons.dashboard),
    ComponentItem(name: 'Dialog', icon: Icons.dashboard),
    ComponentItem(name: 'Elevation', icon: Icons.dashboard),
    ComponentItem(name: 'FAB', icon: Icons.dashboard),
    ComponentItem(name: 'FAB Morph', icon: Icons.dashboard),
    ComponentItem(name: 'Form Storage', icon: Icons.dashboard),
    ComponentItem(name: 'Gauge', icon: Icons.dashboard),
    ComponentItem(name: 'Grid / Layout Grid', icon: Icons.dashboard),
    ComponentItem(name: 'Icons', icon: Icons.dashboard),
    
    // DARI GAMBAR 3
    ComponentItem(name: 'Picker', icon: Icons.dashboard),
    ComponentItem(name: 'Popover', icon: Icons.dashboard),
    ComponentItem(name: 'Popup', icon: Icons.dashboard),
    ComponentItem(name: 'Preloader', icon: Icons.dashboard),
    ComponentItem(name: 'Progress Bar', icon: Icons.dashboard),
    ComponentItem(name: 'Pull To Refresh', icon: Icons.dashboard),
    ComponentItem(name: 'Radio', icon: Icons.dashboard),
    ComponentItem(name: 'Range Slider', icon: Icons.dashboard),
    ComponentItem(name: 'Searchbar', icon: Icons.dashboard),
    ComponentItem(name: 'Searchbar Expandable', icon: Icons.dashboard),
    ComponentItem(name: 'Sheet Modal', icon: Icons.dashboard),
    ComponentItem(name: 'Skeleton (Ghost) Layouts', icon: Icons.dashboard),
    ComponentItem(name: 'Smart Select', icon: Icons.dashboard),
    ComponentItem(name: 'Sortable List', icon: Icons.dashboard),
    
    // DARI GAMBAR 4
    ComponentItem(name: 'Subnavbar', icon: Icons.dashboard),
    ComponentItem(name: 'Swipeout (Swipe To Delete)', icon: Icons.dashboard),
    ComponentItem(name: 'Swiper Slider', icon: Icons.dashboard),
    ComponentItem(name: 'Tabs', icon: Icons.dashboard),
    ComponentItem(name: 'Text Editor', icon: Icons.dashboard),
    ComponentItem(name: 'Timeline', icon: Icons.dashboard),
    ComponentItem(name: 'Toast', icon: Icons.dashboard),
    ComponentItem(name: 'Toggle', icon: Icons.dashboard),
    ComponentItem(name: 'Toolbar & Tabbar', icon: Icons.dashboard),
    ComponentItem(name: 'Tooltip', icon: Icons.dashboard),
    ComponentItem(name: 'Treeview', icon: Icons.dashboard),
    ComponentItem(name: 'Virtual List', icon: Icons.dashboard),
    ComponentItem(name: 'vi - Mobile Video SSP', icon: Icons.dashboard),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.isDark,
      builder: (context, isDark, _) {
        return ValueListenableBuilder(
          valueListenable: ThemeController.primaryColor,
          builder: (context, primaryColor, _) {
            return Scaffold(
              backgroundColor: isDark ? const Color(0xFF0D1B0F) : const Color(0xFFF5F5F5),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1a1a1a) : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Framework7',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: ListView(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 20),
                children: [
                  // ABOUT FRAMEWORK7 - DI ATAS SENDIRIAN
                  ElementItem(
                    title: 'About Framework7',
                    icon: Icons.dashboard,
                    onTap: () {
                      print('Tapped: About Framework7');
                    },
                  ),
                  
                  // SPACER
                  const SizedBox(height: 16),
                  
                  // COMPONENTS HEADER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Components',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  
                  // SEMUA KOMPONEN
                  ...allComponents.map((component) {
                    return ElementItem(
                      title: component.name,
                      icon: component.icon,
                      onTap: () {
                        print('Tapped: ${component.name}');
                      },
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ComponentItem {
  final String name;
  final IconData icon;

  ComponentItem({required this.name, required this.icon});
}
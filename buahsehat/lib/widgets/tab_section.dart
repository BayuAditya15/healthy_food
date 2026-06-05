import 'package:flutter/material.dart';
class TabSection extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTap;

  const TabSection({super.key, required this.selectedTab, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        tabItem("Description", 0),
        tabItem("Review", 1),
        tabItem("Discussion", 2),
      ],
    );
  }

  Widget tabItem(String title, int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: selectedTab == index ? Colors.black : Colors.grey,
            ),
          ),
          Container(
            height: 2,
            width: 60,
            color: selectedTab == index ? Colors.green : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

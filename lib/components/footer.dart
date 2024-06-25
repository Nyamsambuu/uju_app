// lib/components/footer.dart
import 'package:flutter/material.dart';
import 'package:uju_app/theme/app_theme.dart';

class Footer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  Footer({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      selectedItemColor: AppTheme.ujuColor,
      unselectedItemColor: const Color(0xFF575D63),
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Нүүр'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Хайх'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag), label: 'Захиалга'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'Профайл'),
      ],
      onTap: onItemTapped,
    );
  }
}

// lib/components/footer.dart
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  Footer({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      selectedItemColor: Color(0xFFFA541B),
      unselectedItemColor: const Color.fromARGB(255, 76, 76, 76),
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

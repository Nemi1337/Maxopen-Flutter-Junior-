import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  BottomNavBar({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Color(0xFFFFC700),
      unselectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/search');
            break;
          case 2:
            context.go('/bookmarks');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/1.2.svg',
            color: selectedIndex == 0 ? Color(0xFFFFC700) : Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/2.svg',
            color: selectedIndex == 1 ? Color(0xFFFFC700) : Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/3.svg',
            color: selectedIndex == 2 ? Color(0xFFFFC700) : Colors.white,
          ),
          label: '',
        ),
      ],
    );
  }
}

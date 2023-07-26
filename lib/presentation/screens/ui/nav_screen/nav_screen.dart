import 'package:flutter/material.dart';
import 'package:twittusk/presentation/screens/ui/feed_screen/feed_screen.dart';
import 'package:twittusk/presentation/screens/ui/profile_screen/profile_screen.dart';
import 'package:twittusk/presentation/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import '../../../widgets/bottom_nav_bar/bottom_nav_bar_item.dart';

class NavScreen extends StatefulWidget {
  static const String routeName = '/nav-screen';

  static void navigate(BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }

  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;

  final screens = const [
    FeedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavBar(
        onItemSelected: (index) => _onItemSelected(index, context),
        indexSelected: currentIndex,
        items: [
          BottomNavBarItem(
            iconAsset: 'lib/assets/icons/home.svg',
            label: 'Home',
          ),
          BottomNavBarItem(
            iconAsset: 'lib/assets/icons/account.svg',
            label: 'Me',
          ),
        ],
      ),
      extendBody: true,
    );
  }

  void _onItemSelected(int index, BuildContext context) {
    setState(() {
      currentIndex = index;
    });
  }
}

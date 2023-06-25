import 'package:flutter/material.dart';
import 'package:twittusk/presentation/screens/ui/feed_screen/feed_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const FeedScreen(),
      bottomNavigationBar: BottomNavBar(
        onItemSelected: (index) => _onItemSelected(index, context),
        indexSelected: 0,
        items: [
          BottomNavBarItem(
            iconAsset: 'lib/assets/icons/home.svg',
            label: 'Home',
          ),
        ],
      ),
      extendBody: true,
    );
  }

  void _onItemSelected(int index, BuildContext context) {
    print(index);
    setState(() {
      currentIndex = index;
    });
  }
}

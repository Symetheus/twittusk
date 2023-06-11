import 'package:flutter/material.dart';
import 'package:twittusk/presentation/widgets/bottom_nav_bar/bottom_nav_bar_notification.dart';
import 'package:twittusk/theme/theme.dart';

import '../../../theme/dimens.dart';
import 'bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  final List<BottomNavBarItem> items;
  final int indexSelected;
  final Function(int)? onItemSelected;

  BottomNavBar({
    super.key,
    required this.items,
    this.onItemSelected,
    this.indexSelected = 0,
  }) {
    items[indexSelected].isSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).customColors.bottomNavBar,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimens.standardRadius),
          topRight: Radius.circular(Dimens.standardRadius),
        ),
      ),
      child: NotificationListener<BottomNavBarNotification>(
        onNotification: (notification) =>
            _onNotification(notification, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
    );
  }

  bool _onNotification(
      BottomNavBarNotification notification, BuildContext context) {
    if(onItemSelected != null) {
      var index = items.indexOf(notification.item);
      onItemSelected!(index);
    }
    return true;
  }
}

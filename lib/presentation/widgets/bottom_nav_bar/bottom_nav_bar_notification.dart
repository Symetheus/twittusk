import 'package:flutter/material.dart';
import 'package:twittusk/presentation/widgets/bottom_nav_bar/bottom_nav_bar_item.dart';

class BottomNavBarNotification extends Notification {
  final BottomNavBarItem item;
  BottomNavBarNotification(this.item);
}
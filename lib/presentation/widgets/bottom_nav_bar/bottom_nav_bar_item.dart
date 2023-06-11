import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twittusk/presentation/widgets/bottom_nav_bar/bottom_nav_bar_notification.dart';
import 'package:twittusk/theme/theme.dart';

import '../../../theme/dimens.dart';

class BottomNavBarItem extends StatelessWidget {
  final String iconAsset;
  final String label;
  late bool isSelected;

  BottomNavBarItem({
    super.key,
    required this.iconAsset,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onTap(context),
          child: Column(
            children: [
              const SizedBox(height: 8),
              SvgPicture.asset(
                  iconAsset,
                  width: Dimens.mediumIconSize,
                  colorFilter: ColorFilter.mode( _getColor(context), BlendMode.srcIn)
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  color: _getColor(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor(BuildContext context) {
    if (isSelected) {
      return Theme.of(context).customColors.primary;
    } else {
      return Theme.of(context).customColors.textSecondary;
    }
  }

  void _onTap(BuildContext context) {
    BottomNavBarNotification(this).dispatch(context);
  }
}

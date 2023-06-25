import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twittusk/theme/dimens.dart';

class ActionIcon extends StatelessWidget {
  final Color? color;
  final String iconAsset;
  final String? label;
  final VoidCallback? onTap;

  const ActionIcon({
    Key? key,
    this.color,
    required this.iconAsset,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              iconAsset,
              width: Dimens.smallIconSize,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
            ),
            if (label != null) ...[
              const SizedBox(width: 8),
              Text(
                label!,
                style: TextStyle(
                  color: color,
                  fontSize: Dimens.subtitleTextSize,
                  fontWeight: FontWeight.w400,
                  height: Dimens.subtitleLineHeight,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

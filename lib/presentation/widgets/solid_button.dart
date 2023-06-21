import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/dimens.dart';

class SolidButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Function()? onPressed;
  final Widget? icon;

  const SolidButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.smallRadius),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: icon != null ? 1 : 0,
            child: icon ?? const SizedBox(),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                label,
                textAlign: icon != null ? TextAlign.start : TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

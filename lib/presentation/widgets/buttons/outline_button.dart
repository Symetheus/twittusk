import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/dimens.dart';

class OutlineButton extends StatelessWidget {
  final String label;
  final Color color;
  final Function()? onPressed;
  final Widget? icon;

  const OutlineButton({
    super.key,
    required this.label,
    required this.color,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.transparent,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.smallRadius),
            side: BorderSide(color: color),
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
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

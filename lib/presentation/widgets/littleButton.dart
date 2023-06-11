import 'package:flutter/material.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

enum ButtonType {
  primary,
  secondary,
}

class LittleButton extends StatelessWidget {
  const LittleButton({
    required this.text,
    required this.onPressed,
    required this.type,
    this.style,
    this.icon,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Icon? icon;
  final ButtonType type;

  const LittleButton.primary({
    required this.text,
    this.onPressed,
    this.style,
    this.icon,
    super.key,
  }) : type = ButtonType.primary;

  const LittleButton.secondary({
    required this.text,
    this.onPressed,
    this.style,
    this.icon,
    super.key,
  }) : type = ButtonType.secondary;

  ButtonStyle _getButtonStyle(BuildContext context) {
    return switch (type) {
      ButtonType.primary => TextButton.styleFrom(
          minimumSize: const Size(Dimens.littleButtonMinWidth, Dimens.littleButtonMinInteractiveTouch),
          backgroundColor: Theme.of(context).customColors.primary,
          foregroundColor: Theme.of(context).customColors.onPrimary,
          shape: StadiumBorder(side: BorderSide(color: Theme.of(context).customColors.secondary))),
      ButtonType.secondary => TextButton.styleFrom(
          minimumSize: const Size(Dimens.littleButtonMinWidth, Dimens.littleButtonMinInteractiveTouch),
          backgroundColor: Theme.of(context).customColors.background,
          foregroundColor: Theme.of(context).customColors.onBackground,
          shape: StadiumBorder(side: BorderSide(color: Theme.of(context).customColors.secondary))),
    };
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: icon != null
          ? Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                icon!,
                const SizedBox(width: Dimens.minPadding),
                Text(text),
              ],
            )
          : Text(text),
    );
  }
}

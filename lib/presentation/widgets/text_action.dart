import 'package:flutter/material.dart';

class TextAction extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final VoidCallback? onTap;

  const TextAction({
    super.key,
    required this.text,
    this.textAlign,
    this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign,
        style: style ?? Theme.of(context).textTheme.bodyText1?.copyWith(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../theme/dimens.dart';

class TextInputSolid extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;

  const TextInputSolid({
    super.key,
    this.hintText = "",
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.black, // Set your desired text color
      ),
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            fontSize: 13,
            color: Colors.black.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.smallRadius),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.smallRadius),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.smallRadius),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.smallRadius),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.smallRadius),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).backgroundColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.smallRadius),
            ),
          )),
    );
  }
}

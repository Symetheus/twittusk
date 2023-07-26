import 'package:flutter/material.dart';
import 'package:twittusk/presentation/widgets/buttons/solid_button.dart';

import '../../../theme/dimens.dart';

class AlertModal extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onOk;
  final String buttonLabel;

  const AlertModal({
    super.key,
    required this.title,
    required this.message,
    this.buttonLabel = "OK",
    this.onOk,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onOk,
    String buttonLabel = "OK",
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.standardRadius),
          ),
          content: Container(
            width: screenWidth,
            height: screenHeight / 3,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AlertModal(
                title: title,
                message: message,
                onOk: onOk,
                buttonLabel: buttonLabel,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SolidButton(
            label: buttonLabel,
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: onOk,
        ),
      ],
    );
  }
}

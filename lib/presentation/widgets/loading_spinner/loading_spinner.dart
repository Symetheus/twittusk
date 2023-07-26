import 'package:flutter/material.dart';

import 'loading_dot.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadingDot(delay: Duration(milliseconds: 0)),
        SizedBox(width: 10.0),
        LoadingDot(delay: Duration(milliseconds: 1000)),
        SizedBox(width: 10.0),
        LoadingDot(delay: Duration(milliseconds: 2000)),
      ],
    );
  }
}

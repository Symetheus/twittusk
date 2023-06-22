import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../widgets/form/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: screenHeight / 4,
              left: 20,
              child: const Text(
                "Hi !",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),
          Positioned(
            top: 50,
            right: -150,
            child: Image.asset(
              "lib/assets/images/elon_musk.png",
              height: screenHeight - (screenHeight / 8),
            ),
          ),
          Positioned(
            top: 300,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: screenWidth - 20,
                height: screenHeight - 300,
                child: LoginForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

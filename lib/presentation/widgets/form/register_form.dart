import 'package:flutter/material.dart';
import 'package:twittusk/presentation/widgets/buttons/outline_button.dart';

import '../buttons/solid_button.dart';
import '../text_input_solid.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final VoidCallback? onSignUp;
  final VoidCallback? onSignUpWithGoogle;
  final VoidCallback? onSignUpWithTwitter;
  final VoidCallback? onCancel;

  const RegisterForm({
    super.key,
    this.emailController,
    this.passwordController,
    this.confirmPasswordController,
    this.onSignUp,
    this.onSignUpWithGoogle,
    this.onSignUpWithTwitter,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          TextInputSolid(
            hintText: "Email",
            controller: emailController,
          ),
          const SizedBox(height: 20),
          TextInputSolid(
            hintText: "Password",
            obscureText: true,
            controller: passwordController,
          ),
          const SizedBox(height: 5),
          TextInputSolid(
            hintText: "Confirm your password",
            obscureText: true,
            controller: confirmPasswordController,
          ),
          const SizedBox(height: 20),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: SolidButton(
                label: "Register",
                onPressed: onSignUp,
                backgroundColor: Theme.of(context).primaryColor,
              )
          ),
          const SizedBox(height: 20),
          const Text("or"),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: SolidButton(
              label: "Register with Google",
              onPressed: onSignUpWithGoogle,
              icon: Image.asset(
                "lib/assets/images/google_logo.png",
                height: 30,
              ),
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: SolidButton(
              label: "Register with Twitter",
              icon: Image.asset(
                "lib/assets/images/twitter_logo.png",
                height: 30,
              ),
              onPressed: onSignUpWithTwitter,
              backgroundColor: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
         OutlineButton(
             label: "Cancel",
             color: Theme.of(context).primaryColor,
             onPressed: onCancel,
         ),
        ],
      ),
    );
  }
}

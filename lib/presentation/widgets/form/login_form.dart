import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twittusk/presentation/widgets/buttons/solid_button.dart';
import 'package:twittusk/presentation/widgets/text_action.dart';
import '../../../theme/dimens.dart';
import '../text_input_solid.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final VoidCallback? onSignIn;
  final VoidCallback? onRegister;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onConnectionWithGoogle;
  final VoidCallback? onConnectionWithTwitter;

  const LoginForm({
    super.key,
    this.emailController,
    this.passwordController,
    this.onSignIn,
    this.onRegister,
    this.onForgotPassword,
    this.onConnectionWithGoogle,
    this.onConnectionWithTwitter,
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
          const SizedBox(height: 20),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: SolidButton(
                label: "Sign in",
                onPressed: onSignIn,
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
              label: "Sign in with Google",
              onPressed: onConnectionWithGoogle,
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
              label: "Sign in with Twitter",
              icon: Image.asset(
                "lib/assets/images/twitter_logo.png",
                height: 30,
              ),
              onPressed: onConnectionWithTwitter,
              backgroundColor: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                  "Don't have an account ? "
              ),
              TextAction(
                text: "Sign up",
                onTap: onRegister,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: TextAction(
              text: "Forgot password ?",
              onTap: onForgotPassword,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

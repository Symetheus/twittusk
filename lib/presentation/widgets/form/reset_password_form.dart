import 'package:flutter/material.dart';
import 'package:twittusk/presentation/widgets/buttons/outline_button.dart';
import '../buttons/solid_button.dart';
import '../text_input_solid.dart';

class ResetPasswordForm extends StatelessWidget {
  final TextEditingController? emailController;
  final VoidCallback? onResetPassword;
  final VoidCallback? onCancel;

  const ResetPasswordForm({
    super.key,
    this.emailController,
    this.onResetPassword,
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
          SizedBox(
              width: double.infinity,
              height: 50,
              child: SolidButton(
                label: "Send email",
                onPressed: onResetPassword,
                backgroundColor: Theme.of(context).primaryColor,
              )),
          const SizedBox(height: 20),
          const Text("or"),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlineButton(
              label: "Cancel",
              onPressed: onCancel,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

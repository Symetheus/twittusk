import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twittusk/domain/exceptions/auth_excpetion.dart';
import 'package:twittusk/presentation/screens/modals/alert_modal.dart';
import 'package:twittusk/presentation/widgets/loading_spinner/loading_spinner.dart';
import '../../../../provider/auth_provider.dart';
import '../../../widgets/form/login_form.dart';
import '../../../widgets/solid_button.dart';
import '../../logic/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

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
            top: 275,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: screenWidth - 20,
                height: screenHeight - 250,
                child: LoginForm(
                  connectionWidget: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if(state.status == LoginStatus.error) {
                        AlertModal.show(
                          context: context,
                          title: "Invalid",
                          message: state.errorMessage,
                          onOk: () => Navigator.of(context).pop(),
                        );
                      } else if(state.status == LoginStatus.success) {
                        print("User email ==> ${state.user!.email}");
                      }
                    },
                    builder: (context, state) {
                      if (state.status == LoginStatus.loading) {
                        return const LoadingSpinner();
                      }

                      return SolidButton(
                        label: "Continue",
                        onPressed: () => _onConnection(context),
                        backgroundColor: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                  emailController: emailController,
                  passwordController: passwordController,
                  onConnectionWithGoogle: () => _signInWithGoogle(context),
                  onConnectionWithTwitter: () => _signInWithTwitter(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signInWithGoogle(BuildContext context) async {
    try {
      await AuthProvider.of(context).googleAuth.signInWithGoogle();
    } on AuthException catch (e) {
      AlertModal.show(
        context: context,
        title: "Invalid",
        message: e.message,
        onOk: () => Navigator.of(context).pop(),
      );
    }
  }

  void _signInWithTwitter(BuildContext context) async {
    try {
      await AuthProvider.of(context).twitterAuth.signInWithTwitter();
    } on AuthException catch (e) {
      AlertModal.show(
        context: context,
        title: "Invalid",
        message: e.message,
        onOk: () => Navigator.of(context).pop(),
      );
    }
  }

  void _onConnection(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(LoginConnection(
      email: emailController.text,
      password: passwordController.text,
    ));
  }
}

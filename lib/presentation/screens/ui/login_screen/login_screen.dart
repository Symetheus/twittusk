import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twittusk/domain/exceptions/auth_excpetion.dart';
import 'package:twittusk/presentation/screens/modals/alert_modal.dart';
import 'package:twittusk/presentation/widgets/form/register_form.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../theme/dimens.dart';
import '../../../widgets/form/login_form.dart';
import '../../../widgets/form/reset_password_form.dart';
import '../../logic/login_bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Widget currentForm;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentForm = LoginForm(
      emailController: emailController,
      passwordController: passwordController,
      onSignIn: () => _onConnection(context),
      onConnectionWithGoogle: () => _signInWithGoogle(context),
      onConnectionWithTwitter: () => _signInWithTwitter(context),
      onForgotPassword: () => _onForgotPassword(context),
      onRegister: () => _changeToRegisterForm(context),
    );
  }

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
                child: Stack(
                  children: [
                    SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.bigRadius),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state.status == LoginStatus.error) {
                          AlertModal.show(
                            context: context,
                            title: "Invalid",
                            message: state.errorMessage,
                            onOk: () => Navigator.of(context).pop(),
                          );
                        } else if (state.status == LoginStatus.successResetPassword) {
                          AlertModal.show(
                            context: context,
                            title: "Reset password",
                            message: "Check your email to reset your password",
                            onOk: () => Navigator.of(context).pop(),
                          );
                          _changeToLoginForm(context);
                        } else if (state.status == LoginStatus.success) {
                          print("User email ==> ${state.user!.email}");
                        }
                      },
                      builder: (context, state) {
                        if (state.status == LoginStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return currentForm;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========================= CALLBACKS =========================

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
    BlocProvider.of<LoginBloc>(context).add(SignInEvent(
      email: emailController.text,
      password: passwordController.text,
    ));
  }

  void _onForgotPassword(BuildContext context) {
    setState(() {
      currentForm = ResetPasswordForm(
        emailController: emailController,
        onCancel: () => _changeToLoginForm(context),
        onResetPassword: () => _onResetPassword(context),
      );
    });
  }

  void _onResetPassword(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(ResetPasswordEvent(
      email: emailController.text,
    ));
  }


  // ========================= UPDATE FORM =========================

  void _changeToLoginForm(BuildContext context) {
    setState(() {
      currentForm = LoginForm(
        emailController: emailController,
        passwordController: passwordController,
        onSignIn: () => _onConnection(context),
        onConnectionWithGoogle: () => _signInWithGoogle(context),
        onConnectionWithTwitter: () => _signInWithTwitter(context),
        onForgotPassword: () => _onForgotPassword(context),
        onRegister: () => _changeToRegisterForm(context),
      );
    });
  }

  void _changeToRegisterForm(BuildContext context) {
    passwordController.clear();
    setState(() {
      currentForm = RegisterForm(
        emailController: emailController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        onCancel: () => _changeToLoginForm(context),
      );
    });
  }
}

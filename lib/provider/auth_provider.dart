import 'package:flutter/material.dart';
import 'package:twittusk/domain/utils/google_auth.dart';
import 'package:twittusk/domain/utils/twitter_auth.dart';

class AuthProvider extends InheritedWidget {
  final TwitterAuth twitterAuth;
  final GoogleAuth googleAuth;

  const AuthProvider({
    super.key,
    required Widget child,
    required this.twitterAuth,
    required this.googleAuth
  }) : super(child: child);

  static AuthProvider of(BuildContext context) {
    final AuthProvider? result = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    assert(result != null, 'No AuthProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AuthProvider old) {
    return true;
  }
}

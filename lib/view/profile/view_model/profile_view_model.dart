import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/routes/routes_navigation.dart';

class ProfileViewModel extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  Future<void> logOut({required BuildContext context}) async {
    await auth.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesNavigation.login,
        (route) => false,
      );
    }
  }
}

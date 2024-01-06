import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lapor_book/routes/routes_navigation.dart';

class SplashViewModel extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> authStateChanges({
    required BuildContext context,
  }) async {
    User? user = auth.currentUser;
    await Future.delayed(const Duration(seconds: 3), () {
      if (user != null) {
        Navigator.pushReplacementNamed(
          context,
          RoutesNavigation.dashboard,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          RoutesNavigation.login,
        );
      }
    });
  }
}

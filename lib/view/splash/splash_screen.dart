import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lapor_book/view/splash/view_model/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashViewModel>(context).authStateChanges(context: context);

    return const Scaffold(
      body: Center(
        child: Text('Aplikasi Lapor Book'),
      ),
    );
  }
}

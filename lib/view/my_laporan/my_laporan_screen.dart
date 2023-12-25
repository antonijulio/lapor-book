import 'package:flutter/material.dart';
import 'package:lapor_book/model/akun.dart';

class MyLaporanScreen extends StatelessWidget {
  final Akun? akun;
  const MyLaporanScreen({super.key, this.akun});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Icon(Icons.edit_document),
      ),
    );
  }
}

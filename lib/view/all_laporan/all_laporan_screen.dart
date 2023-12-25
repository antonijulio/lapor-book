import 'package:flutter/material.dart';
import 'package:lapor_book/model/akun.dart';

class AllLaporanScreen extends StatelessWidget {
  final Akun? akun;
  const AllLaporanScreen({super.key, this.akun});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Icon(Icons.document_scanner),
      ),
    );
  }
}

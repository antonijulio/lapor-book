import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/components/status_dialog.dart';
import 'package:lapor_book/model/akun.dart';
import 'package:lapor_book/model/laporan.dart';
import 'package:lapor_book/routes/routes_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLaporanViewModel extends ChangeNotifier {
  bool isLoading = false;

  String? _status;
  String? get getStatus => _status;
  set setStatus(String? status) {
    _status = status;
    notifyListeners();
  }

  final firestore = FirebaseFirestore.instance;

  Future launch(String uri) async {
    if (uri == '') return;
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat memanggil : $uri');
    }
  }

  void updateStatus(Laporan laporan, BuildContext context) async {
    CollectionReference transaksiCollection = firestore.collection('laporan');
    try {
      await transaksiCollection.doc(laporan.docId).update({
        'status': _status,
      });

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesNavigation.dashboard,
          (route) => false,
        );
      }
    } on FirebaseException catch (e) {
      throw Exception('GAGAL UPDATE STATUS ${e.message}');
    }
  }

  void statusDialog(Laporan laporan, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatusDialog(
          laporan: laporan,
        );
      },
    );
  }

  Future<void> like(BuildContext context, Akun akun, Laporan laporan) async {
    CollectionReference laporanCollection = firestore.collection('laporan');
    CollectionReference akunCollection = firestore.collection('akun');

    try {
      await laporanCollection.doc(laporan.docId).update({
        'likes': FieldValue.arrayUnion([akun.nama]),
      });
      await akunCollection.doc(akun.docId).update({
        'likes': FieldValue.arrayUnion([laporan.docId]),
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil Menyukai Laporan'),
          ),
        );
      }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal Menyukai Laporan'),
          ),
        );
      }
      throw Exception('GAGAL MENYUKAI LAPORAN ${e.message}');
    }
  }
}

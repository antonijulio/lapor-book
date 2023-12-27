import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/model/laporan.dart';
import 'package:lapor_book/routes/routes_navigation.dart';

class AllLaporanViewModel extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  String emptyImage =
      'https://www.kalderanews.com/wp-content/uploads/2022/01/Sultan-Gustaf-AL-Ghozali-atau-yang-dikenal-Ghozali-Everyday-mahasiswa-Udinus.-Dok.-Udinus-600x381.jpg';

  List<Laporan> listLaporan = [];

  Future<void> getTransaksi(BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection('laporan').get();

      listLaporan.clear();
      for (var documents in querySnapshot.docs) {
        List<dynamic>? komentarData = documents.data()['komentar'];

        List<Komentar>? listKomentar = komentarData?.map((map) {
          return Komentar(
            nama: map['nama'],
            isi: map['isi'],
          );
        }).toList();

        listLaporan.add(
          Laporan(
            uid: documents.data()['uid'],
            docId: documents.data()['docId'],
            judul: documents.data()['judul'],
            instansi: documents.data()['instansi'],
            deskripsi: documents.data()['deskripsi'],
            nama: documents.data()['nama'],
            status: documents.data()['status'],
            gambar: documents.data()['gambar'],
            tanggal: documents['tanggal'].toDate(),
            maps: documents.data()['maps'],
            komentar: listKomentar,
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal mendapatkan Laporan')));
      }
      throw Exception('GAGAL MENDAPATKAN LAPORAN');
    }
  }

  void deleteLaporan(Laporan laporan, BuildContext context) async {
    try {
      await firestore.collection('laporan').doc(laporan.docId).delete();

      if (laporan.gambar != '') {
        await storage.refFromURL(laporan.gambar!).delete();
      }
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesNavigation.dashboard,
          (route) => false,
        );
      }
    } catch (e) {
      throw Exception('GAGAL MENGHAPUS LAPORAN $e');
    }
  }

  void openDialog(
    bool isLaporanku,
    BuildContext context,
    Laporan laporan,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete ${laporan.judul}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                deleteLaporan(laporan, context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lapor_book/components/styles.dart';
import 'package:lapor_book/helper/laporan_view_model.dart';
import 'package:lapor_book/model/akun.dart';
import 'package:lapor_book/model/laporan.dart';
import 'package:lapor_book/view/detail_laporan/view_model/detail_laporan_view_model.dart';
import 'package:provider/provider.dart';

class DetailLaporanScreen extends StatelessWidget {
  const DetailLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Laporan laporan = args['laporan'];
    Akun akun = args['akun'];
    bool isLaporanku = args['isLaporanku'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Detail Laporan',
          style: headerStyle(level: 3, dark: false),
        ),
        centerTitle: true,
      ),
      body: Consumer<DetailLaporanViewModel>(
        builder: (context, controller, child) {
          return SafeArea(
            child: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            laporan.judul,
                            style: headerStyle(level: 3),
                          ),
                          const SizedBox(height: 15),
                          laporan.gambar?.isNotEmpty == true
                              ? Image.network(
                                  laporan.gambar!,
                                  width: 200,
                                  height: 300,
                                  fit: BoxFit.contain,
                                )
                              : Image.network(
                                  Provider.of<LaporanViewModel>(
                                    context,
                                    listen: false,
                                  ).emptyImage,
                                  width: 200,
                                  height: 300,
                                  fit: BoxFit.contain,
                                ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (laporan.status == 'Posted') ...[
                                textStatus(
                                    'Posted', Colors.yellow, Colors.black)
                              ] else if (laporan.status == 'Process') ...[
                                textStatus(
                                    'Process', Colors.green, Colors.white)
                              ] else ...[
                                textStatus('Done', Colors.blue, Colors.white),
                              ],
                              textStatus(
                                laporan.instansi,
                                Colors.white,
                                Colors.black,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Center(child: Text('Nama Pelapor')),
                            subtitle: Center(
                              child: Text(laporan.nama),
                            ),
                            trailing: const SizedBox(width: 45),
                          ),
                          ListTile(
                            leading: const Icon(Icons.date_range),
                            title: const Center(child: Text('Tanggal Laporan')),
                            subtitle: Center(
                              child: Text(
                                DateFormat('dd MMMM yyyy', 'id_ID')
                                    .format(laporan.tanggal),
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.location_on),
                              onPressed: () {
                                controller.launch(laporan.maps);
                              },
                            ),
                          ),
                          const SizedBox(height: 50),
                          Text(
                            'Deskripsi Laporan',
                            style: headerStyle(level: 3),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(laporan.deskripsi ?? ''),
                          ),
                          const SizedBox(height: 50),
                          if (akun.role == 'admin')
                            SizedBox(
                              width: 250,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.setStatus = laporan.status;

                                  controller.statusDialog(laporan, context);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Ubah Status'),
                              ),
                            ),
                          if (isLaporanku == false)
                            SizedBox(
                              width: 250,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.setStatus = laporan.status;

                                  controller.statusDialog(laporan, context);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Ubah Status'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Container textStatus(
    String text,
    var bgcolor,
    var textcolor,
  ) {
    return Container(
      width: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgcolor,
        border: Border.all(width: 1, color: primaryColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: TextStyle(color: textcolor),
      ),
    );
  }
}

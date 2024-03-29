import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lapor_book/model/akun.dart';
import 'package:lapor_book/components/list_item.dart';
import 'package:lapor_book/helper/laporan_view_model.dart';

class AllLaporanScreen extends StatelessWidget {
  final Akun? akun;
  const AllLaporanScreen({super.key, this.akun});

  @override
  Widget build(BuildContext context) {
    Provider.of<LaporanViewModel>(
      context,
      listen: false,
    ).getAllTransaksi(context);
    Provider.of<LaporanViewModel>(
      context,
      listen: false,
    ).getConnectivity();

    return Consumer<LaporanViewModel>(
      builder: (context, controller, child) {
        if (controller.isOffline == true) {
          return const Center(
            child: Text('Anda Sedang Ofline'),
          );
        } else {
          return SafeArea(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1 / 1.5,
              ),
              itemCount: controller.listAllLaporan.length,
              itemBuilder: (context, index) {
                var laporan = controller.listAllLaporan[index];

                return ListItem(
                  laporan: laporan,
                  akun: akun,
                  isLaporanku: false,
                );
              },
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lapor_book/components/list_item.dart';
import 'package:lapor_book/model/akun.dart';
import 'package:lapor_book/view/all_laporan/view_model/all_laporan_view_model.dart';
import 'package:provider/provider.dart';

class AllLaporanScreen extends StatelessWidget {
  final Akun? akun;
  const AllLaporanScreen({super.key, this.akun});

  @override
  Widget build(BuildContext context) {
    Provider.of<AllLaporanViewModel>(
      context,
      listen: false,
    ).getTransaksi(context);

    return Consumer<AllLaporanViewModel>(
      builder: (context, controller, child) {
        return SafeArea(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1 / 1.5,
            ),
            itemCount: controller.listLaporan.length,
            itemBuilder: (context, index) {
              var laporan = controller.listLaporan[index];

              return ListItem(
                laporan: laporan,
                akun: akun,
                isLaporanku: false,
              );
            },
          ),
        );
      },
    );
  }
}

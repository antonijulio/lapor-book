import 'package:flutter/material.dart';
import 'package:lapor_book/components/styles.dart';
import 'package:lapor_book/model/laporan.dart';
import 'package:lapor_book/view/detail_laporan/view_model/detail_laporan_view_model.dart';
import 'package:provider/provider.dart';

class StatusDialog extends StatefulWidget {
  final Laporan laporan;
  const StatusDialog({
    super.key,
    required this.laporan,
  });

  @override
  State<StatusDialog> createState() => _StatusDialogState();
}

class _StatusDialogState extends State<StatusDialog> {
  @override
  void initState() {
    super.initState();
    var controller = Provider.of<DetailLaporanViewModel>(
      context,
      listen: false,
    );

    controller.setStatus = widget.laporan.status;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailLaporanViewModel>(
      builder: (context, controller, child) {
        return AlertDialog(
          backgroundColor: primaryColor,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.laporan.judul,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                RadioListTile<String>(
                  title: const Text('Posted'),
                  value: 'Posted',
                  groupValue: controller.getStatus,
                  onChanged: (value) {
                    controller.setStatus = value!;
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Process'),
                  value: 'Process',
                  groupValue: controller.getStatus,
                  onChanged: (value) {
                    controller.setStatus = value!;
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Done'),
                  value: 'Done',
                  groupValue: controller.getStatus,
                  onChanged: (value) {
                    controller.setStatus = value!;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.updateStatus(
                      widget.laporan,
                      context,
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Simpan Status'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

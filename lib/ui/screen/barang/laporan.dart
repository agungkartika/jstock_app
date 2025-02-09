import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jstock/controller/barangcontroller.dart';
import 'package:jstock/ui/widgets/headline.dart';

class LaporanBarangScreen extends GetView<LaporanBarangController> {
  @override
  final LaporanBarangController controller = Get.put(LaporanBarangController());

  LaporanBarangScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Headline(
              title: "Laporan Barang",
              caption: "Laporan Barang Masuk dan Keluar",
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => DropdownButton<String>(
                      value: controller.selectedLaporan.value,
                      items: const [
                        DropdownMenuItem(
                            value: 'barangmasuk', child: Text('Barang Masuk')),
                        DropdownMenuItem(
                            value: 'barangkeluar',
                            child: Text('Barang Keluar')),
                      ],
                      onChanged: (value) {
                        controller.selectedLaporan.value = value!;
                        controller.fetchLaporan();
                      },
                    )),
                ElevatedButton(
                  onPressed: () => controller.selectDateRange(context),
                  child: Obx(() => Text(controller.startDate.value == null ||
                          controller.endDate.value == null
                      ? "Pilih Rentang Tanggal"
                      : "${controller.startDate.value!.toLocal().toString().split(" ")[0]} - ${controller.endDate.value!.toLocal().toString().split(" ")[0]}")),
                ),
              ],
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.laporanList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              controller.laporanList[index]['barang']['nama']),
                          subtitle: Text(
                              "Jumlah: ${controller.laporanList[index]['jumlah']} | No Faktur: ${controller.laporanList[index]['nofaktur']}"),
                          trailing: Text(controller.laporanList[index]
                                  ['tanggal']
                              .split("T")[0]),
                        ),
                      );
                    },
                  )),
            ),
            ElevatedButton(
              onPressed: controller.exportToPDF,
              child: const Text("Export PDF"),
            ),
          ],
        ),
      ),
    );
  }
}

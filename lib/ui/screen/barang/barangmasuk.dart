import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:jstock/controller/barangcontroller.dart';
import 'package:jstock/ui/widgets/headline.dart';

class BarangMasukScreen extends StatelessWidget {
  final BarangMasukController controller = Get.put(BarangMasukController());

  BarangMasukScreen({super.key});

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
              title: "Barang Masuk",
              caption: "Lengkapi Data Barang Masuk",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.noFakturController.value,
              decoration: InputDecoration(
                labelText: "Nomor Faktur",
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Input Tanggal
            TextField(
              controller: controller.tanggalController.value,
              readOnly: true,
              onTap: () => controller.selectTanggal(context),
              decoration: InputDecoration(
                labelText: "Tanggal",
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
                color: Colors.black, thickness: 1, endIndent: 0, indent: 0),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.barangMasukList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Obx(() => DropdownButtonFormField<int>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      labelText: "Pilih Barang",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    items: controller.barangList
                                        .map<DropdownMenuItem<int>>((barang) {
                                      return DropdownMenuItem<int>(
                                        value: barang['id'],
                                        child: Text(barang['nama']),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.barangMasukList[index]
                                          ['barang_id'] = value;
                                    },
                                    value: controller.barangMasukList[index]
                                        ['barang_id'],
                                  )),
                              const SizedBox(height: 20),
                              SpinBox(
                                min: 1,
                                max: 10000,
                                value: controller.barangMasukList[index]
                                        ['jumlah']
                                    .toDouble(),
                                onChanged: (value) =>
                                    controller.barangMasukList[index]
                                        ['jumlah'] = value.toInt(),
                                decoration: InputDecoration(
                                  labelText: "Jumlah",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      controller.removeBarangMasuk(index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: controller.addBarangMasuk,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Tambah Barang"),
                ),
                ElevatedButton(
                  onPressed: controller.saveBarangMasuk,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Simpan"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

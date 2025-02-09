import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jstock/controller/barangcontroller.dart';
import 'package:jstock/ui/widgets/headline.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class BarangKeluarScreen extends StatelessWidget {
  final BarangKeluarController controller = Get.put(BarangKeluarController());
  BarangKeluarScreen({super.key});

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
              title: "Barang Keluar",
              caption: "Lengkapi Data Barang Keluar",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.noFakturController.value,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Nomor Faktur",
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.tanggalController.value,
              readOnly: true,
              onTap: () => controller.selectTanggal(
                  context), // Memanggil fungsi selectTanggal saat tap
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
                    itemCount: controller.barangKeluarList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Obx(() => DropdownButtonFormField<int>(
                                    decoration: InputDecoration(
                                      labelText: "Pilih Barang",
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    items: controller.barangList
                                        .map<DropdownMenuItem<int>>((barang) {
                                      return DropdownMenuItem<int>(
                                        value: barang['id'],
                                        child: Text(barang['nama']),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.barangKeluarList[index]
                                          ['barang_id'] = value;
                                    },
                                    value: controller.barangKeluarList[index]
                                        ['barang_id'],
                                  )),
                              const SizedBox(height: 20),
                              SpinBox(
                                min: 1,
                                max: 10000,
                                value: controller.barangKeluarList[index]
                                        ['jumlah']
                                    .toDouble(),
                                onChanged: (value) =>
                                    controller.barangKeluarList[index]
                                        ['jumlah'] = value.toInt(),
                                decoration: InputDecoration(
                                  labelText: "Jumlah",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    controller.removeBarangKeluar(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: controller.addBarangKeluar,
                  child: const Text("Tambah Barang"),
                ),
                ElevatedButton(
                  onPressed: controller.saveBarangKeluar,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jstock/controller/barangcontroller.dart';
import 'package:jstock/ui/widgets/headline.dart';

class ItemScreen extends StatelessWidget {
  final ItemController controller = Get.put(ItemController());

  ItemScreen({super.key});

  void _showItemDialog(BuildContext context, {Map<String, dynamic>? item}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController stockController = TextEditingController();
    TextEditingController typeController = TextEditingController();

    if (item != null) {
      nameController.text = item['nama'];
      stockController.text = item['stok'].toString();
      typeController.text = item['jenis'];
    }

    Get.defaultDialog(
      title: item == null ? 'Tambah Barang' : 'Edit Barang',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nama Barang',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: stockController,
            decoration: InputDecoration(
              labelText: 'Stok',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: typeController,
            decoration: InputDecoration(
              labelText: 'Jenis Barang',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Batal', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () {
            if (item == null) {
              controller.addItem(
                nameController.text,
                int.tryParse(stockController.text) ?? 0,
                typeController.text,
              );
            } else {
              controller.editItem(
                item['id'],
                nameController.text,
                int.tryParse(stockController.text) ?? 0,
                typeController.text,
              );
            }
            Get.back();
          },
          child: Text(item == null ? 'Tambah' : 'Simpan'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchItems();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Headline(
              title: "Barang",
              caption: "List Barang",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Cari Barang...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: controller.filterItems,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() => controller.filteredItems.isEmpty
                  ? const Center(child: Text('Tidak ada barang yang ditemukan'))
                  : ListView.builder(
                      itemCount: controller.filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.filteredItems[index];
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              item['nama'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'Stok: ${item['stok']} | Jenis: ${item['jenis']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () =>
                                      _showItemDialog(context, item: item),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    // Menampilkan dialog konfirmasi sebelum menghapus
                                    Get.defaultDialog(
                                      title: 'Konfirmasi Hapus',
                                      middleText:
                                          'Apakah Anda yakin ingin menghapus barang ini?',
                                      onCancel: () => Get
                                          .back(), // Menutup dialog jika batal
                                      onConfirm: () {
                                        controller.deleteItem(item['id']);
                                        Get.back(); // Menutup dialog setelah hapus
                                      },
                                      textConfirm: 'Hapus',
                                      textCancel: 'Batal',
                                      confirmTextColor: Colors.white,
                                      buttonColor: Colors
                                          .red, // Mengubah warna tombol konfirmasi
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

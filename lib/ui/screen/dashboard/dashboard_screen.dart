import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jstock/ui/screen/dashboard/dashborad_controller.dart';
import 'package:jstock/ui/widgets/card_announce_medium.dart';
import 'package:jstock/ui/widgets/headline.dart';
import 'package:jstock/ui/widgets/navigate_button.dart';
import 'package:jstock/ui/widgets/subtitle.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Headline(title: "Dashboard"),
            const SizedBox(height: 32),

            /// Announce Card
            Obx(() {
              String namaUser = controller.nama.value.isNotEmpty
                  ? controller.nama.value
                  : "User";

              return CardAnnounceMedium(
                iconData: Icons.person,
                title: "Hallo, $namaUser!",
                subtitle:
                    "Tetap semangat dalam bekerja dan jangan lupa untuk berdoa.",
              );
            }),
            const SizedBox(height: 32),

            /// Stok Sedikit Section
            Row(
              children: [
                const Subtitle(title: "Stok Sedikit"),
                const Spacer(),
                NavigateButton(
                  onTap: () => controller.fetchLowStockItems(),
                  title: "Refresh",
                  iconData: Icons.refresh,
                ),
              ],
            ),
            const SizedBox(height: 10),

            /// List Barang dengan stok sedikit
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.barangList.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada barang yang stoknya sedikit',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const AlwaysScrollableScrollPhysics(), // Allow scroll
                  itemCount: controller.barangList.length,
                  itemBuilder: (context, index) {
                    final item = controller.barangList[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          item['nama'] ?? 'Tidak ada nama',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Stok: ${item['stok'] ?? 0} | Jenis: ${item['jenis'] ?? '-'}',
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

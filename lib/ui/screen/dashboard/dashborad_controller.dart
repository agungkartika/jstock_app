import 'package:get/get.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jstock/data/config.dart';

class DashboardController extends GetxController {
  var username = ''.obs;
  var nama = ''.obs;
  var barangList = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchLowStockItems();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'Admin';
    nama.value = prefs.getString('nama') ?? 'Admin';
  }

  Future<void> fetchLowStockItems() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse("$supabaseUrl/barang?stok=lt.5"), // Filter stok sedikit
        headers: supabaseHeaders,
      );

      if (response.statusCode == 200) {
        barangList.value = json.decode(response.body);
      } else {
        Get.snackbar("Error", "Gagal mengambil data barang");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

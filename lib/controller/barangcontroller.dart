import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:jstock/data/config.dart';

class ItemController extends GetxController {
  var items = <Map<String, dynamic>>[].obs;
  var filteredItems = <Map<String, dynamic>>[].obs;
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }
  // @override
  // void onReady() {
  //   fetchItems(); // Memastikan data diperbarui setiap kali halaman dibuka
  //   super.onReady();
  // }

  Future<void> fetchItems() async {
    final response = await http.get(
      Uri.parse('$supabaseUrl/barang?select=*&order=stok.asc,nama.asc'),
      headers: supabaseHeaders,
    );

    if (response.statusCode == 200) {
      items.value = List<Map<String, dynamic>>.from(json.decode(response.body));
      filteredItems.value = items;
    } else {
      throw Exception('Gagal memuat barang');
    }
  }

  Future<void> addItem(String name, int stock, String jenis) async {
    final response = await http.post(
      Uri.parse('$supabaseUrl/barang'),
      headers: supabaseHeaders,
      body: jsonEncode({
        'nama': name,
        'stok': stock,
        'jenis': jenis,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 204) {
      fetchItems();
    } else {
      throw Exception('Gagal menambahkan barang');
    }
  }

  void filterItems(String query) {
    filteredItems.value = items
        .where(
            (item) => item['nama'].toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> editItem(int id, String name, int stock, String jenis) async {
    final response = await http.patch(
      Uri.parse('$supabaseUrl/barang?id=eq.$id'),
      headers: supabaseHeaders,
      body: jsonEncode({
        'nama': name,
        'stok': stock,
        'jenis': jenis,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 204) {
      fetchItems();
    } else {
      throw Exception('Gagal mengedit barang');
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(
      Uri.parse('$supabaseUrl/barang?id=eq.$id'),
      headers: supabaseHeaders,
    );

    if (response.statusCode == 201 || response.statusCode == 204) {
      fetchItems();
    } else {
      throw Exception('Gagal menghapus barang');
    }
  }
}

class BarangMasukController extends GetxController {
  var noFakturController = TextEditingController().obs;
  var barangMasukList = <Map<String, dynamic>>[].obs;
  var barangList = <Map<String, dynamic>>[].obs;
  var tanggalController = TextEditingController().obs;

  @override
  void onInit() {
    fetchBarang();
    super.onInit();
  }

  // Fungsi untuk memilih tanggal
  void selectTanggal(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      tanggalController.value.text =
          DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> fetchBarang() async {
    final response = await http.get(
      Uri.parse('$supabaseUrl/barang?select=id,nama'),
      headers: supabaseHeaders,
    );

    if (response.statusCode == 200) {
      barangList.value =
          List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      print('Error: ${response.body}');
    }
  }

  void addBarangMasuk() {
    barangMasukList.add({'barang_id': null, 'jumlah': 0});
  }

  void removeBarangMasuk(int index) {
    barangMasukList.removeAt(index);
  }

  Future<void> saveBarangMasuk() async {
    if (noFakturController.value.text.isEmpty || barangMasukList.isEmpty) {
      Get.snackbar("Error", "Isi nomor faktur dan minimal 1 barang");
      return;
    }

    List<Map<String, dynamic>> dataToSend = barangMasukList.map((item) {
      return {
        'barang_id': item['barang_id'],
        'jumlah': item['jumlah'],
        'nofaktur': noFakturController.value.text,
        'tanggal': tanggalController.value.text, // Tambahkan tanggal ke data
      };
    }).toList();

    final response = await http.post(
      Uri.parse('$supabaseUrl/barangmasuk'),
      headers: supabaseHeaders,
      body: jsonEncode(dataToSend),
    );

    if (response.statusCode == 201 || response.statusCode == 204) {
      Get.snackbar("Sukses", "Data berhasil disimpan");
      noFakturController.value.clear();
      barangMasukList.clear();
      tanggalController.value.clear(); // Clear tanggal setelah simpan
    } else {
      Get.snackbar("Error", "Gagal menyimpan data");
    }
  }
}

class BarangKeluarController extends GetxController {
  var noFakturController = TextEditingController().obs;
  var barangKeluarList = <Map<String, dynamic>>[].obs;
  var barangList = <Map<String, dynamic>>[].obs;
  var tanggalController = TextEditingController().obs;

  @override
  void onInit() {
    generateNoFaktur();
    fetchBarang();
    super.onInit();
  }

  void selectTanggal(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      tanggalController.value.text =
          DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> generateNoFaktur() async {
    String today = DateTime.now().toString().split(' ')[0].replaceAll('-', '');
    String prefix = "F$today";

    final response = await http.get(
      Uri.parse(
          '$supabaseUrl/barangkeluar?select=nofaktur&order=nofaktur.desc&limit=1'),
      headers: supabaseHeaders,
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        String lastFaktur = data[0]['nofaktur'];
        int lastNumber = int.parse(lastFaktur.substring(9)) + 1;
        noFakturController.value.text =
            "$prefix${lastNumber.toString().padLeft(3, '0')}";
      } else {
        noFakturController.value.text = "${prefix}001";
      }
    }
  }

  Future<void> fetchBarang() async {
    final response = await http.get(
      Uri.parse('$supabaseUrl/barang?select=id,nama'),
      headers: supabaseHeaders,
    );

    if (response.statusCode == 200) {
      barangList.value =
          List<Map<String, dynamic>>.from(json.decode(response.body));
    }
  }

  void addBarangKeluar() {
    barangKeluarList.add({'barang_id': null, 'jumlah': 0});
  }

  void removeBarangKeluar(int index) {
    barangKeluarList.removeAt(index);
  }

  Future<void> saveBarangKeluar() async {
    if (barangKeluarList.isEmpty) {
      Get.snackbar("Error", "Minimal tambahkan 1 barang");
      return;
    }

    List<Map<String, dynamic>> dataToSend = barangKeluarList.map((item) {
      return {
        'barang_id': item['barang_id'],
        'jumlah': item['jumlah'],
        'nofaktur': noFakturController.value.text,
        'tanggal': tanggalController.value.text,
      };
    }).toList();

    final response = await http.post(
      Uri.parse('$supabaseUrl/barangkeluar'),
      headers: supabaseHeaders,
      body: jsonEncode(dataToSend),
    );

    if (response.statusCode == 201 || response.statusCode == 204) {
      Get.snackbar("Sukses", "Data berhasil disimpan");
      generateNoFaktur();
      barangKeluarList.clear();
    } else {
      Get.snackbar("Error", "Gagal menyimpan data");
    }
  }
}

class LaporanBarangController extends GetxController {
  var laporanList = <Map<String, dynamic>>[].obs;
  var selectedLaporan = 'barangmasuk'.obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  @override
  void onInit() {
    fetchLaporan();
    super.onInit();
  }

  @override
  void onReady() {
    fetchLaporan(); // Memastikan data diperbarui setiap kali halaman dibuka
    super.onReady();
  }

  Future<void> fetchLaporan() async {
    String endpoint =
        selectedLaporan.value == 'barangmasuk' ? 'barangmasuk' : 'barangkeluar';

    // Ganti 'created_at' dengan 'tanggal' di sini
    String filter = (startDate.value != null && endDate.value != null)
        ? '&tanggal=gte.${startDate.value!.toIso8601String().split("T")[0]}&tanggal=lte.${endDate.value!.toIso8601String().split("T")[0]}'
        : '';

    final response = await http.get(
      Uri.parse('$supabaseUrl/$endpoint?select=*,barang(nama)$filter'),
      headers: supabaseHeaders,
    );

    if (response.statusCode == 200) {
      laporanList.value =
          List<Map<String, dynamic>>.from(json.decode(response.body));
    }
  }

  Future<void> exportToPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                  "Laporan ${selectedLaporan.value == 'barangmasuk' ? 'Barang Masuk' : 'Barang Keluar'}",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: ['No Faktur', 'Nama Barang', 'Jumlah', 'Tanggal'],
                data: laporanList
                    .map((item) => [
                          item['nofaktur'],
                          item['barang']['nama'],
                          item['jumlah'].toString(),
                          item['tanggal']
                              .split("T")[0] // Ganti 'created_at' ke 'tanggal'
                        ])
                    .toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future<void> selectDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: startDate.value != null && endDate.value != null
          ? DateTimeRange(start: startDate.value!, end: endDate.value!)
          : null,
    );
    if (picked != null) {
      startDate.value = picked.start;
      endDate.value = picked.end;
      fetchLaporan();
    }
  }
}

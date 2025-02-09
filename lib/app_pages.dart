import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jstock/controller/AuthController.dart';
import 'package:jstock/ui/auth/login_screen.dart';
import 'package:jstock/ui/responive/responsive_layout.dart';
import 'package:jstock/ui/screen/barang/barangkeluar.dart';
import 'package:jstock/ui/screen/barang/barangmasuk.dart';
import 'package:jstock/ui/screen/barang/index.dart';
import 'package:jstock/ui/screen/barang/laporan.dart';
import 'package:jstock/ui/screen/dashboard/dashboard_binding.dart';
import 'package:jstock/ui/screen/dashboard/dashboard_screen.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: "/login", page: () => LoginScreen()),
    GetPage(
      name: "/",
      page: () => ResponsiveLayout(content: DashboardScreen()),
      bindings: [
        DashboardBinding(),
      ],
    ),
    GetPage(
      name: "/barang",
      page: () => ResponsiveLayout(content: ItemScreen()),
    ),
    GetPage(
      name: "/barangmasuk",
      page: () => ResponsiveLayout(content: BarangMasukScreen()),
    ),
    GetPage(
      name: "/barangkeluar",
      page: () => ResponsiveLayout(content: BarangKeluarScreen()),
    ),
    GetPage(
      name: "/laporan",
      page: () => ResponsiveLayout(content: LaporanBarangScreen()),
    ),
    GetPage(
      name: "/user",
      page: () => const ResponsiveLayout(
        content: Align(
          alignment: Alignment.center,
          child: Text("staff"),
        ),
      ),
    ),
    GetPage(
      name: "/setting",
      page: () => const ResponsiveLayout(
        content: Align(
          alignment: Alignment.center,
          child: Text("setting"),
        ),
      ),
    ),
    GetPage(
      name: "/logout",
      page: () {
        final AuthController authController = Get.find<AuthController>();
        authController.logout();
        return LoginScreen();
      },
    ),
  ];
}

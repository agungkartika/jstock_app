// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class MainMenuData {
  String name;
  IconData? icon;
  Widget page;
  String route;
  String type_opening;

  MainMenuData({
    required this.name,
    this.icon,
    required this.page,
    required this.route,
    this.type_opening = "page",
  });
}

List<MainMenuData> listMainMenu = [
  MainMenuData(
    name: "Dashboard",
    page: Container(),
    icon: Icons.analytics,
    route: "/",
  ),
  MainMenuData(
    name: "Barang",
    page: Container(),
    icon: Icons.inventory,
    route: "/barang",
  ),
  MainMenuData(
    name: "Barang masuk",
    page: Container(),
    icon: Icons.inventory_outlined,
    route: "/barangmasuk",
  ),
  MainMenuData(
    name: "Barang Keluar",
    page: Container(),
    icon: Icons.add_shopping_cart,
    route: "/barangkeluar",
  ),
  MainMenuData(
    name: "Laporan",
    page: Container(),
    icon: Icons.file_open,
    route: "/laporan",
  ),
  MainMenuData(
    name: "profile",
    page: Container(),
    icon: Icons.person_sharp,
    route: "/profile",
  ),
  MainMenuData(
    name: "Deconnexion",
    page: Container(),
    icon: Icons.logout_rounded,
    route: "/logout",
  ),
];

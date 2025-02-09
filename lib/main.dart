import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jstock/app_pages.dart';
import 'package:jstock/controller/AuthController.dart';
import 'package:jstock/constant/app_colors.dart';
import 'package:jstock/ui/web_drag_scroll_behavior.dart';

void main() {
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'J-STOCK',
      debugShowCheckedModeBanner: false,
      scrollBehavior: WebDragScrollBehavior(),
      initialRoute: "/login",
      getPages: AppPages.routes,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white)),
        textTheme:
            Theme.of(context).textTheme.apply(displayColor: Colors.white),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: Colors.white,
          unselectedIconTheme: IconThemeData(color: Colors.black),
          selectedIconTheme: IconThemeData(color: Colors.black12),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.black,
          iconColor: Colors.black,
          contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        dividerTheme: const DividerThemeData(
            color: Colors.grey, indent: 32, endIndent: 32),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.indigoAccent,
          secondary: Colors.deepOrange,
        ),
        cardTheme: const CardTheme(elevation: 12, shadowColor: Colors.white),
      ),
    );
  }
}

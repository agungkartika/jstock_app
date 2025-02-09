import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jstock/constant/app_colors.dart';
import 'package:jstock/constant/data/app_basic_data.dart';
import 'package:jstock/constant/data/main_menu_data.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Image.asset(
                'assets/icon/logo.png',
                width: 128,
                height: 128,
                fit: BoxFit.cover, // Menambahkan fit jika perlu
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listMainMenu.length,
              itemBuilder: (context, index) {
                MainMenuData menu = listMainMenu[index];
                return ListTile(
                  selected: route!.settings.name == menu.route,
                  selectedTileColor: const Color.fromARGB(255, 240, 81, 76).withOpacity(0.8),
                  onTap: () => Get.toNamed(menu.route),
                  title: Text(menu.name),
                  leading: Icon(menu.icon),
                  selectedColor: Colors.white,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Version: ',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.grey800,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: AppBaseData.version,
                        style: TextStyle(
                          color: AppColors.grey400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Author: ',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.grey800,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: AppBaseData.author,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.grey400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

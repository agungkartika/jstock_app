import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jstock/data/config.dart';
import 'package:jstock/ui/auth/login_screen.dart';
import 'package:jstock/ui/responive/responsive_layout.dart';
import 'package:jstock/ui/screen/dashboard/dashboard_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
            "$supabaseUrl/users?username=eq.$username&password=eq.$password"),
        headers: supabaseHeaders,
      );

      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
        if (users.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          isLoggedIn.value = true;
          Get.offAll(() => ResponsiveLayout(content: DashboardScreen()));
        } else {
          Get.snackbar("Login Failed", "Invalid username or password");
        }
      } else {
        Get.snackbar("Error", "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn.value = false;
    Get.offAll(() => LoginScreen());
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn.value) {
      Get.offAll(() => ResponsiveLayout(content: DashboardScreen()));
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}

import 'package:get/get.dart';
import 'package:jstock/controller/AuthController.dart';
import 'package:jstock/ui/screen/dashboard/dashborad_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut(() => DashboardController());
  }
}

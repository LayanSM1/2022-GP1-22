import '../controller/verfiy_controller.dart';
import 'package:get/get.dart';

class verfiyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => verfiyController());
  }
}

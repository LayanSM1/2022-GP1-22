import '../controller/addfriend_controller.dart';
import 'package:get/get.dart';

class AddfriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddfriendController());
  }
}

import '../controller/get_started_three_controller.dart';
import 'package:get/get.dart';

class GetStartedThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetStartedThreeController());
  }
}

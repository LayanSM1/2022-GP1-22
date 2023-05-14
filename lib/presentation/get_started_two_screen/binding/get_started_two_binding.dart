import '../controller/get_started_two_controller.dart';
import 'package:get/get.dart';

class GetStartedTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetStartedTwoController());
  }
}

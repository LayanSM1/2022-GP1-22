import '../controller/get_started_one_controller.dart';
import 'package:get/get.dart';

class GetStartedOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetStartedOneController());
  }
}

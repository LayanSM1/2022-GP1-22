import '../controller/private_chat_controller.dart';
import 'package:get/get.dart';

class PrivateChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivateChatController());
  }
}

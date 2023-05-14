import 'package:application1/classes/function.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '/core/app_export.dart';
import 'package:application1/presentation/home_screen/models/home_model.dart';

class HomeController extends GetxController {
  Rx<HomeModel> homeModelObj = HomeModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

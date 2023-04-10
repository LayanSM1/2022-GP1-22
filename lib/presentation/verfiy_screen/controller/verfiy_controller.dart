import 'package:application1/presentation/verfiy_screen/models/verfiy_model.dart';

import '/core/app_export.dart';
import 'package:application1/presentation/login_screen/models/login_model.dart';
import 'package:flutter/material.dart';

class verfiyController extends GetxController {
  TextEditingController frameEmailController = TextEditingController();
  TextEditingController framePasswordController = TextEditingController();
  Rx<LoginModel> verfiyModelObj = verfiyModel().obs as Rx<LoginModel>;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    frameEmailController.dispose();
    framePasswordController.dispose();  }
}

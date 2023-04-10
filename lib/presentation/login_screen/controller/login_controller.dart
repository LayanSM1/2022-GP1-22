import '/core/app_export.dart';
import 'package:application1/presentation/login_screen/models/login_model.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  TextEditingController frameEmailController = TextEditingController();
  TextEditingController framePasswordController = TextEditingController();
  TextEditingController frameFiveController = TextEditingController();
  TextEditingController frameNameController = TextEditingController();


  Rx<LoginModel> loginModelObj = LoginModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    frameEmailController.dispose();
    framePasswordController.dispose();
    frameFiveController.dispose();
    frameNameController.dispose();


  }
}

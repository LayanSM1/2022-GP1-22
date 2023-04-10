import '/core/app_export.dart';
import 'package:application1/presentation/reset_screen/models/reset_model.dart';
import 'package:flutter/material.dart';

class ResetController extends GetxController {
  TextEditingController frameEmailController = TextEditingController();
  Rx<ResetModel> resetModelObj = ResetModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    frameEmailController.dispose();
  }
}

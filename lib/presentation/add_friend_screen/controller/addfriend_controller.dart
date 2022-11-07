import 'package:application1/presentation/add_friend_screen/models/addfriend_model.dart';
import '/core/app_export.dart';
import 'package:flutter/material.dart';

class AddfriendController extends GetxController {
  TextEditingController groupOneController = TextEditingController();

  Rx<AddfriendModel> addfriendModelObj = AddfriendModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupOneController.dispose();
  }
}

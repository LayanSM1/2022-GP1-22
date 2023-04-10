import 'package:application1/presentation/add_friend_screen/models/friend_model.dart';
import '/core/app_export.dart';
import 'package:flutter/material.dart';

class AddfriendController extends GetxController {
  TextEditingController groupOneController = TextEditingController();
  

  @override
  void onReady() {
    super.onReady();
  }

  usersList()async{
    

  }

  @override
  void onClose() {
    super.onClose();
    groupOneController.dispose();
  }
}

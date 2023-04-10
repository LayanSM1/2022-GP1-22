import 'dart:developer';

import 'package:application1/classes/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/addfriend_controller.dart';
//import 'package:application2/core/app_export.dart';
//import 'package:application2/core/utils/validation_functions.dart';
//import 'package:application2/widgets/custom_button.dart';
//import 'package:application2/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddfriendScreen extends GetWidget<AddfriendController> {
  User? user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  Color primaryColor = Color(0xff4338CA);
  Color secondaryColor = Color(0xff6D28D9);
  Color accentColor = Color(0xffffffff);
  Color backgroundColor = Color(0xffffffff);
  Color errorColor = Color(0xffEF4444);
  late String email_1 = "sa12@gmail.com";
  late String email_2;
  late String results;

  String email = "";
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: getVerticalSize(
                  199.00,
                ),
                width: size.width,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonImageView(
                        imagePath: ImageConstant.imgGroup1745,
                        height: getVerticalSize(
                          199.00,
                        ),
                        width: getHorizontalSize(
                          375.00,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: getPadding(
                          left: 63,
                          top: 64,
                          right: 63,
                          bottom: 64,
                        ),
                        child: Text(
                          "ADD FRIEND".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtQuicksandBold48,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Enter Your Friend Email",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRubikRomanBold18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        validator: (value) {},
                        controller: emailController,
                        onChanged: (value) {
                          print(value);
                        },
                        keyboardType: TextInputType.emailAddress,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.email),
                          filled: true,
                          fillColor: accentColor,
                          hintText: 'Search by email',
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(.75)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: errorColor, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        onTap: () async {
                          if (emailController.text.isNotEmpty &&
                              emailController.text !=
                                  FirebaseAuth.instance.currentUser!.email!) {
                            log("called");
                            email = emailController.text;
                            Add().getFriendData(email);
                            // Add().getUserData(email);
                          }
                        },
                        width: 175,
                        text: "ADD FRIEND",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

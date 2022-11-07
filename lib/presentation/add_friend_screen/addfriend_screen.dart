import 'package:application1/classes/add.dart';

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
  final _firestore = FirebaseFirestore.instance;
  late String Email_1 = "sa12@gmail.com";
  late String Email_2;
  late String Results;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(
                    0.5,
                    -3.0616171314629196e-17,
                  ),
                  end: Alignment(
                    0.5,
                    0.9999999999999999,
                  ),
                  colors: [
                    ColorConstant.whiteA700,
                    ColorConstant.gray100,
                  ],
                ),
              ),
              child: Column(
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
                                "lbl_add_friend".tr,
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
                  Padding(
                    padding: getPadding(
                      left: 84,
                      top: 163,
                      right: 72,
                    ),
                    child: Text(
                      "msg_enter_your_frie".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtRubikRomanBold18,
                    ),
                  ),
                  CustomTextFormField(
                    width: 356,
                    focusNode: FocusNode(),
                    controller: controller.groupOneController,
                    hintText: "lbl_email".tr,
                    margin: getMargin(
                      left: 9,
                      top: 45,
                      right: 10,
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null ||
                          (!isValidEmail(value, isRequired: true))) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  CustomButton(
                    onTap: () async {
                      Email_2 = controller.groupOneController.text;

                      //search email in database
                      Results = Add().searchByEmail(Email_2);
                      print(Results);

                      if (Results != null) {
                        //add friend to database
                        _firestore.collection("friends").add({
                          "user1_email": Email_1,
                          "user2_email": Email_2,
                        });
                        //conformation message
                        SnackBar(
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              // Code to execute.
                            },
                          ),
                          content:  Text("The friend was added sucessufly"),
                          //backgroundColor: Colors.blueGrey,
                          duration: const Duration(milliseconds: 10000),
                          width: 350.0, // Width of the SnackBar.
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, // Inner padding for SnackBar content.
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        );
                      }

                      else {
                        //error message
                        SnackBar(
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Code to execute.
                            },
                          ),
                          content:  Text("This user doesn't exist"),
                          //backgroundColor: Colors.blueGrey,
                          duration: const Duration(milliseconds: 10000),
                          width: 350.0, // Width of the SnackBar.
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, // Inner padding for SnackBar content.
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        );

                      }


                    },
                    width: 175,
                    text: "lbl_add".tr,
                    margin: getMargin(
                      left: 84,
                      top: 123,
                      right: 84,
                      bottom: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

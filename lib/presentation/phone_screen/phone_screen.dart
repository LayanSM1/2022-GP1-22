import 'package:application1/core/app_export.dart';
import 'package:application1/core/utils/validation_functions.dart';
import 'package:application1/presentation/authentication_screen/authentication_screen.dart';
import 'package:application1/widgets/custom_button.dart';
import 'package:application1/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'controller/phone_controller.dart';
class PhoneScreen extends GetWidget<PhoneController> {
  PhoneController controller = Get.put(PhoneController());


  final user = FirebaseAuth.instance.currentUser;
   String ? email;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('user').get(),
            builder: (context,snapshot){
              if(snapshot.hasError)
                {
                  return Center(child: CircularProgressIndicator());

                }
              if(snapshot.connectionState == ConnectionState.done)
                {
                 List documents = snapshot.data!.docs.where((element) => element['Email'].contains(user!.email)).toList();
                 print(documents.length);
                 return Center(child: Text(documents[0]['PhoneNumber']));
                }
              return Center(child: CircularProgressIndicator());
            })
    ))
          );
  }

}
/*
* Container(
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
                    ColorConstant.indigo600,
                    ColorConstant.lightBlue400,
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: getVerticalSize(
                        179.00,
                      ),
                      width: size.width,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CommonImageView(
                              imagePath: ImageConstant.imgBgcircle179X375,
                              height: getVerticalSize(
                                179.00,
                              ),
                              width: getHorizontalSize(
                                375.00,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: getPadding(
                                left: 142,
                                top: 53,
                                right: 142,
                                bottom: 53,
                              ),
                              child: CommonImageView(
                                imagePath: ImageConstant.imgTipplerlogore,
                                height: getVerticalSize(
                                  65.00,
                                ),
                                width: getHorizontalSize(
                                  76.00,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: getPadding(
                        left: 54,
                        top: 22,
                        right: 54,
                      ),
                      child: Text(
                        "OTP Verification".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRubikRomanSemiBold32.copyWith(
                          height: 1.00,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: getHorizontalSize(
                        243.00,
                      ),
                      margin: getMargin(
                        left: 57,
                        top: 21,
                        right: 57,
                      ),
                      child: Text(
                        "We will send a message with an OTP to confirm your identity".tr,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppStyle.txtRubikRomanMedium14.copyWith(
                          height: 1.57,
                        ),
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    width: 319,
                    focusNode: FocusNode(),
                    controller: controller.frameFiveController,


                    hintText: "+966XXXXXXXXXX".tr,
                    margin: getMargin(
                      left: 32,
                      top: 66,
                      right: 23,
                    ),
                    textInputAction: TextInputAction.done,
                    alignment: Alignment.center,

                    validator: (value) {
                      if (!isValidPhone(value!)) {
                        return "Please enter valid phone number";
                      }
                      return null;
                    },
                  ),
                  CustomButton(
                    width: 296,
                    text: "Get OTP".tr,
                    margin: getMargin(
                      left: 32,
                      top: 42,
                      right: 32,
                      bottom: 5,
                    ),
                    onTap:() {
                      print('tapped button');
                      print(controller.frameFiveController.text);

                      Get.to(AuthenticationScreen(controller.frameFiveController.text));

                    },
                      alignment:
                      Alignment.center,
                    ),

                ],
              ),
            ),
          ),
        ),*/
/*

*/
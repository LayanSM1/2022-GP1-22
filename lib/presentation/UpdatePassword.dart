import 'package:application1/core/app_export.dart';
import 'package:application1/presentation/profile_screen/profile_edit_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';

import '../classes/Validators.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../routes/app_routes.dart';
import '../theme/app_style.dart';
import '../widgets/common_image_view.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatePasWidget extends StatefulWidget {
  @override
  _UpdatePasWidgetState createState() => _UpdatePasWidgetState();

}

class _UpdatePasWidgetState extends State<UpdatePasWidget> {


  TextEditingController frameOldPasswordController = TextEditingController();
  TextEditingController frameNewPasswordController = TextEditingController();
  TextEditingController frameConfirmPasswordController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;





  @override
  Widget build(BuildContext context) {


    // Figma Flutter Generator UpdatePasWidget - FRAME
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 227, 225, 225),
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              automaticallyImplyLeading: false,
              title: Container(
                  width: 40,
                  child: CommonImageView(
                      imagePath: ImageConstant.imgTipplerlogore61X54)),
              actions: [
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, AppRoutes.loginScreen);
                  },
                  icon: Icon(Icons.logout),
                )
              ],
            ),
            body: SingleChildScrollView(
                child: Column(
                    children: [
                      Align(
                        // alignment: Alignment.centerLeft,
                          child: Container(
                              height: getVerticalSize(199.00),
                              width: size.width,
                              child: Stack(
                                  alignment: Alignment.bottomLeft, children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: CommonImageView(
                                        imagePath: ImageConstant.imgGroup1745,
                                        height: getVerticalSize(199.00),
                                        width: getHorizontalSize(375.00))),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                        padding: getPadding(
                                            left: 44,
                                            top: 12,
                                            right: 44,
                                            bottom: 12),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: [
                                              // Align(
                                              //     alignment: Alignment.centerLeft,
                                              //     child: Padding(
                                              //         padding:
                                              //             getPadding(left: 19, right: 19),
                                              //         child: Text("Add",
                                              //             overflow: TextOverflow.ellipsis,
                                              //             textAlign: TextAlign.left,
                                              //             style: AppStyle
                                              //                 .txtQuicksandBold32))),
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                      height: getVerticalSize(
                                                          109.00),
                                                      width: getHorizontalSize(
                                                          241.00),
                                                      margin: getMargin(top: 7),
                                                      child: Stack(
                                                          alignment: Alignment
                                                              .topRight,
                                                          children: [
                                                            // Align(
                                                            //     alignment: Alignment.bottomLeft,
                                                            //     child: Padding(padding: getPadding(top: 10, right: 10), child: CommonImageView(imagePath: ImageConstant.imgTipplerlogore61X54, height: getVerticalSize(61.00), width: getHorizontalSize(54.00)))),
                                                            Align(
                                                                alignment:
                                                                Alignment
                                                                    .topCenter,
                                                                child: Padding(
                                                                    padding: getPadding(
                                                                        left: 10,
                                                                        bottom: 10),
                                                                    child: StreamBuilder(
                                                                        stream: FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            'user')
                                                                            .doc(
                                                                            FirebaseAuth
                                                                                .instance
                                                                                .currentUser!
                                                                                .uid)
                                                                            .snapshots(),
                                                                        builder: (
                                                                            context,
                                                                            AsyncSnapshot<
                                                                                DocumentSnapshot<
                                                                                    Map<
                                                                                        String,
                                                                                        dynamic>>>
                                                                            snapshot) {
                                                                          return Text(
                                                                              'update password',
                                                                              overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                              textAlign:
                                                                              TextAlign
                                                                                  .left,
                                                                              style: AppStyle
                                                                                  .txtQuicksandBold48);
                                                                        })))
                                                          ])))
                                            ])))
                              ]))),
                      Align(
                          alignment: Alignment.bottomCenter,
                          // child: Padding(
                          // padding: getPadding(
                          //     left: 26,
                          //     top: 10,
                          //     right: 26,
                          //     bottom: 85),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [

                                Padding(
                                    padding: getPadding(
                                        left: 15,
                                        top: 20,
                                        right: 10),
                                    child: Text("Your Old Password",
                                        overflow: TextOverflow
                                            .ellipsis,
                                        textAlign:
                                        TextAlign.left,
                                        style: AppStyle
                                            .txtRubikRomanBold18)),
                                CustomTextFormField(
                                    width: 319,
                                    focusNode: FocusNode(),
                                    controller: frameOldPasswordController,
                                    hintText:
                                    "Enter your old password",
                                    margin: getMargin(
                                        left: 2, top: 22),
                                    textInputAction:
                                    TextInputAction.done,
                                    alignment: Alignment.center,
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return 'the field is empty';
                                    },
                                    value: frameOldPasswordController.text),
                                Padding(
                                    padding: getPadding(
                                        left: 15, top: 20, right: 10),
                                    child: Text("New Password",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRubikRomanBold18)),
                                CustomTextFormField(
                                    width: 319,
                                    focusNode: FocusNode(),
                                    controller: frameNewPasswordController,
                                    hintText: "your password",
                                    margin: getMargin(left: 2, top: 22),
                                    isObscureText: true,
                                    textInputAction: TextInputAction.done,
                                    alignment: Alignment.center,
                                    value: frameNewPasswordController.text),

                                new SizedBox(
                                  height: 5,
                                ),
                                new FlutterPwValidator(
                                    controller: frameNewPasswordController,
                                    minLength: 8,
                                    uppercaseCharCount: 1,
                                    numericCharCount: 1,
                                    specialCharCount: 1,
                                    width: 400,
                                    height: 150,
                                    onSuccess: () {
                                      // validPassword = true;
                                    }),

                                Padding(
                                    padding: getPadding(
                                        left: 15, top: 30, right: 10),
                                    child: Text("ConfirmPassword",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRubikRomanBold18)),
                                CustomTextFormField(
                                    width: 319,
                                    focusNode: FocusNode(),
                                    controller:
                                    frameConfirmPasswordController,
                                    hintText: "confirm your password",
                                    margin: getMargin(left: 2, top: 22),
                                    isObscureText: true,
                                    textInputAction: TextInputAction.done,
                                    alignment: Alignment.center,
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return 'the field is empty';
                                      if (val !=
                                          frameNewPasswordController.text)
                                        return "Password doesn't match";
                                      return null;
                                    },
                                    value: frameNewPasswordController.text),
                                CustomButton(
                                    onTap:(){
                                      try {

                                        final user = _auth.currentUser;
                                        AuthCredential credential = EmailAuthProvider.credential(email: user!.email!, password: frameOldPasswordController.text);
                                       user.reauthenticateWithCredential(credential);
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('Update Password'),
                                            content: const Text('Do you really want to update your password? '),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  frameOldPasswordController.clear();
                                                  frameNewPasswordController.clear();
                                                  frameConfirmPasswordController.clear();
                                                  Navigator.pop(context, 'Cancel');},
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  ScaffoldMessenger.of(
                                                      context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      action:
                                                      SnackBarAction(
                                                        label: '',
                                                        onPressed: () {
                                                          // Code to execute.
                                                        },
                                                      ),
                                                      content:
                                                      Text('Your password updated successfully'),
                                                      //backgroundColor: Colors.blueGrey,
                                                      duration:
                                                      const Duration(
                                                          milliseconds:
                                                          10000),
                                                      width:
                                                      350.0, // Width of the SnackBar.
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                        horizontal:
                                                        30.0, // Inner padding for SnackBar content.
                                                      ),
                                                      behavior:
                                                      SnackBarBehavior
                                                          .floating,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            10.0),
                                                      ),
                                                    ),
                                                  );
                                                  user.updatePassword(frameNewPasswordController.text);
                                                frameOldPasswordController.clear();
                                                frameNewPasswordController.clear();
                                                frameConfirmPasswordController.clear();
                                                  Navigator.pop(context, 'Ok');
                                                },

                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                       // user.updatePassword(frameNewPasswordController.text);
                                       //  frameOldPasswordController.clear();
                                       //  frameNewPasswordController.clear();
                                       //  frameConfirmPasswordController.clear();


                                      }catch(e){print(e);};
                                    }

                                    ,
                                    width: 175,
                                    text: "Update Password",
                                    margin: getMargin(
                                        left: 66,
                                        top: 30,
                                        right: 66),
                                    alignment:
                                    Alignment.center),
                                CustomButton(
                                  onTap:(){      Navigator.pop(context);},
                                    width: 175,
                                    text: "Cancel",
                                    margin: getMargin(
                                        left: 66,
                                        top: 10,
                                        right: 66,
                                        bottom:10,
                                    ),


                                    alignment:
                                    Alignment.center),


                              ]
                          ))
                    ])


            )));

  }


}

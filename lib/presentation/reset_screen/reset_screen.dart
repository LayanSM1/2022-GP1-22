import 'package:application1/core/app_export.dart';
import 'package:application1/widgets/custom_button.dart';
import 'package:application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:application1/classes/Validators.dart';
import 'controller/reset_controller.dart';

class resetpassword extends GetWidget<ResetController> {
  final _auth = FirebaseAuth.instance;
  late String Email;
  final _formKey = GlobalKey<FormState>();
  final navigatorkey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    navigatorkey:
    navigatorkey;
    return SafeArea(
        child: Scaffold(
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Container(
                        height: size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment(0.5, -3.0616171314629196e-17),
                                end: Alignment(0.5, 0.9999999999999999),
                                colors: [
                              ColorConstant.indigo600,
                              ColorConstant.lightBlue401
                            ])),
                        child: Container(
                            height: size.height,
                            width: size.width,
                            child:
                                Stack(alignment: Alignment.topLeft, children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: getPadding(bottom: 50),
                                      child: CommonImageView(
                                          imagePath:
                                              ImageConstant.imgBgcircle777X375,
                                          height: getVerticalSize(900.00),
                                          width: getHorizontalSize(375.00)))),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 26,
                                          top: 10,
                                          right: 26,
                                          bottom: 88),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: getPadding(right: 10),
                                                child: Text(
                                                    "Enter your email to reset your password",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRubikRomanBold48)),
                                            Padding(
                                                padding: getPadding(
                                                    left: 2,
                                                    top: 82,
                                                    right: 10),
                                                child: Text("lbl_email".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRubikRomanBold18)),
                                            CustomTextFormField(
                                                width: 319,
                                                focusNode: FocusNode(),
                                                controller: controller
                                                    .frameEmailController,
                                                hintText:
                                                    "msg_your_email_e_g".tr,
                                                margin:
                                                    getMargin(left: 2, top: 22),
                                                textInputAction:
                                                    TextInputAction.done,
                                                alignment: Alignment.center,
                                                validator:
                                                    Validators.validateEmail,
                                                value: controller
                                                    .frameEmailController.text),
                                            CustomButton(
                                                onTap: () async {
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (context) =>
                                                          Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ));
                                                  try {
                                                    await FirebaseAuth.instance
                                                        .sendPasswordResetEmail(
                                                            email: controller
                                                                .frameEmailController
                                                                .text);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        action: SnackBarAction(
                                                          label: 'Undo',
                                                          onPressed: () {
                                                            // Code to execute.
                                                          },
                                                        ),
                                                        content: Text(
                                                            "Password Reset Email Sent "),
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
                                                    Get.toNamed(
                                                        AppRoutes.loginScreen);
                                                  } on FirebaseAuthException catch (e) {
                                                    Get.toNamed(
                                                        AppRoutes.loginScreen);

                                                    // Navigator.pushNamed(
                                                    //     context,
                                                    //     AppRoutes
                                                    //         .registerScreen);
                                                    String msg =
                                                        e.message.toString();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        action: SnackBarAction(
                                                          label: 'Undo',
                                                          onPressed: () {
                                                            // Code to execute.
                                                          },
                                                        ),
                                                        content: Text(msg),
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
                                                  }
                                                },
                                                width: 175,
                                                text: "Send Email".tr,
                                                margin: getMargin(
                                                    left: 66,
                                                    top: 100,
                                                    right: 66),
                                                alignment: Alignment.center),
                                          ]))),
                            ])))))));
  }
}

import 'package:application1/presentation/home_screen/home_screen.dart';
import 'package:application1/presentation/phone_screen/phone_screen.dart';
import '../authentication_screen/authentication_screen.dart';
import 'controller/login_controller.dart';
import 'package:application1/core/app_export.dart';
import 'package:application1/widgets/custom_button.dart';
import 'package:application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:application1/classes/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../classes/secureStorage.dart';
// import 'package:crypton/crypton.dart';

class LoginScreen extends GetWidget<LoginController> {
  final _auth = FirebaseAuth.instance;
  late String Email;
  late String Password;
  late String publicKey;
  late String privateKey;
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
                //width: size.width,
                child: SingleChildScrollView(
                    // child: Form(
                    //  key: _formKey,
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
                            child: Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                          padding: getPadding(bottom: 50),
                                          child: CommonImageView(
                                              imagePath: ImageConstant
                                                  .imgBgcircle777X375,
                                              height: getVerticalSize(800.00),
                                              width:
                                                  getHorizontalSize(375.00)))),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                          padding: getPadding(
                                              left: 26,
                                              top: 10,
                                              right: 26,
                                              bottom: 85),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        getPadding(right: 10),
                                                    child: Text("lbl_login".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRubikRomanBold48)),
                                                Padding(
                                                    padding: getPadding(
                                                        left: 2,
                                                        top: 82,
                                                        right: 10),
                                                    child: Text("lbl_email".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRubikRomanBold18)),
                                                CustomTextFormField(
                                                    width: 319,
                                                    focusNode: FocusNode(),
                                                    controller: controller
                                                        .frameEmailController,
                                                    hintText:
                                                        "msg_your_email_e_g".tr,
                                                    margin: getMargin(
                                                        left: 2, top: 22),
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    alignment: Alignment.center,
                                                    validator: Validators
                                                        .validateEmail,
                                                    value: controller
                                                        .frameEmailController
                                                        .text),
                                                Padding(
                                                    padding: getPadding(
                                                        left: 2,
                                                        top: 35,
                                                        right: 10),
                                                    child: Text(
                                                        "lbl_password".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRubikRomanBold18)),
                                                CustomTextFormField(
                                                    width: 319,
                                                    focusNode: FocusNode(),
                                                    controller: controller
                                                        .framePasswordController,
                                                    hintText: "your password",
                                                    margin: getMargin(
                                                        left: 2, top: 22),
                                                    isObscureText: true,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    alignment: Alignment.center,
                                                    validator: Validators
                                                        .validatePassword,
                                                    value: controller
                                                        .framePasswordController
                                                        .text),
                                                CustomButton(
                                                    onTap: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder:
                                                                (context) =>
                                                                    Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ));
                                                        Email = controller
                                                            .frameEmailController
                                                            .text;
                                                        Password = controller
                                                            .framePasswordController
                                                            .text;
                                                        bool emailIsVerified =
                                                            false;
                                                        try {
                                                          UserCredential user =
                                                              await _auth.signInWithEmailAndPassword(
                                                                  email: Email
                                                                      .trim(),
                                                                  password:
                                                                      Password
                                                                          .trim());

                                                          // final rsaKeypair = RSAKeypair
                                                          //     .fromRandom();
                                                          // publicKey =
                                                          //     rsaKeypair
                                                          //         .publicKey
                                                          //         .toPEM();
                                                          // privateKey =
                                                          //     rsaKeypair
                                                          //         .privateKey
                                                          //         .toPEM();
                                                          //
                                                          // //Send PK to local storage
                                                          // await userSecureStorage
                                                          //     .setPrivateKey(
                                                          //     privateKey);
                                                          //
                                                          // //update user record with public key
                                                          // CollectionReference users = FirebaseFirestore.instance.collection('user');
                                                          //       users.doc(Email).update({'PublicKey': publicKey});
                                                          //
                                                          emailIsVerified =
                                                              await user.user!
                                                                  .emailVerified;
                                                          if (await emailIsVerified) {
                                                            try {
                                                              Get.to(() =>
                                                                  HomeScreen());
                                                            } catch (e) {
                                                              print(e);
                                                            }
                                                          } else {
                                                            var errortext =
                                                                'Please verify your email if you haven\'t already';
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "The email you entered is not verified or the password is wrong",
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    3,
                                                                backgroundColor:
                                                                    Colors
                                                                        .blueAccent,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          }
                                                        } on FirebaseAuthException catch (e) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              AppRoutes
                                                                  .loginScreen);

                                                          String msg = e.message
                                                              .toString();

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              action:
                                                                  SnackBarAction(
                                                                label: 'Undo',
                                                                onPressed: () {
                                                                  // Code to execute.
                                                                },
                                                              ),
                                                              content:
                                                                  Text(msg),
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
                                                      }
                                                    },
                                                    width: 175,
                                                    text: "lbl_login".tr,
                                                    margin: getMargin(
                                                        left: 66,
                                                        top: 100,
                                                        right: 66),
                                                    alignment:
                                                        Alignment.center),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              AppRoutes
                                                                  .resetpasswordScreen);
                                                        },
                                                        child: Container(
                                                            margin: getMargin(
                                                                left: 70,
                                                                top: 16,
                                                                right: 70),
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                              "Forgot password?",
                                                                          style: TextStyle(
                                                                              color: ColorConstant.black900,
                                                                              fontSize: getFontSize(15),
                                                                              fontFamily: 'Rubik',
                                                                              fontWeight: FontWeight.w400)),
                                                                      TextSpan(
                                                                          text:
                                                                              " ",
                                                                          style: TextStyle(
                                                                              color: ColorConstant.black900,
                                                                              fontSize: getFontSize(15),
                                                                              fontFamily: 'Rubik',
                                                                              fontWeight: FontWeight.w700)),
                                                                      TextSpan(
                                                                          text:
                                                                              "Reset here",
                                                                          style: TextStyle(
                                                                              color: ColorConstant.deepPurple500,
                                                                              fontSize: getFontSize(15),
                                                                              fontFamily: 'Rubik',
                                                                              fontWeight: FontWeight.w700))
                                                                    ]),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left)))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          onTapTxtDonthaveana();
                                                        },
                                                        child: Container(
                                                            margin: getMargin(
                                                                left: 66,
                                                                top: 16,
                                                                right: 61),
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text: "msg_don_t_have_an_a2"
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              color: ColorConstant.black900,
                                                                              fontSize: getFontSize(11),
                                                                              fontFamily: 'Rubik',
                                                                              fontWeight: FontWeight.w400)),
                                                                      TextSpan(
                                                                          text:
                                                                              " ",
                                                                          style: TextStyle(
                                                                              color: ColorConstant.black900,
                                                                              fontSize: getFontSize(11),
                                                                              fontFamily: 'Rubik',
                                                                              fontWeight: FontWeight.w700)),
                                                                      TextSpan(
                                                                          text: "lbl_register"
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              color: ColorConstant.black900,
                                                                              fontSize: getFontSize(11),
                                                                              fontFamily: 'Rubik',
                                                                              fontWeight: FontWeight.w400)),
                                                                      TextSpan(
                                                                          text:
                                                                              " ",
                                                                          style: TextStyle(
                                                                              color: ColorConstant.yellow800,
                                                                              fontSize: getFontSize(11),
                                                                              fontFamily: 'Rubik',
                                                                              fontWeight: FontWeight.w700)),
                                                                      TextSpan(
                                                                          text: "lbl_here"
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              color: ColorConstant.deepPurple500,
                                                                              fontSize: getFontSize(11),
                                                                              fontFamily: 'Rubik',
                                                                              fontWeight: FontWeight.w700))
                                                                    ]),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left))))
                                              ]))),
                                ])))))));
  }

  onTapTxtDonthaveana() {
    Get.toNamed(AppRoutes.registerScreen);
  }
}

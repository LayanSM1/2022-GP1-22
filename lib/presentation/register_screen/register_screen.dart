import 'package:application1/presentation/login_screen/login_screen.dart';

import '../verfiy_screen/verfiy_screen.dart';
import 'controller/register_controller.dart';
import 'package:application1/core/app_export.dart';
import 'package:application1/core/utils/validation_functions.dart';
import 'package:application1/widgets/custom_button.dart';
import 'package:application1/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:application1/classes/Validators.dart';
import 'package:application1/classes/Utils.dart';
import 'package:flutter/material.dart';
import 'package:application1/presentation/home_screen/home_screen.dart';
import 'package:crypton/crypton.dart';
import 'package:crypt/crypt.dart';
import '../../classes/user.dart';
import '../../classes/secureStorage.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class RegisterScreen extends GetWidget<RegisterController> {
  TextEditingController frameNameController = TextEditingController();
  TextEditingController frameEmailController = TextEditingController();
  TextEditingController framePasswordController = TextEditingController();
  TextEditingController frameConfirmPasswordController = TextEditingController();
  TextEditingController framePhoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String Name;
  late String Email;
  late String PhoneNumber;
  late String Password;
  late String ConfirmPassword;
  late String publicKey;
  late String privateKey;
  late String phoneNumber;
  bool validPassword = false;
  final _formKey = GlobalKey<FormState>();
  final navigatorkey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    navigatorkey;

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
      Container(
          height: 1050,
          child: Form(
              key: _formKey,
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
                      child: Stack(alignment: Alignment.topLeft, children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: getPadding(bottom: 10),
                                child: CommonImageView(
                                    imagePath: ImageConstant.imgBgcircle774X375,
                                    height: getVerticalSize(960.00),
                                    width: getHorizontalSize(375.00)))),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: getPadding(
                                    left: 26, top: 10, right: 26, bottom: 88),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: getPadding(right: 10),
                                          child: Text("lbl_register".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRubikRomanBold48)),
                                      //Name of the user

                                      Padding(
                                          padding: getPadding(
                                              left: 2, top: 40, right: 10),
                                          child: Text("lbl_name".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRubikRomanBold18)),

                                      CustomTextFormField(
                                          width: 319,
                                          focusNode: FocusNode(),
                                          controller:
                                              frameNameController,
                                          hintText: "msg_your_name_e_g".tr,
                                          margin: getMargin(left: 2, top: 22),
                                          alignment: Alignment.center,
                                          validator:
                                              Validators.validateUsername),

                                      Padding(
                                          padding: getPadding(
                                              left: 2, top: 35, right: 10),
                                          child: Text("lbl_email".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRubikRomanBold18)),

                                      CustomTextFormField(
                                          width: 319,
                                          focusNode: FocusNode(),
                                          controller:
                                              frameEmailController,
                                          hintText: "msg_your_email_e_g".tr,
                                          margin: getMargin(left: 2, top: 22),
                                          textInputAction: TextInputAction.done,
                                          alignment: Alignment.center,
                                          validator: Validators.validateEmail),
                                      // ADDING PHONE NUMBER FIELD
                                      Padding(
                                          padding: getPadding(
                                              left: 2, top: 40, right: 10),
                                          child: Text("Phone Number",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRubikRomanBold18)),
                                      CustomTextFormField(
                                          width: 319,
                                          focusNode: FocusNode(),
                                          controller:
                                             framePhoneController,
                                          hintText: "011 XXX XXXX ",
                                          margin: getMargin(left: 2, top: 22),
                                          alignment: Alignment.center,
                                          validator: (value) {
                                            if (value.length == 11) {
                                              return null;
                                            }else{
                                              return "Invalid phone number";
                                            }
                                          }),
                                      Padding(
                                          padding: getPadding(
                                              left: 2, top: 35, right: 10),
                                          child: Text("lbl_password".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRubikRomanBold18)),
                                      CustomTextFormField(
                                          width: 319,
                                          focusNode: FocusNode(),
                                          controller: framePasswordController,
                                          hintText: "your password".tr,
                                          margin: getMargin(left: 2, top: 22),
                                          isObscureText: true,
                                          textInputAction: TextInputAction.done,
                                          alignment: Alignment.center,
                                          value:framePasswordController.text),

                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new FlutterPwValidator(
                                          controller: framePasswordController,
                                          minLength: 8,
                                          uppercaseCharCount: 2,
                                          numericCharCount: 3,
                                          specialCharCount: 1,
                                          width: 400,
                                          height: 150,
                                          onSuccess: () {
                                            validPassword = true;
                                          }),

                                      Padding(
                                          padding: getPadding(
                                              left: 2, top: 35, right: 10),
                                          child: Text("ConfirmPassword".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRubikRomanBold18)),
                                      CustomTextFormField(
                                          width: 319,
                                          focusNode: FocusNode(),
                                          controller:
                                              frameConfirmPasswordController,
                                          hintText: "confirm your password".tr,
                                          margin: getMargin(left: 2, top: 22),
                                          isObscureText: true,
                                          textInputAction: TextInputAction.done,
                                          alignment: Alignment.center,
                                          validator: (val) {
                                            if (val.isEmpty)
                                              return 'the field is empty';
                                            if (val !=
                                               framePasswordController
                                                    .text)
                                              return "Password doesn't match";
                                            return null;
                                          },
                                          value:framePasswordController.text),
                                      CustomButton(
                                          onTap: () async {
                                            if (_formKey.currentState!
                                                    .validate() ) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) => Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ));

                                              Email = frameEmailController.text;
                                              Password = framePasswordController.text;
                                              ConfirmPassword = frameConfirmPasswordController.text;
                                              Name =frameNameController.text;
                                              phoneNumber = framePhoneController.text;
                                              print("+++++++++++++++");
                                              print(phoneNumber);

                                              ///we don't need it because the firebase already hashing the password
                                              //Generate Salt
                                              // var generator = RandomStringGenerator(
                                              //   //fixedLength: 10,
                                              //   minLength: 10,
                                              //   maxLength: 25,
                                              // );
                                              // var salt = generator
                                              //     .generate();
                                              // print(salt);

                                              //Hashing
                                              // final hashPass = Crypt
                                              //     .sha256(
                                              //     Password,
                                              //     salt: salt);
                                              // String hashPass2 = hashPass
                                              //     .toString();
                                              // print(
                                              //     hashPass2);

                                              final rsaKeypair =
                                                  RSAKeypair.fromRandom();
                                              publicKey =
                                                  rsaKeypair.publicKey.toPEM();
                                              privateKey =
                                                  rsaKeypair.privateKey.toPEM();
                                              print(
                                                  "The public key is $publicKey");
                                              print(
                                                  "The private key is $privateKey");
                                              //Send PK to local storage
                                              await userSecureStorage
                                                  .setPrivateKey(privateKey);
                                              print(phoneNumber);

                                             if(Password == ConfirmPassword){
                                               try {
                                                 final newuser = await _auth
                                                     .createUserWithEmailAndPassword(
                                                   email: Email.trim(),
                                                   password: Password.trim(),
                                                 );
                                                 _firestore
                                                     .collection("user")
                                                     .doc(newuser.user?.uid)
                                                     .set({
                                                   "uid": newuser.user?.uid,
                                                   "Email": Email,
                                                   "Name": Name,
                                                   "PhoneNumber": phoneNumber,
                                                   "PublicKey": publicKey,
                                                   "friends": [],
                                                   "requests": [],
                                                 });

                                                 newuser.user!
                                                     .sendEmailVerification();
                                                 Navigator.pushNamed(
                                                     context, AppRoutes.verfiy);
                                               } on FirebaseAuthException catch (e) {
                                                 Navigator.pushNamed(context,
                                                     AppRoutes.registerScreen);
                                                 String msg =
                                                 e.message.toString();
                                                 ScaffoldMessenger.of(context)
                                                     .showSnackBar(
                                                   SnackBar(
                                                     action: SnackBarAction(
                                                       label: 'Undo',
                                                       onPressed: () {},
                                                     ),
                                                     content: Text(msg),
                                                     //backgroundColor: Colors.blueGrey,
                                                     duration: const Duration(
                                                         milliseconds: 10000),
                                                     width:
                                                     350.0, // Width of the SnackBar.
                                                     padding: const EdgeInsets
                                                         .symmetric(
                                                       horizontal:
                                                       30.0, // Inner padding for SnackBar content.
                                                     ),
                                                     behavior: SnackBarBehavior
                                                         .floating,
                                                     shape:
                                                     RoundedRectangleBorder(
                                                       borderRadius:
                                                       BorderRadius.circular(
                                                           10.0),
                                                     ),
                                                   ),
                                                 );
                                               }
                                             }else{
                                               ScaffoldMessenger.of(context)
                                                   .showSnackBar(
                                                   SnackBar(
                                                     action: SnackBarAction(
                                                       label: 'Undo',
                                                       onPressed: () {},
                                                     ),
                                                     content: Text("Password doesn't match"),
                                                     //backgroundColor: Colors.blueGrey,
                                                     duration: const Duration(
                                                         milliseconds: 10000),
                                                     width:
                                                     350.0, // Width of the SnackBar.
                                                     padding: const EdgeInsets
                                                         .symmetric(
                                                       horizontal:
                                                       30.0, // Inner padding for SnackBar content.
                                                     ),
                                                     behavior: SnackBarBehavior
                                                         .floating,
                                                     shape:
                                                     RoundedRectangleBorder(
                                                       borderRadius:
                                                       BorderRadius.circular(
                                                           10.0),
                                                     ),
                                                   ));
                                             }

                                              // navigatorkey.currentState!
                                              //     .popUntil(
                                              //         (route) => route.isFirst);
                                            }
                                          },
                                          width: 175,
                                          text: "lbl_register".tr,
                                          margin: getMargin(
                                              left: 66, top: 91, right: 66),
                                          alignment: Alignment.center),
                                      Align(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                              onTap: () {
                                                onTapTxtAlreadyhavean();
                                              },
                                              child: Container(
                                                  margin: getMargin(
                                                      left: 66,
                                                      top: 16,
                                                      right: 64),
                                                  child: RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "msg_already_have_an2"
                                                                    .tr,
                                                            style: TextStyle(
                                                                color:
                                                                    ColorConstant
                                                                        .black900,
                                                                fontSize:
                                                                    getFontSize(
                                                                        11),
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                        TextSpan(
                                                            text: " ",
                                                            style: TextStyle(
                                                                color:
                                                                    ColorConstant
                                                                        .black900,
                                                                fontSize:
                                                                    getFontSize(
                                                                        11),
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        TextSpan(
                                                            text:
                                                                "lbl_login".tr,
                                                            style: TextStyle(
                                                                color:
                                                                    ColorConstant
                                                                        .black900,
                                                                fontSize:
                                                                    getFontSize(
                                                                        11),
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                        TextSpan(
                                                            text: " ",
                                                            style: TextStyle(
                                                                color: ColorConstant
                                                                    .yellow800,
                                                                fontSize:
                                                                    getFontSize(
                                                                        11),
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        TextSpan(
                                                            text: "lbl_here".tr,
                                                            style: TextStyle(
                                                                color: ColorConstant
                                                                    .deepPurple500,
                                                                fontSize:
                                                                    getFontSize(
                                                                        11),
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))
                                                      ]),
                                                      textAlign:
                                                          TextAlign.left))))
                                    ]))),
                      ])))))
    ]))));
  }

  onTapTxtAlreadyhavean() {
    Get.toNamed(AppRoutes.loginScreen);
  }
}

import 'dart:developer';

import 'package:application1/classes/add.dart';
import 'package:application1/presentation/profile_screen/profile_screen.dart';
import 'package:application1/widgets/custom_floating_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../classes/Utils.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../home_screen/home_screen.dart';
import 'controller/addfriend_controller.dart';
//import 'package:application2/core/app_export.dart';
//import 'package:application2/core/utils/validation_functions.dart';
//import 'package:application2/widgets/custom_button.dart';
//import 'package:application2/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:application1/classes/validators.dart';


class AddfriendScreen extends GetWidget<AddfriendController> {
  User? user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  Color primaryColor = Color(0xff4338CA);
  Color secondaryColor = Colors.black;
  Color accentColor = Color(0xffffffff);
  Color backgroundColor = Color(0xffffffff);
  Color errorColor = Color(0xffEF4444);


  String email = "";
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Container(
              width: 40,
              child: CommonImageView(
                  imagePath: ImageConstant.imgTipplerlogore61X54)),
          automaticallyImplyLeading: false,
          //title: Text('Home Page'),
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
                // alignment: Alignment.centerLeft,
                child: Container(
                    height: getVerticalSize(199.00),
                    width: size.width,
                    child: Stack(alignment: Alignment.bottomLeft, children: [
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
                                  left: 44, top: 12, right: 44, bottom: 12),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                            height: getVerticalSize(109.00),
                                            width: getHorizontalSize(241.00),
                                            margin: getMargin(top: 7),
                                            child: Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  // Align(
                                                  //     alignment: Alignment.bottomLeft,
                                                  //     child: Padding(padding: getPadding(top: 10, right: 10), child: CommonImageView(imagePath: ImageConstant.imgTipplerlogore61X54, height: getVerticalSize(61.00), width: getHorizontalSize(54.00)))),
                                                  Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Padding(
                                                          padding: getPadding(
                                                              left: 10,
                                                              bottom: 10),
                                                          child: StreamBuilder(
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'user')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                                  .snapshots(),
                                                              builder: (context,
                                                                  AsyncSnapshot<
                                                                          DocumentSnapshot<
                                                                              Map<String, dynamic>>>
                                                                      snapshot) {
                                                                return Text(
                                                                    'Add Friend',
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
                        validator: Validators
                            .validateEmail,
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
                          fillColor: Colors.transparent,
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
                      padding: const EdgeInsets.all(5.0),
                      child: CustomButton(
                        onTap: () async {
                          if (emailController.text.isNotEmpty &&
                              emailController.text.toLowerCase() !=
                                  FirebaseAuth.instance.currentUser!.email!) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });

                            log("called");
                            email = emailController.text;
                            emailController.clear();
                            List requests = [];
                            Add().getFriendData(email).then((value) {
                              Get.back();
                            });
                          } else {
                            Utils.toastMessage('Email cann\'t be Empty');
                          }
                        },
                        width: 175,
                        text: "ADD FRIEND",
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(3.0),
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal:10.0),
                      child:Container(
                          height:1.0,
                          width:300.0,
                          color:Colors.black),)
                   , Padding(
    padding: getPadding(
    left: 10, top: 8, right: 10),
    child: Text("New friendship request",
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
    style: AppStyle
        .txtRubikRomanBold18)),
                  ],


                ),
              ),

            ),
              Expanded(
                child: FutureBuilder(
                  future:
                  Add().getRequests(FirebaseAuth.instance.currentUser!.email!),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      log(snapshot.data.toString());
                      return snapshot.data.length > 0
                          ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          String text = snapshot.data[index].name;
                          String email = snapshot.data[index].email;
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 75,
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.5),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(10, 20),
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          color:
                                          Colors.grey.withOpacity(.05)),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Image(
                                          image: AssetImage('assets/images/person.jpg'),
                                          height: 59,
                                          fit: BoxFit.cover),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(text,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          )),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return Center(
                                                  child:
                                                  CircularProgressIndicator(),
                                                );
                                              });

                                          await Add().addFrind(email);
                                          Get.back();
                                        },
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 35,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          int result = await Add()
                                              .declineRequest(email);
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                          size: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      )
                          : Center(
                        child: Text("No Request "),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),

          ],

        ),

        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: getVerticalSize(98.00),
            width: size.width,
            // margin: getMargin(top: 107),
            decoration: AppDecoration.fillWhiteA700,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CommonImageView(
                          svgPath: ImageConstant.imgVector1,
                          height: getVerticalSize(79.00),
                          width: getHorizontalSize(375.00)),
                    )),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                        getPadding(left: 50, top: 3, right: 50, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: getPadding(left: 1),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                      padding: getPadding(top: 6, bottom: 7),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => HomeScreen())  ;                                      },
                                        child: CommonImageView(
                                            svgPath: ImageConstant.imgGroup1046,
                                            height: getSize(30.00),
                                            width: getSize(30.00)),
                                      )),
                                  CustomFloatingButton(
                                      // onTap: () {
                                      //   Get.to(() => AddfriendScreen());
                                      // },
                                      height: 46,
                                      width: 46,
                                      child: CommonImageView(
                                          svgPath: ImageConstant.imgUser46X46,
                                          height: getVerticalSize(23.00),
                                          width: getHorizontalSize(23.00))),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          profile_screen(
                                              uid: FirebaseAuth
                                                  .instance.currentUser!.uid),
                                          transition: Transition.rightToLeft);
                                    },
                                    child: CommonImageView(
                                        svgPath: ImageConstant.imgUser,
                                        height: getSize(43.00),
                                        width: getSize(43.00)),
                                  )
                                ])),
                        Padding(
                          padding: getPadding(top: 2, right: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text("lbl_home".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRubikRomanRegular12
                                      .copyWith(letterSpacing: 0.24)),
                              Text("lbl_profile".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRubikRomanRegular12
                                      .copyWith(letterSpacing: 0.24))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

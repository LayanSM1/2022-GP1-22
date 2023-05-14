import 'package:application1/core/app_export.dart';
import 'package:application1/presentation/home_screen/home_screen.dart';
import 'package:application1/presentation/login_screen/login_screen.dart';
import 'package:application1/presentation/profile_screen/profile_edit_screen.dart';
import 'package:application1/widgets/custom_floating_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/common_image_view.dart';
import '../add_friend_screen/addfriend_screen.dart';

class profile_screen extends StatefulWidget {
  String uid;
  profile_screen({required this.uid});

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  var userData1 = {};
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData1();
  }

  getData1() async {
    setState(() {
      isLoading = true;
    });

    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        userData1 = Usersnap.data()!;
      });
    } catch (e) {}

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                  left: 44, top: 5, right: 44, bottom: 12),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

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
                                                                    'My Profile',
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
      Padding(
          padding: getPadding(
               top: 5,),
             child:Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image : DecorationImage(
                      image: AssetImage('assets/images/userIcon.png'),
                      fit: BoxFit.fitWidth
                  ),
                )
            ),),
            SizedBox(
              height: 5,
            ),
            SizedBox(height: 10.0),
            cons(type: 'Name', text: userData1['Name']),
            cons(type: 'Number', text: userData1['PhoneNumber']),
            cons(type: 'Email', text: userData1['Email']),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(profile_edit_screen(
                      email: userData1['Email'],
                      name: userData1['Name'],
                      number: userData1['PhoneNumber'],
                      uid: userData1['uid']));
                },
                child: Text('Edit Profile')),
          ],
        ),
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
                  padding: getPadding(left: 50, top: 3, right: 50, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: getPadding(left: 1),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                    padding: getPadding(top: 6, bottom: 7),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => HomeScreen())  ;                                        },
                                      child: CommonImageView(
                                          svgPath: ImageConstant.imgGroup1046,
                                          height: getSize(30.00),
                                          width: getSize(30.00)),
                                    )),
                                CustomFloatingButton(
                                    onTap: () {
                                      Get.to(() => AddfriendScreen());
                                    },
                                    height: 46,
                                    width: 46,
                                    child: CommonImageView(
                                        svgPath: ImageConstant.imgUser46X46,
                                        height: getVerticalSize(23.00),
                                        width: getHorizontalSize(23.00))),
                                GestureDetector(
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
    ));
  }
}

class cons extends StatelessWidget {
  String type;
  String text;
  cons({required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 12,
            ),
            Text(
              "$type:",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          height: 50,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4, 5),
                  spreadRadius: 1,
                  blurRadius: 8,
                )
              ]),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                '$text',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 12.0),
      ],
    );
  }
}

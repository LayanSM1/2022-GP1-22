// ignore_for_file: dead_code

import 'package:application1/classes/Utils.dart';
import 'package:application1/core/utils/image_constant.dart';
import 'package:application1/widgets/common_image_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../widgets/custom_floating_button.dart';
import '../UpdatePassword.dart';
import '../add_friend_screen/addfriend_screen.dart';
import '../home_screen/home_screen.dart';

class profile_edit_screen extends StatefulWidget {
  String email;
  String uid;
  String name;
  String number;
  profile_edit_screen(
      {required this.email,
      required this.name,
      required this.number,
      required this.uid});

  @override
  State<profile_edit_screen> createState() => _profile_edit_screenState();
}

class _profile_edit_screenState extends State<profile_edit_screen> {
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

  bool nameError = false;
  bool error = false;
  String countryCode = '';
  bool password = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameC = TextEditingController(
      text: userData1['Name'],
    );
    TextEditingController Password = TextEditingController();
    TextEditingController emailC = TextEditingController(
      text: userData1['Email'],
    );
    TextEditingController numberC = TextEditingController(
      text: userData1['PhoneNumber'],
    );
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
          child: Column(children: [
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
                                                                    'Edit profile',
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
            SizedBox(
              height: 8,
            ),
            SizedBox(height: 12.0),
            Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Padding(
                    padding: getPadding(
                        left: 2, top: 40, right: 10),
                    child: Text("lbl_name".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle
                            .txtRubikRomanBold18)),
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: nameC,
                decoration: InputDecoration(
                  errorText: nameError == true
                      ? "Username must contain at least 4 characters"
                      : null,
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(12.0),
                  // ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Padding(padding: const EdgeInsets.all(5.0),
                ),
                Padding(
                    padding: getPadding(
                        left: 2, top: 40, right: 10),
                    child: Text("Phone Number",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle
                            .txtRubikRomanBold18)),
              ],
            ),
            SizedBox(height: 12.0),
            _phonNumber(numberC),
            Row(children: [
              SizedBox(
                width: 12,
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (nameC.text.length < 4) {
                    setState(() {
                      nameError = true;
                    });
                  } else if (numberC.text.length < 7) {
                    setState(() {
                      error = true;
                    });
                  } else if (numberC.text.length > 13) {
                    setState(() {
                      error = true;
                    });
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    await FirebaseFirestore.instance
                        .collection('user')
                        .doc(widget.uid)
                        .update({
                      "PhoneNumber": '$countryCode${numberC.text}',
                      "Name": nameC.text,
                    });
                    Utils.toastMessage('Your profile edit Successfully');
                    Get.back();
                  }
                },
                child: Text('Edit Profile')),
             ElevatedButton(


                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,  // foreground
                ),
                onPressed: () {Get.to(UpdatePasWidget());
                },
                child: Text('Update Password',style: TextStyle(
                  fontSize: 16,
                ),
                ))

          ]),
        )

           , bottomNavigationBar: BottomAppBar(
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
                                    Get.to(() => HomeScreen())  ;                                    },
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

  Widget _phonNumber(TextEditingController number) {
    return new Container(
        padding: const EdgeInsets.all(7.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 110,
                height: 50,
                child: CountryCodePicker(
                  onChanged: (e) {
                    print(e.toLongString());
                    print(e.name);
                    print(e.code);
                    print(e.dialCode);
                    setState(() {
                      countryCode = e.dialCode!;
                    });
                  },
                  initialSelection: 'العربية السعودية',
                  showFlagMain: true,
                  showFlag: true,
                  favorite: ['+966', 'العربية السعودية'],
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: TextFormField(
                    controller: number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      // labelText: 'Mobile Number',
                      errorText:
                          error ? 'phone length should be proper.' : null,
                      prefix: Text("$countryCode"),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) return 'the field is empty';
                      if (val.length < 9)
                        return "Phone Number should be 9 digits";
                      if (val.length > 9)
                        return "Phone Number should be 9 digits";
                      return null;
                    },
                    onEditingComplete: () {
                      // FocusScope.of(context).requestFocus(FocusNode());
                    },

                  ),
                ),
              ),
            ]));
  }
}

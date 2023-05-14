import 'dart:developer';
import 'package:application1/presentation/private_chat_screen/private_chat_screen.dart';
import 'package:application1/presentation/profile_screen/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../classes/add.dart';
import '../add_friend_screen/addfriend_screen.dart';
import '../login_screen/login_screen.dart';
import 'controller/home_controller.dart';
import 'package:application1/core/app_export.dart';
import 'package:application1/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:application1/classes/secureStorage.dart';


class HomeScreen extends GetWidget<HomeController> {
  final _firestore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;
   bool b=false;

  final _auth = FirebaseAuth.instance;
  late User signedinuser;
  bool boo = false;
  RSAPrivateKey? MyPrivateKey;
  void getcurrentuser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedinuser = user;
        print(signedinuser.email);
        boo = true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
  Future<void> getPrivatekey() async {
    try {

      final myPrivateKeyString = await userSecureStorage.getPrivateKey() ?? "";
      MyPrivateKey=RSAPrivateKey.fromString(myPrivateKeyString);
      print("my private key from secure storage ");
      print(MyPrivateKey.toString());
      }
    catch(e) {
      print(e);
    }
  }
  var userData1 = {};
  bool isLoading = false;

  getData1() async {
    isLoading = true;

    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData1 = Usersnap.data()!;
    } catch (e) {}

    isLoading = false;
  }
  getRequests() async {
    List<dynamic> requests = [];
    await _firestore.collection('user').doc(_currentUser).get().then(
          (value) {
        requests = value.data()!["requests"];
        log(value.data()!["requests"].toString());
      },
    );
    if (requests.isNotEmpty){
      b= true;}else
    { b= false;}
  }




  @override
  Widget build(BuildContext context) {
    getcurrentuser();
    getData1();
    getRequests();
    if (boo == false) return LoginScreen();
    getPrivatekey();





    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 227, 225, 225),
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
                _auth.signOut();
                Navigator.pushNamed(context, AppRoutes.loginScreen);
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body:
            Column(

              children: [

             Container(
            height: getVerticalSize(199.00),
          width: size.width,
          child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
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
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 19, right: 19),
                                      child: Text("lbl_hello".tr,
                                          overflow: TextOverflow
                                              .ellipsis,
                                          textAlign:
                                          TextAlign.left,
                                          style: AppStyle
                                              .txtQuicksandBold32))),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      height:
                                      getVerticalSize(109.00),
                                      width: getHorizontalSize(
                                          241.00),
                                      margin: getMargin(top: 7),
                                      child: Stack(
                                          alignment:
                                          Alignment.topRight,
                                          children: [
                                            Align(
                                                alignment:
                                                Alignment
                                                    .topRight,
                                                child: Padding(
                                                    padding:
                                                    getPadding(
                                                        left:
                                                        10,
                                                        bottom:
                                                        10),
                                                    child:
                                                    StreamBuilder(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection('user')
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .snapshots(),
                                                        builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                                                          return Text(snapshot.data?['Name'],
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.left,
                                                              style: AppStyle.txtQuicksandBold48);
                                                        })))
                                          ])))
                            ])))
              ])),
              Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('chats')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    // log(snapshot.data.toString());
                    return snapshot.data!.docs.length > 0
                        ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var snap = snapshot.data!.docs[index].data();
                        String friend_name=snap['name'];
                        String friend_email=snap['email'];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: GestureDetector(
                            onLongPress: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(

                                      child: Container(
                                        height: 120,
                                        color: Colors.white,
                                        child:Column (
                                            children:[
                                         ListTile(
                                          onTap: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: const Text(
                                                        'Delete Friend'),
                                                    content:  Text(
                                                        'Do you really want to delete your friend '+friend_name+'??'
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context,
                                                              'Cancel');
                                                        },
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: ()
                                      async {
                                      await FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(FirebaseAuth.instance
                                          .currentUser!.uid)
                                          .update({
                                      "friends":
                                      FieldValue.arrayRemove(
                                      [snap['email']]),
                                      });
                                      await FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(snap['uid'])
                                          .update({
                                      "friends":
                                      FieldValue.arrayRemove([
                                      FirebaseAuth.instance
                                          .currentUser!.email
                                      ]),
                                      });
                                      // Get.back();
                                      // showDialog(
                                      //     context: context,
                                      //     barrierDismissible: false,
                                      //     builder: (context) {
                                      //       return Center(
                                      //         child:
                                      //             CircularProgressIndicator(),
                                      //       );
                                      //     });
                                      // doNothing(snap['uid']);
                                      // doNothing1(snap['uid']);
                                      FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(FirebaseAuth.instance
                                          .currentUser!.uid)
                                          .collection('chats')
                                          .doc(snap['uid'])
                                          .collection('ImgChat')
                                          .snapshots()
                                          .forEach((querySnapshot) {
                                      for (QueryDocumentSnapshot docSnapshot
                                      in querySnapshot.docs) {
                                      docSnapshot.reference
                                          .delete();
                                      }
                                      });
                                      FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(snap['uid'])
                                          .collection('chats')
                                          .doc(FirebaseAuth.instance
                                          .currentUser!.uid)
                                          .collection('ImgChat')
                                          .snapshots()
                                          .forEach((querySnapshot) {
                                      for (QueryDocumentSnapshot docSnapshot
                                      in querySnapshot.docs) {
                                      docSnapshot.reference
                                          .delete();
                                      }
                                      });
                                      await FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(FirebaseAuth.instance
                                          .currentUser!.uid)
                                          .collection('chats')
                                          .doc(snap['uid'])
                                          .delete();
                                      await FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(snap['uid'])
                                          .collection('chats')
                                          .doc(FirebaseAuth.instance
                                          .currentUser!.uid)
                                          .delete();

                                          Navigator.pop(
                                                              context, 'Ok');
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
                                          Text('Your friend deleted successfully'),
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
                                                        },

                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                            );
                                          }


                                          ,leading: Icon(Icons.delete),
                                          title: Text(
                                            'Delete Friend',
                                          ),
                                        ),
                                              ListTile(
                                            onTap: () {
                                              showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) => AlertDialog(
                                                  title: const Text('Update Secret Key'),
                                                  content:  Text('Do you really want to update the Secret Key with'+friend_name+'?? Your all previous messages cann\'t be opened '),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context, 'Cancel');},
                                                      child: const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        await Add().UpdateKey(friend_email);
                                                        Navigator.pop(context, 'Ok');
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
                                                            Text('The secret key updated successfully'),
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
                                                      },

                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                              //
                                            }
                                           , leading: Image( image:AssetImage('assets/images/key.png')
                                                ,  height: 20,
                                                  width: 20,
                                              ),
                                            title: Text(
                                              'Update Secret Key',
                                            ),
                                          ),
                                      ]

                                        )


                                      ),


                                    );
                                  });
                            },
                            child: CardFb2(
                                read: snap['read'],
                                url: snap['uid'],
                                text: snap['name'],
                                onPressed: () {
                                  log("tapped");
                                  Get.to(
                                    PrivateChatScreen(
                                        name: snap['name'],
                                        uid: snap['uid']),
                                  );
                                }),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: Text("you don't have friend yet"),
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
                    child: CommonImageView(
                        svgPath: ImageConstant.imgVector1,
                        height: getVerticalSize(79.00),
                        width: getHorizontalSize(375.00))),
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
                                      child: CommonImageView(
                                          svgPath: ImageConstant.imgGroup1046,
                                          height: getSize(30.00),
                                          width: getSize(30.00))),

                                  if (b) ...[
                                    CustomFloatingButton(
                                      onTap: () {

                                        Get.to(() => AddfriendScreen());
                                      },
                                      height: 46,
                                      width: 46,
                                      child: CommonImageView(
                                          imagePath:'assets/images/user.png',
                                          height: 30,
                                          width: 30),),
                                  ] else ...[
                                    CustomFloatingButton(
                                      onTap: () {
                                        Get.to(() => AddfriendScreen());
                                      },
                                      height: 46,
                                      width: 46,
                                      child: CommonImageView(
                                          svgPath: ImageConstant.imgUser46X46,
                                          height: getVerticalSize(23.00),
                                          width: getHorizontalSize(23.00)),),
                                  ],


                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          profile_screen(
                                              uid: _auth.currentUser!.uid),
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
      ));

  }


}
class CardFb2 extends StatelessWidget {
  final String text;
  final String? imageUrl;
  final bool read;
  final String? subtitle;
  final String? url;
  final Function()? onPressed;

  const CardFb2(
      {required this.text,
        this.imageUrl,
        this.url,
        required this.read,
        this.subtitle,
        required this.onPressed,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 75,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 5,
                spreadRadius: 1,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Row(
          children: [
            Image(
                image: AssetImage('assets/images/person.jpg'),
                height: 59,
                fit: BoxFit.cover,),
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
            Row(
              children: [
                read == true
                    ? CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.blue,
                )
                    : Container(),
                SizedBox(
                  width: 5,
                ),
                // read == true
                //     ? Text(
                //   "",
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(
                //       color: Colors.blue,
                //       fontWeight: FontWeight.normal,
                //       fontSize: 12),
                // )
                //     : Text(
                //   "",
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(
                //       color: Colors.grey,
                //       fontWeight: FontWeight.normal,
                //       fontSize: 12),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




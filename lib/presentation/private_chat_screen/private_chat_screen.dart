// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';
import 'dart:io';

import 'package:application1/classes/Utils.dart';
import 'package:application1/presentation/add_friend_screen/models/friend_model.dart';
import 'package:application1/presentation/add_friend_screen/models/sendImage.dart';
import 'package:application1/presentation/private_chat_screen/camera_screen.dart';
import 'package:application1/presentation/private_chat_screen/secretmsg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'controller/private_chat_controller.dart';
import 'package:application1/core/app_export.dart';
import 'package:application1/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PrivateChatScreen extends StatefulWidget {
  String uid;
  String name;

  PrivateChatScreen({required this.uid, required this.name});

  @override
  State<PrivateChatScreen> createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  TextEditingController chatController = TextEditingController();

  ScrollController listScrollController = ScrollController();

  String myName = "";
  bool? status = false;
  bool visible = true;
  bool ignore = false;

  @override
  void initState() {
    super.initState();
    // _scrollToBottom();
  }

  getImage(String msg) async {}

  Future uploadImage(String path, String msg) async {
    Utils.toastMessage("sending image");
    String fileName = Uuid().v1();

    var ref =
    FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(File(path));
    String imgUrl = await uploadTask.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chats")
        .doc(widget.uid)
        .collection('ImgChat')
        .doc(fileName)
        .set({"user": myName, "link": imgUrl.toString()});
    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.uid)
        .collection("chats")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('ImgChat')
        .doc(fileName)
        .set({"user": myName, "link": imgUrl.toString()});
    setState(() {});

    Utils.toastMessage("complete");

    log(imgUrl);
  }

  fetchImages() async {
    var imgList = [];
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chats")
        .doc(widget.uid)
        .collection('ImgChat')
        .orderBy("time", descending: false)
        .get()
        .then((value) {
      imgList.clear();
      value.docs.forEach((value) {
        imgList.add(value.data());
      });

      // log(imgList.toString());
    });

    return imgList;
  }

  String key = '';
  getChat() async {
    await FirebaseFirestore.instance
        .collection('user')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      myName = value.docs[0].data()["Name"];
    });
    List<Map<String, dynamic>> chatData = [];
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chats")
        .doc(widget.uid)
        .get()
        .then(
          (value) {
        value.data()?.forEach(
              (key, value) {
            chatData.add({key: value});
          },
        );
      },
    );
    //log(chatData.toString());
    // chatData.length == 0 ? ignore = false : true;
    // chatData.length > 0 ? ignore = true : null;
    chatData[2]["status"] == "true"
        ? status = true
        : chatData[0]["status"] == "true"
        ? status = true
        : chatData[1]["status"] == "true"
        ? status = true
        : chatData[3]["status"] == "true"
        ? status = true
        : chatData[4]["status"] == "true"
        ? status = true
        : chatData[5]["status"] == "true"
        ? status = true
        : chatData[6]["status"] == "true"
        ? status = true
        : status = false;

    if (chatData[0]["key"] != null) {
      key = chatData[0]["key"];
    } else if (chatData[1]["key"] != null) {
      key = chatData[1]["key"];
    } else if (chatData[2]["key"] != null) {
      key = chatData[2]["key"];
    } else if (chatData[3]["key"] != null) {
      key = chatData[3]["key"];
    } else if (chatData[4]["key"] != null) {
      key = chatData[4]["key"];
    } else if (chatData[5]["key"] != null) {
      key = chatData[5]["key"];
    } else {
      key = chatData[6]["key"];
    }
    chatData[2]["status"] == "true"
        ? visible = false
        : chatData[0]["status"] == "true"
        ? visible = false
        : chatData[1]["status"] == "true"
        ? visible = false
        : chatData[3]["status"] == "true"
        ? visible = false
        : chatData[4]["status"] == "true"
        ? visible = false
        : chatData[5]["status"] == "true"
        ? visible = false
        : chatData[6]["status"] == "true"
        ? visible = false
        : visible = true;

    setState(() {});
    // log(chatData.toString());
    return chatData;
  }

  _scrollToBottom() {
    listScrollController.jumpTo(listScrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(247, 222, 221, 221),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(widget.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtRubikRegular18),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // if (status == false)
            //   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //     status == true
            //         ? Text("You can send photos")
            //         : status == false
            //             ? GestureDetector(
            //                 onTap: () async {
            //                   log("tap");
            //                   FirebaseFirestore.instance
            //                       .collection("user")
            //                       .doc(FirebaseAuth.instance.currentUser!.uid)
            //                       .collection("chats")
            //                       .doc(widget.uid)
            //                       .delete();
            //                   FirebaseFirestore.instance
            //                       .collection("user")
            //                       .doc(widget.uid)
            //                       .collection("chats")
            //                       .doc(FirebaseAuth.instance.currentUser!.uid)
            //                       .delete();
            //                   setState(() {});
            //                 },
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text("declined request (tap to retry)"),
            //                 ))
            //             : SizedBox()
            //   ]),
            Visibility(
              visible: visible,
              child: Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: getChat(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // if (snapshot.data.length == 2) {
                      //   if (snapshot.data[1]["status"] == "true") {
                      //     setState(() {
                      //       visible = false;
                      //     });
                      //   }
                      // }
                      return ListView(
                        children: [
                          if (snapshot.data.length == 2)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                snapshot.data[2]["status"] == "true"
                                    ? Text("You can send photos")
                                    : GestureDetector(
                                    onTap: () async {
                                      log("tap");
                                      FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                          .collection("chats")
                                          .doc(widget.uid)
                                          .delete();
                                      FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(widget.uid)
                                          .collection("chats")
                                          .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                          .delete();
                                      // visible = true;
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "declined request (tap to retry)"),
                                    )),
                              ],
                            ),
                          if (snapshot.data.length == 1)
                            snapshot.data.length != 0
                                ? snapshot.data.length < 3 &&
                                snapshot.data[0][myName] == null
                                ? Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10),
                                      child: Container(
                                        width: size.width * 0.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                          color: snapshot.data[0]
                                          [widget.name] ==
                                              null
                                              ? Color.fromARGB(
                                              255, 255, 255, 255)
                                              : Colors.blue,
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              8.0),
                                          child: Text(
                                            snapshot
                                                .data[0][snapshot.data[
                                            0][
                                            widget
                                                .name] !=
                                                null
                                                ? widget.name
                                                : myName]
                                                .toString(),
                                            style: TextStyle(
                                              color: snapshot.data[0][
                                              widget
                                                  .name] ==
                                                  null
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: getFontSize(
                                                20,
                                              ),
                                              fontFamily: 'Rubik',
                                              fontWeight:
                                              FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                  mainAxisAlignment: snapshot.data[0]
                                  [widget.name] ==
                                      null
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    snapshot.data[0]
                                    [widget.name] ==
                                        null
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          var key =
                                          await FlutterAesEcbPkcs5
                                              .generateDesKey(
                                              128);
                                          await FirebaseFirestore
                                              .instance
                                              .collection("user")
                                              .doc(FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid)
                                              .collection("chats")
                                              .doc(widget.uid)
                                              .update(
                                            {
                                              "status": "true",
                                              "key": key,
                                            },
                                          );
                                          await FirebaseFirestore
                                              .instance
                                              .collection("user")
                                              .doc(widget.uid)
                                              .collection("chats")
                                              .doc(FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid)
                                              .update(
                                            {
                                              "status": "true",
                                              "key": key
                                            },
                                          );
                                          print(key);
                                          // setState(() {});
                                        },
                                        child: Container(
                                          height: 25,
                                          width: size.width * 0.17,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(5)),
                                          child: Center(
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color:
                                                  Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await FirebaseFirestore
                                              .instance
                                              .collection("user")
                                              .doc(FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid)
                                              .collection("chats")
                                              .doc(widget.uid)
                                              .update(
                                            {"status": "false"},
                                          );
                                          await FirebaseFirestore
                                              .instance
                                              .collection("user")
                                              .doc(widget.uid)
                                              .collection("chats")
                                              .doc(FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid)
                                              .update(
                                            {"status": "false"},
                                          );
                                        },
                                        child: Container(
                                          height: 25,
                                          width: size.width * 0.17,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(5)),
                                          child: Center(
                                              child: Text(
                                                "Decline",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                                : snapshot.data[0][myName] != null
                                ? Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10),
                                  child: Container(
                                    width: size.width * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      color: snapshot.data[0]
                                      [widget.name] ==
                                          null
                                          ? Color.fromARGB(
                                          255, 255, 255, 255)
                                          : Colors.blue,
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(
                                          8.0),
                                      child: Text(
                                        snapshot
                                            .data[0][snapshot.data[
                                        0][
                                        widget
                                            .name] !=
                                            null
                                            ? widget.name
                                            : myName]
                                            .toString(),
                                        style: TextStyle(
                                          color: snapshot.data[0][
                                          widget
                                              .name] ==
                                              null
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: getFontSize(
                                            20,
                                          ),
                                          fontFamily: 'Rubik',
                                          fontWeight:
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                              mainAxisAlignment: snapshot.data[0]
                              [widget.name] ==
                                  null
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                            )
                                : SizedBox()
                                : SizedBox(),
                          if (snapshot.data.length > 1 &&
                              snapshot.data[0][myName] != null)
                            snapshot.data[1]["status"] != null
                                ? snapshot.data[1]["status"] == "true"
                                ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Container(
                                    width: size.width * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color: Colors.blue,
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${widget.name} accepted request",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getFontSize(
                                            20,
                                          ),
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                            )
                                : snapshot.data[1]["status"] == "false"
                                ? Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10),
                                  child: Container(
                                    width: size.width * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      color: Colors.blue,
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(
                                          8.0),
                                      child: Text(
                                        "${widget.name} declined request",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getFontSize(
                                            20,
                                          ),
                                          fontFamily: 'Rubik',
                                          fontWeight:
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(FirebaseAuth
                                          .instance
                                          .currentUser!
                                          .uid)
                                          .collection("chats")
                                          .doc(widget.uid)
                                          .delete();
                                      FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(FirebaseAuth
                                          .instance
                                          .currentUser!
                                          .uid)
                                          .collection("chats")
                                          .doc(widget.uid)
                                          .delete();
                                    },
                                    child: Text("tap to retry")),
                              ],
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                            )
                                : SizedBox()
                                : SizedBox(),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            if (status == true)
              Expanded(
                flex: 3,
                child: FutureBuilder(
                  future: fetchImages(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    FirebaseFirestore.instance
                        .collection('user')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('chats')
                        .doc(widget.uid)
                        .update({
                      "read": false,
                    });
                    if (snapshot.hasData) {
                      return ListView.builder(
                        controller: listScrollController,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  snapshot.data[index]['user'] == myName
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: snapshot.data[index]['user'] ==
                                            myName
                                            ? Colors.blue
                                            : Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          height: 200,
                                          width: 300,
                                          // color: Colors.red,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {

                                              Get.to(secretMsg(
                                                secretKey: key,
                                                url: snapshot.data[index]
                                                ['link'],
                                              ));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              child: Image.network(
                                                snapshot.data[index]['link'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      snapshot.data[index]['user'] == myName
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat.jm().format(snapshot
                                              .data[index]['time']
                                              .toDate()),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          DateFormat.yMd().format(snapshot
                                              .data[index]['time']
                                              .toDate()),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
            notchMargin: 20,
            shape: CircularNotchedRectangle(),
            child: Container(
              height: size.height * 0.08,
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      log("tap");
                      final position =
                          listScrollController.position.maxScrollExtent;
                      listScrollController.jumpTo(position);
                    },
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 50,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomFloatingButton(
          onTap: () async {
            if (status == null)
              Utils.toastMessage("Secret code not accepted yet");
            if (status == false) Utils.toastMessage("Secret code declined");

            if (status == true) {
              File? image;

              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                      height: 113,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 51, 51, 51),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),

                      //uplode or take image :
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Get.to(camera_screen(
                                  key1: key, myName: myName, uid: widget.uid));
                            },
                            leading: Icon(
                              Icons.camera_alt,
                              color: Colors.blue,
                            ),
                            title: Text(
                              'Camera',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 380,
                            color: Colors.blue,
                          ),
                          ListTile(

                            onTap: () async {

                              try {
                                final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if(image == null) return;
                                final imageTemp = File(image.path);


                                Get.to(sendImage(
                                  imagepath: imageTemp,
                                  Secretkey: key,
                                  path: imageTemp.path,
                                  uid: widget.uid,
                                  myName: myName,
                                ));
                              } on PlatformException catch(e) {
                                print('Failed to pick image: $e');
                              }

                            },
                            leading: Icon(
                              Icons.photo,
                              color: Colors.blue,
                            ),
                            title: Text(
                              'Library',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });

            }
            log("satttat" + status.toString());
          },
          height: 58,
          width: 58,
          shape: FloatingButtonShape.CircleBorder29,
          child: CommonImageView(
            svgPath: ImageConstant.imgComputer58X58,
            height: getVerticalSize(29.00),
            width: getHorizontalSize(29.00),
          ),
        ),
      ),
    );
  }

  onTapImgArrowleft() {
    Get.back();
  }
}

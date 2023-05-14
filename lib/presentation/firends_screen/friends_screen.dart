import 'dart:developer';

import 'package:application1/presentation/firends_screen/requests_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/add.dart';
import '../../core/utils/size_utils.dart';
import '../private_chat_screen/private_chat_screen.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  var userData1 = {};
  bool isLoading = false;

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
  void initState() {
    // TODO: implement initState
    getData1();
    super.initState();
  }

  // Future doNothing(String otherId) async {
  //   var collection = FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('Chats')
  //       .doc(otherId)
  //       .collection('ImgChat');
  //   var snapshot = await collection.get();
  //   for (var doc in snapshot.docs) {
  //     await doc.reference.delete();
  //   }
  // }

  // Future doNothing1(String otherId) async {
  //   var collection = FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(otherId)
  //       .collection('Chats')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('ImgChat');
  //   var snapshot = await collection.get();
  //   for (var doc in snapshot.docs) {
  //     await doc.reference.delete();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Your Friends",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: getFontSize(
              20,
            ),
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Row(
            children: [
              isLoading
                  ? Container()
                  : userData1['requests'].length == 0
                      ? Container()
                      : Text(
                          '(${userData1['requests'].length})',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
              GestureDetector(
                onTap: () {
                  Get.to(RequestsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.person_add),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
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
                                            height: 50,
                                            color: Colors.white,
                                            child: ListTile(
                                              onTap: () async {
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

                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                              height: 180,
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius:
                                                                          28,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      'Your Friend Successfully Deleted form both side',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Get.back();
                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            120,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.blue,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            'Dismiss',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ])));
                                                    });
                                              },
                                              leading: Icon(Icons.delete),
                                              title: Text(
                                                'Delete Friend',
                                              ),
                                            ),
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
                          child: Text("No Friend Found"),
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
    );
  }
}

// fetchImages(String uid) async {
//   var imgList = [];
//   await FirebaseFirestore.instance
//       .collection("user")
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection("chats")
//       .doc(uid)
//       .collection('ImgChat')
//       .orderBy("time", descending: false)
//       .get()
//       .then((value) {
//     imgList.clear();
//     value.docs.forEach((value) {
//       imgList.add(value.data());
//     });
//
//     // log(imgList.toString());
//   });
// }

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
          color: Colors.white,
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
            Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Emblem-person-blue.svg/1200px-Emblem-person-blue.svg.png",
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
                read == true
                    ? Text(
                        "Friends",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                      )
                    : Text(
                        "Friends",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

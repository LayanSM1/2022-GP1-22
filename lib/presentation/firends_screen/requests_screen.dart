import 'dart:developer';

import 'package:application1/presentation/add_friend_screen/models/friend_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/add.dart';
import '../../core/utils/size_utils.dart';
import '../private_chat_screen/private_chat_screen.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    Add().getUserData(FirebaseAuth.instance.currentUser!.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Your Requests",
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
        // actions: [
        //   // GestureDetector(
        //   //   onTap: () {
        //   //     Get.to(RequestsScreen());
        //   //   },
        //   //   child: Padding(
        //   //     padding: const EdgeInsets.all(8.0),
        //   //     child: Icon(Icons.person_add),
        //   //   ),
        //   // ),
        // ],
      ),
      body: Column(
        children: [
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
                                            setState(() {});
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
                                            setState(() {});
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
                          child: Text("No Request Found"),
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

// class RequestsCard extends StatelessWidget {
//   final String text;
//   final String email;
//   final String? imageUrl;
//   final String? subtitle;
//   final Function()? onPressed;
//
//   const RequestsCard(
//       {required this.text,
//       required this.email,
//       this.imageUrl,
//       this.subtitle,
//       required this.onPressed,
//       Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: 75,
//         padding: const EdgeInsets.all(15.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.5),
//           boxShadow: [
//             BoxShadow(
//                 offset: const Offset(10, 20),
//                 blurRadius: 5,
//                 spreadRadius: 1,
//                 color: Colors.grey.withOpacity(.05)),
//           ],
//         ),
//         child: Row(
//           children: [
//             Image.network(
//                 "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Emblem-person-blue.svg/1200px-Emblem-person-blue.svg.png",
//                 height: 59,
//                 fit: BoxFit.cover),
//             const SizedBox(
//               width: 15,
//             ),
//             Text(text,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 )),
//             const Spacer(),
//             GestureDetector(
//               onTap: () {
//                 Add().addFrind(email);
//               },
//               child: Icon(
//                 Icons.check_circle,
//                 color: Colors.green,
//                 size: 35,
//               ),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Add().declineRequest(email);
//               },
//               child: Icon(
//                 Icons.cancel,
//                 color: Colors.red,
//                 size: 35,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

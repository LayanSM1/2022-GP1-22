import 'dart:convert';
import 'dart:developer';

import 'package:application1/classes/Utils.dart';
import 'package:application1/classes/function.dart';
import 'package:application1/classes/secureStorage.dart';
import 'package:application1/presentation/add_friend_screen/models/friend_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
//import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
import 'package:http/http.dart' as http;

class Add {
  String name = '';
  String femail='';
  RSAPublicKey? MyPublicKey;
  RSAPublicKey? FriendPublicKey;
  RSAPrivateKey? MyPrivateKey;
  String MyEncreptedPublicKey='';
  String FriendEncreptedPublicKey='';



  final _firestore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;
  late FriendModel friendModel;
  late FriendModel myModel;
  late FriendModel myModel2;



  Future<bool> getUserData(String email) async {

    bool results;
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _firestore
        .collection('user')
        .where('Email', isEqualTo: email)
        .get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List finalList = allData.toList();
    log(finalList.toString());
    await _firestore.collection('user').doc(_currentUser).get().then((value) {
      name=value.data()!["Name"];
      });

    if (finalList.isEmpty) {
      results = false;
      Utils.toastMessage("your friend not registered,we send invite email !! ");
      MailFeedback(name: name , email: femail);

    } else {
      if (email != FirebaseAuth.instance.currentUser!.email!) {
        friendModel = FriendModel(
            email: email,
            name: finalList[0]["Name"],
            uid: finalList[0]["uid"],
            publicKey: finalList[0]["PublicKey"]);


      } else {
        myModel = FriendModel(
            email: email,
            name: finalList[0]["Name"],
            uid: finalList[0]["uid"],
            publicKey: finalList[0]["PublicKey"]);

      }
      results = true;


    }
    myModel2 = FriendModel(
        email: email,
        name: finalList[0]["Name"],
        uid: finalList[0]["uid"],
        publicKey: finalList[0]["PublicKey"]);

    return results;
  }

  Future getFriendData(String email) async {
    femail=email;
    List<dynamic> friends = [];
    List<dynamic> requests = [];
    List<dynamic> requests1 = [];
    String token = '';
    String name = '';
    String emailMy = '';
    late String PublicKey;
    if (await getUserData(email)) {
      await _firestore.collection('user').doc(_currentUser).get().then((value) {
        friends = value.data()!["friends"];
        requests = value.data()!["requests"];
        name = value.data()!["Name"];
        emailMy = value.data()!["Email"];
        PublicKey= value.data()!["PublicKey"];
        // log(value.data()!["PublicKey"].toString());

        log(value.data()!["friends"].toString());
      });

      await _firestore
          .collection('user')
          .doc(
            await _firestore
                .collection('user')
                .where('Email', isEqualTo: email)
                .get()
                .then(
              (value) {
                return value.docs.first.id;
              },
            ),
          )
          .get()
          .then((value) {
        requests1 = value.data()!["requests"];
        token = value.data()!["token"];
        log(value.data()!["friends"].toString());
      });
      if (friends.contains(email)) {
        Utils.toastMessage("Already your friend");
        log("already friends");
      } else if (requests1.contains(emailMy)) {
        Utils.toastMessage("Already Requested");
      } else if (requests.contains(email)) {
        Utils.toastMessage("You already received request from this user!");
      } else {
        await _firestore
            .collection('user')
            .doc(await _firestore
                .collection('user')
                .where('Email', isEqualTo: email)
                .get()
                .then((value) {
              return value.docs.first.id;
            }))
            .update({
          // "friends": friends + [FirebaseAuth.instance.currentUser!.email!],
          "requests": requests1 + [FirebaseAuth.instance.currentUser!.email!]
        });
        LocalNotificationService.sendPushMessage(
            '$name sends you a friend request', 'Friend Request', token);
        await _firestore
            .collection('user')
            .doc(_currentUser)
            .get()
            .then((value) {
          // friends = value.data()!["friends"];
          log(value.data()!["friends"].toString());
        });
        Utils.toastMessage("Friendship Request has been sent ");

      }
    }
  }

  getUserDataModel(email) async {}

  Future getFriends(String email) async {
    List<dynamic> friends = [];
    List<FriendModel> friendsList = [];
    await _firestore.collection('user').doc(_currentUser).get().then(
      (value) {
        friends = value.data()!["friends"];
        log(value.data()!["friends"].toString());
      },
    );

    friends.forEach((element) async {
      String name = "";
      String uid = "";
      String publicKey;
      await _firestore
          .collection('user')
          .where('Email', isEqualTo: element)
          .get()
          .then((value) {
        log(element);
        name = value.docs[0].data()["Name"];
        uid = value.docs[0].data()["uid"];
        publicKey = value.docs[0].data()["PublicKey"];
        log(name + uid);
        friendsList.add(FriendModel(
            email: element, name: name, uid: uid, publicKey: publicKey));
      });

      log(friendsList.toString());
    });
    await Future.delayed(Duration(seconds: 2));
    return friendsList;
  }

  Future getRequests(String email) async {
    List<dynamic> requests = [];
    List<FriendModel> requestsList = [];
    await _firestore.collection('user').doc(_currentUser).get().then(
      (value) {
        requests = value.data()!["requests"];
        log(value.data()!["requests"].toString());
      },
    );
    if (requests.isNotEmpty)
      requests.forEach((element) async {
        log(element.toString());
        String name = "";
        String uid = "";
        String publicKey = "";
        if (element != "")
          await _firestore
              .collection('user')
              .where('Email', isEqualTo: element.toString())
              .get()
              .then(
            (value) {
              name = value.docs[0].data()["Name"];
              uid = value.docs[0].data()["uid"];
              publicKey = value.docs[0].data()["PublicKey"];
              log(name + uid);
              requestsList.add(
                FriendModel(
                    email: element, name: name, uid: uid, publicKey: publicKey),
              );
            },
          );

        log(requests.toString());
      });
    await Future.delayed(
      Duration(seconds: 2),
    );
    return requestsList;
  }

  Future<int> addFrind(String email) async {
    String Friendpub ='';
    String Mypub ='';
    String MyEmail=FirebaseAuth.instance.currentUser!.email!;

    await _firestore
        .collection('user')
        .where('Email', isEqualTo: MyEmail)
        .get()
        .then(
            (value) {
              Mypub = value.docs[0].data()["PublicKey"];
        });
    await _firestore
        .collection('user')
        .where('Email', isEqualTo: email)
        .get()
        .then(
            (value) {
          Friendpub = value.docs[0].data()["PublicKey"];
        });
    await getUserData(MyEmail);

    await getUserData(email);

    final myPrivateKeyString = await userSecureStorage.getPrivateKey() ?? "";


    List<dynamic> friends = [];
    List<dynamic> requests = [];
    String name = '';
    String token = '';
    if (await getUserData(email)) {

      await _firestore.collection('user').doc(_currentUser).get().then((value) {
        friends = value.data()!["friends"];
        requests = value.data()!["requests"];
        name = value.data()!["Name"];
        log(value.data()!["friends"].toString());
      });
      if (friends.contains(email)) {
        Utils.toastMessage("Already your friend");
      } else {
        requests.remove(email);
        await _firestore.collection('user').doc(_currentUser).update({
          "friends": FieldValue.arrayUnion([email]),
          "requests": FieldValue.arrayRemove([email]),
        });
        //friend public key from database
        FriendPublicKey= RSAPublicKey.fromString(Friendpub);
        //my public key from database
        MyPublicKey= RSAPublicKey.fromString(Mypub);
        //generate sheared secret key
        var Secretkey = await FlutterAesEcbPkcs5.generateDesKey(128);
        //my encrypted key
        MyEncreptedPublicKey= MyPublicKey!.encrypt(Secretkey!);
        //friend encrypted key
        FriendEncreptedPublicKey= FriendPublicKey!.encrypt(Secretkey!);

        //add friendship data to database for the tow users:
        await _firestore
            .collection('user')
            .doc(_currentUser)
            .collection("chats")
            .doc(friendModel.uid)
            .set({
          "status": "true",
          'name': friendModel.name,
          "key": MyEncreptedPublicKey,
          "email": email,
          "read": false,
          "uid": friendModel.uid,
          "time": DateTime.now(),
        });
        await _firestore
            .collection('user')
            .doc(friendModel.uid)
            .collection("chats")
            .doc(_currentUser)
            .set({
          "status": "true",
          'name': name,
          "email": FirebaseAuth.instance.currentUser!.email,
          "key": FriendEncreptedPublicKey,
          "read": false,
          "uid": FirebaseAuth.instance.currentUser!.uid,
          "time": DateTime.now(),
        });
        await _firestore
            .collection('user')
            .doc(await _firestore
                .collection('user')
                .where('Email', isEqualTo: email)
                .get()
                .then((value) {
              return value.docs.first.id;
            }))
            .update({
          "friends": FieldValue.arrayUnion(
              [FirebaseAuth.instance.currentUser!.email!]),
        });
        await _firestore
            .collection('user')
            .doc(await _firestore
                .collection('user')
                .where('Email', isEqualTo: email)
                .get()
                .then((value) {
              return value.docs.first.id;
            }))
            .get()
            .then((value) {
          token = value.data()!["token"];
        });
        //send notification
        LocalNotificationService.sendPushMessage(
            "$name accept your friend request", "Request Accepted", token);
        await _firestore
            .collection('user')
            .doc(_currentUser)
            .get()
            .then((value) {
          log(value.data()!["friends"].toString());
        });
        Utils.toastMessage("Added");
        log("added");
      }
    }
    return 1;
  }

  Future<void> UpdateKey(String email) async {
    String Friendpub ='';
    String Mypub ='';
    String name = '';

    String MyEmail=FirebaseAuth.instance.currentUser!.email!;

    await _firestore
        .collection('user')
        .where('Email', isEqualTo: MyEmail)
        .get()
        .then(
            (value) {
          Mypub = value.docs[0].data()["PublicKey"];
        });
    await _firestore
        .collection('user')
        .where('Email', isEqualTo: email)
        .get()
        .then(
            (value) {
          Friendpub = value.docs[0].data()["PublicKey"];
        });
    await getUserData(MyEmail);

    await getUserData(email);

    if (await getUserData(email)) {

      await _firestore.collection('user').doc(_currentUser).get().then((value) {
        name = value.data()!["Name"];
      });
        FriendPublicKey= RSAPublicKey.fromString(Friendpub);
        MyPublicKey= RSAPublicKey.fromString(Mypub);

        //generate sheared secret key
        var Secretkey = await FlutterAesEcbPkcs5.generateDesKey(128);
        MyEncreptedPublicKey= MyPublicKey!.encrypt(Secretkey!);
        FriendEncreptedPublicKey= FriendPublicKey!.encrypt(Secretkey!);

        print("my public key from database ");
        print(MyPublicKey.toString());
        print("friend public key from database ");
        print(FriendPublicKey.toString());
        print("my encrypted key ");
        print(MyEncreptedPublicKey);
        print("friend encrypted key ");
        print(FriendEncreptedPublicKey);
        print("my private key from secure storge ");
        print(MyPrivateKey.toString());
        print("seceret key orginial");
        print(Secretkey);

        await _firestore
            .collection('user')
            .doc(_currentUser)
            .collection("chats")
            .doc(friendModel.uid)
            .set({
          "status": "true",
          'name': friendModel.name,
          "key": MyEncreptedPublicKey,
          "email": email,
          "read": false,
          "uid": friendModel.uid,
          "time": DateTime.now(),        });

        await _firestore
            .collection('user')
            .doc(friendModel.uid)
            .collection("chats")
            .doc(_currentUser)
            .set({
          "status": "true",
          'name': name,
          "email": FirebaseAuth.instance.currentUser!.email,
          "key": FriendEncreptedPublicKey,
          "read": false,
          "uid": FirebaseAuth.instance.currentUser!.uid,
          "time": DateTime.now(),        });

        // Utils.toastMessage("The secret key updated");
        // log("updated");
      }
    }


  Future<int> declineRequest(String email) async {
    List<dynamic> requests = [];
    String token = '';
    String name = '';

    await _firestore.collection('user').doc(_currentUser).get().then((value) {
      requests = value.data()!["requests"];
      name = value.data()!["Name"];
      log(value.data()!["friends"].toString());
    });
    await _firestore
        .collection('user')
        .doc(await _firestore
            .collection('user')
            .where('Email', isEqualTo: email)
            .get()
            .then((value) {
          return value.docs.first.id;
        }))
        .get()
        .then((value) {
      token = value.data()!["token"];
    });
    requests.removeWhere((element) {
      return element == email;
    });
    LocalNotificationService.sendPushMessage(
        "$name Declined your request", "Declined Request", token);
    log(requests.toString());
    await _firestore.collection('user').doc(_currentUser).update(
      {
        "requests": requests,
      },
    );
    return 1;
  }
  Future MailFeedback({required String name, required String email}) async {
    final service_id = 'service_89q9569';
    final template_id = 'template_3zpmy65';
    final user_id = 'ZHpJUfo6CPoFUW5XQ';
    var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    try {
      var response = await http.post(url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'service_id': service_id,
            'template_id': template_id,
            'user_id': user_id,
            'template_params': {'from_name': name, 'to_email': email}
          }));
      print('[FEED BACK RESPONSE]');
      print(response.body);
    } catch (error) {
      print('[SEND EMAIL ERROR]');
    }
  }


   Future<String> getPublicKey(String email)  async {
    String publicKey='';

    await _firestore
        .collection('user')
        .where('Email', isEqualTo: email)
        .get()
        .then(
            (value) {
          publicKey = value.docs[0].data()["PublicKey"];
          });

    print("public key from method");
    print(email);
    print(publicKey);
    return publicKey;

  }
}

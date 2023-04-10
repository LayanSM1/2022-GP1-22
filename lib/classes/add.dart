import 'dart:convert';
import 'dart:developer';

import 'package:application1/classes/Utils.dart';
import 'package:application1/classes/secureStorage.dart';
import 'package:application1/presentation/add_friend_screen/models/friend_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Add {
  final _firestore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;
  late FriendModel friendModel;
  late FriendModel myMode;

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

    if (finalList.isEmpty) {
      results = false;
      Utils.toastMessage("user not registered");
      log("not registered");
    } else {
      if (email != FirebaseAuth.instance.currentUser!.email!) {
        friendModel = FriendModel(
            email: email,
            name: finalList[0]["Name"],
            uid: finalList[0]["uid"],
            publicKey: finalList[0]["PublicKey"]);
      } else {
        myMode = FriendModel(
            email: email,
            name: finalList[0]["Name"],
            uid: finalList[0]["uid"],
            publicKey: finalList[0]["PublicKey"]);
      }

      results = true;
      log("registered");
    }
    return results;
  }

  Future getFriendData(String email) async {
    List<dynamic> friends = [];
    List<dynamic> requests = [];

    if (await getUserData(email)) {
      await _firestore.collection('user').doc(_currentUser).get().then((value) {
        friends = value.data()!["friends"];
        requests = value.data()!["requests"];
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
        requests = value.data()!["requests"];
        log(value.data()!["friends"].toString());
      });
      if (friends.contains(email)) {
        Utils.toastMessage("Already your friend");
        log("already friends");
      } else if (requests.contains(email)) {
        Utils.toastMessage("Already Requested");
      } else {
        //   await _firestore.collection('user').doc(_currentUser).update({
        //     "friends": friends + [email]
        //   });
        //   await _firestore.collection('user').doc(_currentUser).update({
        //     "friends": friends + [email]
        //   });
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
          "requests": requests + [FirebaseAuth.instance.currentUser!.email!]
        });

        await _firestore
            .collection('user')
            .doc(_currentUser)
            .get()
            .then((value) {
          // friends = value.data()!["friends"];
          log(value.data()!["friends"].toString());
        });
        Utils.toastMessage("Added");
        log("added");
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
    await getUserData(FirebaseAuth.instance.currentUser!.email!);
    await getUserData(email);
    String myPrivateKey = await userSecureStorage.getPrivateKey() ?? "";

    List<dynamic> friends = [];
    List<dynamic> requests = [];

    if (await getUserData(email)) {
      final rsaPublicKey = RSAPublicKey.fromPEM(myMode.publicKey);

      await _firestore.collection('user').doc(_currentUser).get().then((value) {
        friends = value.data()!["friends"];
        requests = value.data()!["requests"];
        log(value.data()!["friends"].toString());
      });
      if (friends.contains(email)) {
        Utils.toastMessage("Already yout friend");
        log("already friends");
      } else {
        requests.remove(email);
        await _firestore.collection('user').doc(_currentUser).update({
          "friends": friends + [email],
          "requests": requests
        });

        await _firestore
            .collection('user')
            .doc(_currentUser)
            .collection("chat")
            .doc(friendModel.uid)
            .set({"publicKey": friendModel.publicKey});
        await _firestore.collection('user').doc(_currentUser).update({
          "friends": friends + [email]
        });
        await _firestore
            .collection('user')
            .doc(_currentUser)
            .collection("chat")
            .doc(myMode.uid)
            .set({"friendsKey": friendModel.publicKey});
        await _firestore.collection('user').doc(_currentUser).update({
          "friends": friends + [email]
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
          "friends": friends + [FirebaseAuth.instance.currentUser!.email!],
          // "requests": requests + [FirebaseAuth.instance.currentUser!.email!]
        });

        await _firestore
            .collection('user')
            .doc(_currentUser)
            .get()
            .then((value) {
          // friends = value.data()!["friends"];
          log(value.data()!["friends"].toString());
        });
        Utils.toastMessage("Added");
        log("added");
      }
    }
    return 1;
  }

  Future<int> declineRequest(String email) async {
    List<dynamic> requests = [];
    await _firestore.collection('user').doc(_currentUser).get().then((value) {
      requests = value.data()!["requests"];
      log(value.data()!["friends"].toString());
    });
    requests.removeWhere((element) {
      return element == email;
    });
    log(requests.toString());
    await _firestore.collection('user').doc(_currentUser).update(
      {
        "requests": requests,
      },
    );
    return 1;
  }
}

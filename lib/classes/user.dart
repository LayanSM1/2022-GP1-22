//import 'package:equatable/equatable.dart';

//class AppUser extends Equatable {
  //final String email;
  //final String username;
  //final String password;
  //final String publicKey;
  //final String privateKey;
  //final String salt;

  //const AppUser( {
    //required this.email,
    //required this.username,
    //required this.password,
    //required this.publicKey,
    //required this.privateKey,
    //required this.salt,
  //});


  //String get initials => username.substring(0, 2).toUpperCase();

  //factory AppUser.fromMap(Map<String, dynamic> data, [String docId = ""]) {
    //return AppUser(
      //email: data["email"] ?? "",
      //username: data["username"] ?? "",
      //publicKey: data["publicKey"] ?? "",
      //password: data["password"] ?? "",
      //privateKey: data["privateKey"] ?? "",
      //salt: data["salt"] ?? "",
    //);
  //}

  //Map<String, String> toMap() => {
    //"id": id,
    //"email": email,
    //"username": username,
    //"password": password,
    //"publicKey": publicKey,
    //"privateKey": privateKey,
    //"salt": salt,
  //};

  //@override
  //List<Object?> get props => [
    //email,
    //username,
    //password,
    //publicKey,
    //privateKey,
    //salt,
  //];
//}

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AppUser  {
  final String id;
  final String email;
  final String username;
  final String password;
  final String publicKey;
  //final String privateKey;
  final String salt;



  const AppUser( {
    required this.email,
    required this.username,
    required this.password,
    required this.publicKey,
    //required this.privateKey,
    required this.salt,
    required this.id,
  });


  //String get initials => username.substring(0, 2).toUpperCase();

 // AppUser.fromJson(Map<String, dynamic> json)
  //    : this(
  //  email: json["email"] ?? "",
  //  username: json["username"] ?? "",
  //  publicKey: json["publicKey"] ?? "",
  //  password: json["password"] ?? "",
    //privateKey: data["privateKey"] ?? "",
  //  salt: json["salt"] ?? "",
 // );


 // Map<String, dynamic> toJson()  {
  //  return {
  //    "email": email,
  //    "username": username,
  //    "password": password,
  //    "publicKey": publicKey,
      //"privateKey": privateKey,
  //    "salt": salt,
  //  };
 // factory AppUser.fromDocument(DocumentSnapshot doc)
  //{
  //  return AppUser(

   //   username: doc['name'],
   //   email: doc['email'],
   //   password: doc['password'],
   //   publicKey: doc['publicKey'],
   //   salt: doc['salt'],
   // );
 // }
  //code1
  factory AppUser.fromDocument(DocumentSnapshot doc)
  {
    return AppUser(
      id: doc.id,
      username: doc['username'],
      email: doc['email'],
      password: doc['password'],
      publicKey: doc['publicKey'],
      salt: doc['salt'],
    );
  }

//code2
//  factory AppUser.fromDocument(DocumentSnapshot _snapshot) {
   // var _data = _snapshot.data;
   // return AppUser(
    //  id: _snapshot.id,
    //  username: _data["username"],
    //  email: _data["email"],
     // profileImage: _data["profileImage"],
   //   posts: _data["posts"],
    //  lastSeen: _data["lastSeen"],
    //);
  //}
}


  





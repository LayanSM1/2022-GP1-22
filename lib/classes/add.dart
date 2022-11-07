import 'package:cloud_firestore/cloud_firestore.dart';

class Add{
  final _firestore = FirebaseFirestore.instance;

  searchByEmail(String email){
    return _firestore.collection('user').where('Email', isEqualTo: email).snapshots();
  }

}
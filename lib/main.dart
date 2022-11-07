import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



import 'classes/user.dart';
import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppLocalization(),
      locale: Get.deviceLocale, //for setting localization strings
      fallbackLocale: Locale('en', 'US'),
      title: 'application1',
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
    );
  }
  //Future<List<AppUser>> getAllData() async {
    //print("Active Users");
   // var val = await Firestore.instance.collection("User").getDocuments();
   // var documents = val.documents;
   // print("Documents ${documents.length}");
  //  if (documents.length > 0) {
    //  try {
    //    print("Active ${documents.length}");
    //    return documents.map((document) {
    //      AppUser AppUser = AppUser.fromJson(Map<String, dynamic>.from(document.data));

      //    return AppUser;
     //   }).toList();
    //  } catch (e) {
     //   print("Exception $e");
    //    return [];
     // }
   // }
   // return [];
}

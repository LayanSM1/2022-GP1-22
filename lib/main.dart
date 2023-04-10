import 'package:application1/presentation/login_screen/login_screen.dart';
import 'package:application1/presentation/register_screen/register_screen.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/app_export.dart';
import 'presentation/home_screen/home_screen.dart';
import 'presentation/private_chat_screen/camera_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  camera = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppLocalization(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      title: 'application1',
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return RegisterScreen();
            }
          }),
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

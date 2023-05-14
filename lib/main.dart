import 'package:application1/classes/function.dart';
import 'package:application1/presentation/login_screen/login_screen.dart';
import 'package:application1/presentation/register_screen/register_screen.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/app_export.dart';
import 'presentation/home_screen/home_screen.dart';
import 'presentation/private_chat_screen/camera_screen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());

  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  camera = await availableCameras();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  FirebaseMessaging.instance.getInitialMessage().then(
    (message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      // LocalNotificationService.createanddisplaynotification(message!);
      if (message != null) {
        print("New Notification");
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => DemoScreen(
        //         id: message.data['_id'],
        //       ),
        //     ),
        //   );
        // }
      }
    },
  );

  // 2. This method only call when App in forground it mean app must be opened
  FirebaseMessaging.onMessage.listen(
    (message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("message.data11 ${message.data}");
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );

  // 3. This method only call when App in background and not terminated(not closed)
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("message.data22 ${message.data['_id']}");
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );
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
              return RegisterScreen(
                name: 'Nouf',
              );
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

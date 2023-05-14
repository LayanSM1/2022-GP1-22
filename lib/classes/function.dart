import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

// after this create a method initialize to initialize  localnotification

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: (String? id) async {
      //   print("onSelectNotification");
      //   if (id!.isNotEmpty) {
      //     print("Router Value1234 $id");

      //     // Navigator.of(context).push(
      //     //   MaterialPageRoute(
      //     //     builder: (context) => DemoScreen(
      //     //       id: id,
      //     //     ),
      //     //   ),
      //     // );

      //   }
      // },
    );
  }

  static sendPushMessage(String body, String title, String token) async {
    try {
      print('sending');
      final response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAA3IsQGIY:APA91bHSme0BPFG6xbQXcEAgoDoGD8dlYToit5dBTQN8XbzlqU95Egfebxdl_-LJjP0tj70PqVqTHZ2Kn7MLiZvzgQ-AMn30QTJxT7IjtNFq2PRZnYKqz6DaXPY4ch8TeGFCldSfjXFs',
              },
              body: json.encode({
                "pirority": "high",
                "registration_ids": [
                  token,
                  // "cxDaTRu1T-eMCVEBycQAuj:APA91bFHXtHF20bGBRNVOcNKJ9hpxpSdjBbWL9QN0Es79hi4i_VpBlUYu8aNNHDovxibTvnIdu5EPmd6-85qbgtFUimiim6FfwTeieehy8_sUs_w7UNacJYRFq9wxWJVnEfVy9KhVhfM"
                ],
                "notification": {
                  "body": body,
                  "title": title,
                  "android_channel_id": "flutterNotification",
                  "sound": false
                }
              }));
      print('sent ${response.statusCode}and ${response.request}');
    } catch (e) {
      print(e.toString());
    }
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "flutterNotification",
          "flutterNotificationchannel",
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.red,
          colorized: true,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

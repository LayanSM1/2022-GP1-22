import 'dart:async';

import 'package:application1/presentation/home_screen/home_screen.dart';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class VerfiyPage extends StatefulWidget {

  @override
  State<VerfiyPage> createState() => _VerfiyPageState();
}

class _VerfiyPageState extends State<VerfiyPage> {
  bool isEmailVerified = false;
  bool canResendEmail = true;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      // setState(() {
      //   canResendEmail = false;
      // });
      // await Future.delayed(Duration(seconds: 5));
      // setState(() {
      //   canResendEmail = true;
      // });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? HomeScreen()
        : Scaffold(
      appBar: AppBar(title: Text("Verify your email")),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("A verification email is send to your email "),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  onPressed:
                  canResendEmail ? sendVerificationEmail : null,
                  icon: Icon(Icons.email),
                  label: Text("Resend Email")),
              SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Text('Cancel'))
            ],
          ),
        ),
      ),
    );
  }
}
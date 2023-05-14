import 'dart:async';

import 'package:application1/core/app_export.dart';
import 'package:application1/presentation/home_screen/home_screen.dart';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/utils/size_utils.dart';
import '../register_screen/register_screen.dart';

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
      body: Container(
        width: 400,
        height: 815,
        decoration: BoxDecoration(
          gradient : LinearGradient(
              begin: Alignment(6.123234262925839e-17,1),
              end: Alignment(-1,6.123234262925839e-17),
              colors: [Color.fromRGBO(55, 49, 197, 1),Color.fromRGBO(51, 190, 231, 1)]
          ),
        ),
        child: Stack(
            children: <Widget>[
              Positioned(
                  top: -49,
                  left: -103,
                  child: Container(
                      width: 577,
                      height: 521,
                      decoration: BoxDecoration(
                        color : Color.fromRGBO(255, 255, 255, 1),
                        borderRadius : BorderRadius.all(Radius.elliptical(577, 521)),
                      )
                  )
              ),Positioned(
                  top: -9,
                  left: -29,
                  child: Container(
                      width: 400,
                      height: 446,
                      decoration: BoxDecoration(
                        image : DecorationImage(
                            image: AssetImage('assets/images/email.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )
                  )
              )   ,Positioned(
                  top: 392,
                  left: -68,
                  child: Container(
                      width: 487,
                      height: 46,
                      decoration: BoxDecoration(
                        color : Color.fromRGBO(255, 255, 255, 1),
                        borderRadius : BorderRadius.all(Radius.elliptical(487, 46)),
                      )
                  )
              )



              ,

              Positioned(
                  top: 512,
                  left: 70,

                  child: Text("A verification email is\n send to your email ", textAlign: TextAlign.center, style: TextStyle(
                    decoration: TextDecoration.none, // Set this

                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Quicksand',
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                  ),)



              ),


              Positioned(
                  top: 634,
                  left: 130,
                  child:ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.indigo, backgroundColor: Colors.white, // foreground
                      ),
                      onPressed:
                               canResendEmail ? sendVerificationEmail : null,

                    child: Text('Resend Email',style: TextStyle(
                        fontSize: 20,
                      ),
                      ))


              ),

              Positioned(
                  top: 699,
                  left: 160,
                  child: ElevatedButton(


                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.indigo, backgroundColor: Colors.white,  // foreground
                      ),
                      onPressed: () {Get.to(() => RegisterScreen(name: '',));
                        ;
                      },
                      child: Text('Cancel',style: TextStyle(
                        fontSize: 20,
                      ),
                      ))

              ),




            ])




    )


    // child: Container(
        //         width: 200,
        //         height: 200,
        //         decoration: BoxDecoration(
        //           image : DecorationImage(
        //               image: AssetImage('assets/images/email.png'),
        //               fit: BoxFit.fitWidth
        //           ),
        //         ),
        //
        //   padding: EdgeInsets.only(left: 10, right: 10),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text("A verification email is send to your email "),
        //       ElevatedButton.icon(
        //           style: ElevatedButton.styleFrom(
        //               minimumSize: Size.fromHeight(50)),
        //           onPressed:
        //           canResendEmail ? sendVerificationEmail : null,
        //           icon: Icon(Icons.email),
        //           label: Text("Resend Email")),
        //       SizedBox(
        //         height: 8,
        //       ),
        //       TextButton(
        //           onPressed: () {
        //             FirebaseAuth.instance.signOut();
        //           },
        //           child: Text('Cancel'))
        //     ],
        //   ),
        // ),

    );
  }
}
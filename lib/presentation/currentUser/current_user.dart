import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../home_screen/home_screen.dart';
import '../login_screen/login_screen.dart';

class currentUser extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)=>scaffold (
    body:StreamBuilder<User?>(
      stream:FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else if (snapshot.hasError){
          return Center(child:Text("Something Want error !!"));
        }else if(snapshot.hasData){
          return HomeScreen();}
        else{
          return LoginScreen();

        }

      },)
  );

  }

scaffold({required StreamBuilder<User?> body}) {
}

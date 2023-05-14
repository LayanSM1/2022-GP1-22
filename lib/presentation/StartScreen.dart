import 'package:application1/core/app_export.dart';
import 'package:application1/presentation/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/utils/size_utils.dart';
import '../widgets/custom_button.dart';


class Getstarted4Widget extends StatefulWidget {
  @override
  _Getstarted4WidgetState createState() => _Getstarted4WidgetState();
}

class _Getstarted4WidgetState extends State<Getstarted4Widget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Getstarted4Widget - FRAME

    return Container(
      width: 375,
      height: 812,
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
        left: -32,
        child: Container(
            width: 439,
            height: 446,
            decoration: BoxDecoration(
              image : DecorationImage(
                  image: AssetImage('assets/images/Image1.png'),
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

        child: Text('Let’s connect \n with each other.', textAlign: TextAlign.center, style: TextStyle(
           decoration: TextDecoration.none, // Set this

          color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Quicksand',
        fontSize: 32,
        fontWeight: FontWeight.normal,
    ),)



    ),


        Positioned(
            top: 634,
            left: 150,
            child: ElevatedButton(

        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.indigo, backgroundColor: Colors.white, // foreground
        ),
        onPressed: () { Get.to(RegisterScreen(name: ''));
        },
        child: Text('Register',style: TextStyle(
              fontSize: 20,
            ),
      ))),

        Positioned(
            top: 699,
            left: 160,
            child: ElevatedButton(


        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.indigo, backgroundColor: Colors.white,  // foreground
        ),
        onPressed: () {
          // Navigator.pushNamed(context,
          //     AppRoutes.verfiy);
          Get.toNamed(AppRoutes.loginScreen);
        },
        child: Text('Login',style: TextStyle(
                  fontSize: 20,
              ),
      ))),




  ])




    )
    ;
  }



}



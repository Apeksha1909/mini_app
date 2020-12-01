import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mini_app/quizhome.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => QuizHome(),
      ));
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSplashScreen(
        splash: Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'QuizApp',
              style: TextStyle(fontSize: 50.0,color: Colors.blue,fontFamily: 'Quando'),
            ),
          ),

        ),
        splashTransition: SplashTransition.scaleTransition,

         nextScreen: QuizHome(),
      ),
    );
  }
}

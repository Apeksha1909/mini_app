import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/create_quiz.dart';
import 'package:mini_app/prepareExams.dart';
import 'package:mini_app/main.dart';
import 'package:mini_app/quizhome.dart';
import 'package:mini_app/services/auth.dart';
import 'package:mini_app/widgets/teachers.dart';

class MainDrawer extends StatelessWidget {

  AuthService authService =new AuthService();


  @override
  Widget build(BuildContext context) {
    return  Drawer(
    child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.only(top: 30.0,bottom: 10.0),
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle,

                    //image: DecorationImage(image: NetworkImage(''),
                   // fit: BoxFit.fill
                    //)
                  ),
                  child: Center(
                    child: Text(
                      'QuizApp',
                      style: TextStyle(
                        fontFamily: 'Alike',
                        fontWeight: FontWeight.bold,
                        fontSize:22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30,),
        ListTile(
          leading: Icon(Icons.library_books,color: Colors.black,),
          title: Text('Teachers Help', style: TextStyle(
            fontFamily: 'Amita',
            fontSize: 20,
              color: Colors.blue
          ),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => TeachersHelp(),
                 //builder: (context) => HomePage("Percentage"),
            ));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings,color: Colors.black,),
          title: Text('Prepare', style: TextStyle(
            fontFamily: 'Amita',
            fontSize: 20,
              color: Colors.blue
          ),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=> PreapreExams(),
              //builder: (context) => getjson("Area and Volume"),
            ));
          },
        ),
        ListTile(
          leading: Icon(Icons.question_answer,color: Colors.black,),
          title: Text('Create Quiz', style: TextStyle(
            fontFamily: 'Amita',
            fontSize: 20,
            color: Colors.blue
          ),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => QuizHome()
            ));
          },
        ),
        ListTile(
          leading: Icon(Icons.arrow_back,color: Colors.black,),
          title: Text('Logout', style: TextStyle(
            fontFamily: 'Amita',
            fontSize: 20,
              color: Colors.blue
          ),),
          onTap: (){
            authService.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
          },
        ),
      ],
    )
    );
  }
}

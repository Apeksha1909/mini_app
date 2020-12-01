import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/services/database.dart';
import 'package:mini_app/widgets/widget.dart';
import 'package:random_string/random_string.dart';

import 'addquestion.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey=GlobalKey<FormState>();

  String quizImageUrl, quizTitle, quizDescription,quizId;
  bool _isLoading = false;
  DatabaseService databaseService=new DatabaseService();

  CreateQuizOnline()async{
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImageUrl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDescription" : quizDescription
      };
      await databaseService.addQuizData(quizMap,quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => AddQuestion(
              quizId
            ),
          ));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: appmyBar(context)),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,//to show battery signal symbols
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: <Widget>[
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Image Url" :null,
              decoration: InputDecoration(
                hintText: "Quiz Image URL",
                hintStyle: TextStyle(
                  fontFamily: 'Amita'
                )
              ),
              onChanged: (val){
                quizImageUrl = val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Quiz Title" :null,
              decoration: InputDecoration(
                  hintText: "Quiz Title",
                  hintStyle: TextStyle(
                      fontFamily: 'Amita'
                  ),
              ),
              onChanged: (val){
                quizTitle = val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Quiz Description" :null,
              decoration: InputDecoration(
                  hintText: "Quiz Description",
                  hintStyle: TextStyle(
                      fontFamily: 'Amita'
                  ),
              ),
              onChanged: (val){
                quizDescription = val;
              },
            ),
            Spacer(),
            Container(

              height: 50.0,
              width: 350.0,
              child: Material(

                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Colors.blue,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                   CreateQuizOnline();
                  },
                  child: Center(
                    child: Text(
                      'Create Quiz',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: 'Alike'
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,)
          ],),
        ),
      ),
    );
  }
}

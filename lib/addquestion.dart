import 'package:flutter/material.dart';
import 'package:mini_app/services/database.dart';
import 'package:mini_app/widgets/widget.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey=GlobalKey<FormState>();
  String question, option1,option2,option3,option4;
  bool _isLoading=false;

  DatabaseService databaseService=new DatabaseService();

  uploadQuestionData()async{
    if(_formKey.currentState.validate()){
      //recreate the sceen with updated data
      setState(() {
        _isLoading=true;
      });

      Map<String,String> questionMap ={
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4
      };
     await databaseService.addQuestionData(questionMap, widget.quizId).then((value){
        setState(() {
          _isLoading=false;
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
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" :null,
                decoration: InputDecoration(
                    hintText: "Question",
                    hintStyle: TextStyle(
                    fontFamily: 'Alike'
                ),
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" :null,
                decoration: InputDecoration(
                    hintText: "Option1",
                    hintStyle: TextStyle(
                        fontFamily: 'Alike'
                    )
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" :null,
                decoration: InputDecoration(
                    hintText: "Option2",
                    hintStyle: TextStyle(
                        fontFamily: 'Alike'
                    )
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" :null,
                decoration: InputDecoration(
                    hintText: "Option3",
                    hintStyle: TextStyle(
                        fontFamily: 'Alike'
                    )
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" :null,
                decoration: InputDecoration(
                    hintText: "Option4",
                    hintStyle: TextStyle(
                        fontFamily: 'Alike'
                    )
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      uploadQuestionData();
                      Navigator.pop(context);
                    },
                    child: blueButton(context: context,
                    label: "Submit",
                     buttonWidth: MediaQuery.of(context).size.width/2 - 36),
                  ),
                  SizedBox(width: 24,),
                  GestureDetector(
                    onTap: (){
                      uploadQuestionData();
                    },
                    child: blueButton(context: context,
                        label: "Add Question",
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36),
                  ),
                ],
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}

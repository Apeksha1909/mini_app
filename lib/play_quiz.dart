import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_app/question_model.dart';
import 'package:mini_app/quiz_result.dart';
import 'package:mini_app/services/database.dart';
import 'package:mini_app/widgets/quiz_play_widgets.dart';
import 'package:mini_app/widgets/widget.dart';

class PlayQuiz extends StatefulWidget {

  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect =0;
int _notAttempted=0;

class _PlayQuizState extends State<PlayQuiz> {

  DatabaseService databaseService =new DatabaseService();
  QuerySnapshot questionSnapshot;

  QuestionModel getQuestionModelFromDatasnapshot(DocumentSnapshot questionSnapshot){
    QuestionModel questionModel=new QuestionModel();

    questionModel.question = questionSnapshot.data["question"];
    List<String> options=[
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];

    questionModel.correctAnswer = questionSnapshot.data["option1"];
    questionModel.answered = false;

    return questionModel;

  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizData(widget.quizId).then((value){
      questionSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect =0;
      total=questionSnapshot.documents.length;
      setState(() {
      });
    });
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: appmyBar(context)),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,//to show battery signal symbols
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
              questionSnapshot == null ?
                  Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ) : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24,),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionSnapshot.documents.length,
                itemBuilder: (context, index){
                  return QuizPlayTile(
                      questionModel :getQuestionModelFromDatasnapshot(questionSnapshot.documents[index]),
                      index: index,
                  );
                },
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => QuizResult(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}
class QuizPlayTile extends StatefulWidget {

  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

  String optionSelected="";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Text("Q${widget.index+1} ${widget.questionModel.question}", style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontFamily: 'Alike'
            ),),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                //checking correct or not
                if(widget.questionModel.option1 ==
                widget.questionModel.correctAnswer){
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered =true;
                   _correct = _correct +1;
                   _notAttempted = _notAttempted -1;
                   setState(() {

                   });
                }else{
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered =true;
                  _incorrect =_incorrect +1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
              child: OptionTile(
                correctAnswer: widget.questionModel.correctAnswer,
                description: widget.questionModel.option1,
                option: "A",
                optionSelected: optionSelected,
              ),
            ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                //checking correct or not
                if(widget.questionModel.option2 ==
                    widget.questionModel.correctAnswer){
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered =true;
                  _correct = _correct +1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered =true;
                  _incorrect =_incorrect +1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                //checking correct or not
                if(widget.questionModel.option3 ==
                    widget.questionModel.correctAnswer){
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered =true;
                  _correct = _correct +1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered =true;
                  _incorrect =_incorrect +1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                //checking correct or not
                if(widget.questionModel.option4 ==
                    widget.questionModel.correctAnswer){
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered =true;
                  _correct = _correct +1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered =true;
                  _incorrect =_incorrect +1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/widgets/widget.dart';

class QuizResult extends StatefulWidget {
  final int correct, incorrect, total;
  QuizResult({@required this.correct, @required this.incorrect, @required this.total});
  @override
  _QuizResultState createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              child: Container(
                width: 200.0,
                height: 200.0,
                child: ClipRect(
                  child: Image(
                      image: AssetImage(
                        "assets/good.png",
                      )
                  ),
                ),
              ),
            ),
            SizedBox(height: 65,),
            Text("${widget.correct}/${widget.total}", style: TextStyle(
              fontSize: 25,
            ),),
            SizedBox(height: 8,),
            Center(
              //widthFactor: ,
              child: Text("You answered ${widget.correct} questions correctly",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontFamily: 'Aladin'
              ),),
            ),
            SizedBox(height: 24,),
            GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: blueButton(context: context, label: "Go To Home", buttonWidth: MediaQuery.of(context).size.width/2)),
            SizedBox(height: 160,),
            Center(
              child: Text(
                "To Improve Your Performance \n      Go To Teachers Help!!",
                style:TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  fontFamily: 'Aladin'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

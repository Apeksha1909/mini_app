import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_app/create_quiz.dart';
import 'package:mini_app/navidrawer.dart';
import 'package:mini_app/play_quiz.dart';
import 'package:mini_app/services/database.dart';


class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {

  Stream quizStream;
  DatabaseService databaseService=new DatabaseService();


  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 20),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot){
          return snapshot.data == null ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) : ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return QuizTile(imagUrl: snapshot.data.documents[index].data["quizImageUrl"],
                    title: snapshot.data.documents[index].data["quizTitle"],
                    desc: snapshot.data.documents[index].data["quizDescription"],
                quizid: snapshot.data.documents[index].data["quizId"],);
              });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizesData().then((value){
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text('QuizApp',style: TextStyle(
          fontFamily: 'Quando',
        ),),
      ),
      drawer: MainDrawer(),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(
            builder: (context) => CreateQuiz()
          ));
        },
      ),

    );
  }
}
class QuizTile extends StatelessWidget {
  final String imagUrl;
  final String title;
  final String desc;
  final String quizid;

  QuizTile({@required this.imagUrl, @required this.title,@required this.desc, @required this.quizid});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PlayQuiz(quizid),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imagUrl, width: MediaQuery.of(context).size.width-48, fit:BoxFit.cover ,)),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(title, style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Niconne',
                    fontWeight: FontWeight.w600,
                  ),),
                  SizedBox(height: 4,),
                  Text(desc, style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Aladin',
                    fontWeight: FontWeight.w400,
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

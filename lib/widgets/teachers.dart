import 'package:flutter/material.dart';
import 'package:mini_app/services/database.dart';
import 'package:mini_app/widgets/widget.dart';

class TeachersHelp extends StatefulWidget {
  @override
  _TeachersHelpState createState() => _TeachersHelpState();
}

class _TeachersHelpState extends State<TeachersHelp> {
  Stream quizStream;
  DatabaseService databaseService=new DatabaseService();

  Widget teacherslist(){
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
                return TeachersTile(
                  name: snapshot.data.documents[index].data["teacherName"],
                  topic: snapshot.data.documents[index].data["topicName"],
                  contact: snapshot.data.documents[index].data["contactNo"],
                  teacherid: snapshot.data.documents[index].data["teacherId"],);
              });
        },
      ),
    );
  }

  @override
  void initState() {
   databaseService.getTeachersData().then((value){
     setState(() {
       quizStream = value;
     });
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: appmyBar(context)),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light, //to show battery signal symbols
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: teacherslist(),
    );
  }
}

class TeachersTile extends StatelessWidget {

  final String name;
  final String topic;
  final String teacherid;
  final String contact;

  TeachersTile({@required this.name, @required this.topic,@required this.contact,@required this.teacherid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              //child
              ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.amberAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(name, style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                    letterSpacing: 2.0,
                    wordSpacing: 4.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SansitaSwashed'
                ),),
                SizedBox(height: 5,),
                Text(topic, style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                    fontFamily: 'SansitaSwashed',
                  letterSpacing: 1.0,
                  wordSpacing: 2.0,
                ),),
                SizedBox(height: 4,),
                Text(
                  contact,style: (
                TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1.0,
                  wordSpacing: 2.0,
                  fontWeight: FontWeight.w700,
                    fontFamily: 'SansitaSwashed',
                )
                ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

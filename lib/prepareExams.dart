import 'package:flutter/material.dart';
import 'package:mini_app/services/database.dart';
import 'package:mini_app/widgets/widget.dart';

class PreapreExams extends StatefulWidget {
  @override
  _PreapreExamsState createState() => _PreapreExamsState();
}

class _PreapreExamsState extends State<PreapreExams> {
  Stream examsStream;
  DatabaseService databaseService = new DatabaseService();

  Widget examList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: StreamBuilder(
        stream: examsStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return ExamTile(
                      name: snapshot.data.documents[index].data["examName"],
                      examid: snapshot.data.documents[index].data["examId"],
                    );
                  });
        },
      ),
    );
  }
  @override
  void initState() {
    databaseService.getExamData().then((value){
      setState(() {
        examsStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: myAppBar(context)),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light, //to show battery signal symbols
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: examList(),
    );
  }
}

class ExamTile extends StatelessWidget {
  String name;
  String examid;

  ExamTile({@required this.name, @required this.examid});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 100,
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
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'SansitaSwashed',
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

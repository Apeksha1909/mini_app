import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/create_quiz.dart';
import 'package:mini_app/prepareExams.dart';
import 'package:mini_app/quizhome.dart';

class BottomNaviBar extends StatefulWidget {
  @override
  _BottomNaviBarState createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  int _selectIndex = 0;
  List<Widget> _widgeroptions = <Widget>[
    QuizHome(),CreateQuiz(),PreapreExams()
  ];

  void onItemTapped(int index){
    setState(() {
      _selectIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white24,
      body: Stack(
        //to position the navibar at the bottom stack is used
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              color: Colors.white,
              child: Stack(//to use shape behind icons stack is used
                children: <Widget>[
                  CustomPaint(
                    size: Size(size.width,80),
                    painter: MyCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,//takes the height factor and multiplies it with height of the child and uses the resulting height as the height of the center widget
                    child: FloatingActionButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CreateQuiz()
                        ));
                      },
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.add),elevation:0.1,
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.home),
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => QuizHome(),
                            ));
                          },
                        ),
                        //IconButton(
                         // icon: Icon(Icons.create_new_folder),
                          //onPressed: (){

                          //},
                        //),

                        Container(width: size.width*0.20,),
                        IconButton(
                          icon: Icon(Icons.library_books),
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context)=> PreapreExams(),
                              //builder: (context) => getjson("Area and Volume"),
                            ));
                          },
                        ),
                        //IconButton(
                         // icon: Icon(Icons.search),
                          //onPressed: (){

                          //},
                        //),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}
class MyCustomPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color =Colors.white..style=PaintingStyle.fill;
    Path path= Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width*0.20, 0, size.width*0.35, 0);//x1y1 with be the reference point and x2y2 is the end point
    path.quadraticBezierTo(size.width*0.40, 0, size.width*0.40, 20);
    path.arcToPoint(Offset(size.width*0.60,20),
    radius: Radius.circular(10.0),clockwise: false);
    path.quadraticBezierTo(size.width*0.60, 0, size.width*0.65, 0);
    path.quadraticBezierTo(size.width*0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 4, true);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/helper/functions.dart';
import 'package:mini_app/quizhome.dart';
import 'package:mini_app/services/auth.dart';
import 'package:mini_app/services/forgotpass.dart';
import 'package:mini_app/signup.dart';
import 'package:mini_app/splash.dart';
import 'package:mini_app/widgets/widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isUserLoggedIn =false;
  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus()async{
     HelperFunction.getUserLoggedInDetails().then((value){
       setState(() {
         _isUserLoggedIn =value;
       });
     });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizApp',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home:(_isUserLoggedIn ?? false) ? QuizHome(): MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey=GlobalKey<FormState>();
  String email,password;
  AuthService authService =new AuthService();
  bool _isHidden = true;
  bool _isLoading = false;

  void toggleVisibilityOfPassword(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  signIn()async{
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
     await authService.signInEmailAndPass(email, password).then((value){
       if(value!=null){
         setState(() {
           _isLoading = false;
         });
         HelperFunction.saveUserLoggedInDetails(isLoggedIn: true);
         Navigator.pushReplacement(context,MaterialPageRoute(
           builder: (context) => splashScreen(),
         ));
       }
     });

    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: appmyBar(context)),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,//to show battery signal symbols
        elevation: 0.0,//bcoz transparent give some grey color
        //Text(widget.title),
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
       ),
      ) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //stack bcoz the widget like container and all have default padding,so distance betwwen h and t will be to big
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: 50.0,fontWeight:FontWeight.bold,
                      fontFamily: 'Niconne'
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 155.0, 0.0, 0.0),
                  child: Text(
                    'There',
                    style: TextStyle(
                        fontSize: 50.0,fontWeight:FontWeight.bold,
                        fontFamily: 'Niconne'
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(120.0, 155.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 50.0,fontWeight:FontWeight.bold, color: Colors.lightBlue
                    ),
                  ),
                )
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child:Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val){
                      return val.isEmpty ? "Enter a valid EmailId" : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                        fontFamily: 'Amita',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent
                        )
                      )
                    ),
                    onChanged: (val){
                      email=val;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (val){
                      return val.isEmpty ? "Enter Password" : null;
                    },
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontFamily: 'Amita',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent
                            ),
                        ),
                      suffixIcon: IconButton(
                        onPressed: toggleVisibilityOfPassword,
                        icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),


                      )
                    ),
                    obscureText: _isHidden,
                    onChanged: (val){
                      password=val;
                    },
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    alignment: Alignment(1.0,0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                      onTap: (){
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) => ForgotPassword(),
                       ));
                      },
                      child: Text('Forgot Password',
                      style:TextStyle(
                        color: Colors.lightBlue,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      )
                    ),
                  ),
                  ),
                  SizedBox(height: 40.0,),
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
                            signIn();
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                fontFamily: 'Amita'
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),
                ],
              ) ,
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New to QuizApp ?',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(width: 5.0,),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ));
                },
                child:Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Satisfy',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ) ,)
            ],
          )
        ],
      )
    );
  }
}

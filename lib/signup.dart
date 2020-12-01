import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/main.dart';
import 'package:mini_app/services/auth.dart';
import 'package:mini_app/splash.dart';
import 'package:mini_app/widgets/widget.dart';

import 'helper/functions.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey=GlobalKey<FormState>();
  String name,email,password;
  AuthService authService =new AuthService();
  bool _isLoading = false;
  bool _isHidden = true;

  void toggleVisibilityOfPassword(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  signUp()async{
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
       await authService.signUpWithEmailAndPass(name,email, password).then((value){
         if(value!=null){
           setState(() {
             _isLoading = false;
           });
           HelperFunction.saveUserLoggedInDetails(isLoggedIn: true);
           Navigator.pushReplacement(context, MaterialPageRoute(
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
          elevation: 0.0,
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
                    padding: EdgeInsets.fromLTRB(15.0, 105.0, 0.0, 0.0),
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                          fontSize: 50.0,fontWeight:FontWeight.bold,
                           fontFamily: 'Niconne'
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(175.0, 105.0, 0.0, 0.0),
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
                        return val.isEmpty  ? "Enter Name" : null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Full NAME',
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
                        name=val;
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (val){
                        return val.isEmpty ? "Enter EmailId" : null;
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
                        return val.isEmpty ? "Enter Password(>6characters)" : null;
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
                               ),
                      ),
                      onChanged: (val){
                        password=val;
                      },
                      obscureText: _isHidden,
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      height: 40.0,
                      width: 350.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blueAccent,
                        color: Colors.blue,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            signUp();
                          },
                          child: Center(
                            child: Text(
                              'SignUp',
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
                  'Already have account ?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(width: 5.0,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
                  },
                  child:Text(
                    'Login',
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

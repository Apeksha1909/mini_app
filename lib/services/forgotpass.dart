import 'package:flutter/material.dart';
import 'package:mini_app/services/auth.dart';
import 'package:mini_app/widgets/widget.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey=GlobalKey<FormState>();
  String _warning;
  String email;
  AuthService authService =new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: appmyBar(context)),
    backgroundColor: Colors.transparent,
    brightness: Brightness.light,//to show battery signal symbols
        iconTheme: IconThemeData(color: Colors.black87),
    elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
          child: Center(
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (val){
                    return val.isEmpty ? "Enter a valid EmailId" : null;
                  },
                  style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
              labelText: 'EMAIL',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blueAccent
                  )
              )
          ),
          onChanged: (value) => email=value,
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    authService.sendPasswordResetEmail(email);
                    _warning = "A password link has been sent to $email";
                    Navigator.pop(context);
                  },
                    child: blueButton(context: context,label: "Submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

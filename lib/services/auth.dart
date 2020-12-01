import 'package:firebase_auth/firebase_auth.dart';

import '../user_mode.dart';

class AuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInEmailAndPass(String email, String password) async{
    try{
      //await for waiting till the function signinwithemailandpassword will (it takes
      // some time to) request to the server and accept that infomation from firebase.
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebase(firebaseUser);
     // return
    }catch(e){
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPass(String name,String email, String password)async{
    try{
      AuthResult authResult=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser=authResult.user;
      return _userFromFirebase(firebaseUser);
    }catch(e){
      print(e.toString());
    }
  }

  //get all data of user to show in profile
  Future getCurrentUserInfo()async{
    return await _auth.currentUser();
  }

  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //function for foget password
  Future sendPasswordResetEmail(String email)async{
    return _auth.sendPasswordResetEmail(email: email);
  }
}
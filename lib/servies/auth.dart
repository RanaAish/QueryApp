import 'package:ecommerce/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class auth {
  final _auth = FirebaseAuth.instance;
  Future<AuthResult> signup(String email, String password) async {
    final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<AuthResult> signin(String email, String password) async {
    final AuthResult authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future changePassword(String password) async{
    //Create an instance of the current user.
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      print("Succesfull changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
  Future logout() async {

      return await _auth.signOut();

  }
}

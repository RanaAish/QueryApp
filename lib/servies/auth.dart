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
}

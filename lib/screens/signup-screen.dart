import 'package:ecommerce/provider/provider.dart';
import 'package:ecommerce/provider/provider.dart';
import 'package:ecommerce/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/servies/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:ecommerce/screens/login-screen.dart';

class signup extends StatefulWidget {
  static String id = "signup";

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final Auth = auth();
  @override
  Widget build(BuildContext context) {
    String email, pass;
    double height = MediaQuery.of(context).size.height;
    return

      Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<provider>(context).isloading,
        child:
          Form(
            key: globalKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image(image: AssetImage("images/regulation.png"),width: 90,height: 90,),
                        Positioned(
                            bottom: -5,

                            child: Text(
                              "Exam",
                              style:
                              TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return 'Name is empty';
                      },
                      cursorColor: kMainColor,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter your Name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: kMainColor,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                      )),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return 'Email is empty';
                      },
                      cursorColor: kMainColor,
                      onSaved: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: kMainColor,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                      )),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return 'password is empty';
                      },
                      cursorColor: kMainColor,
                      obscureText: true,
                      onSaved: (value) {
                        pass = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: kMainColor,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                      )),
                ),
                SizedBox(
                  height: height * .05,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: Builder(
                      builder: (context) => FlatButton(

                        onPressed: () async {
                          final modelhud=Provider.of <provider>(context,listen: false);
                          modelhud.changeisloading(true);

                          if (globalKey.currentState.validate()) {

                            globalKey.currentState.save();
                            try {
                              final AuthResult authresult =
                              await Auth.signup(email, pass);
                            //  modelhud.changeisloading(false);
                              Navigator.pushNamed(context, home.id);
                            }  on PlatformException catch ( error) {
                              modelhud.changeisloading(false);

                              Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
                              print(error.message);
                            }
                          }
                         modelhud.changeisloading(false);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black,
                      ),
                    )),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Do have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context,loginscreen.id);
                      },
                        child: Text("Login",

                            style: TextStyle(color: Colors.black, fontSize: 16)))
                  ],
                )
              ],
            )),
      ),
    );
    
      

  }
}

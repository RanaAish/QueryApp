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
import 'package:ecommerce/servies/store.dart';
import 'package:ecommerce/model/user.dart';
import 'package:ecommerce/Animation/FadeAnimation.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class signup extends StatefulWidget {
  static String id = "signup";

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final Auth = auth();
  final s = store();
  @override
  Widget build(BuildContext context) {
    String email, pass ,name;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body:ModalProgressHUD(
          inAsyncCall: Provider.of<provider>(context).isloading,
          child: Form(
            key: globalKey,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/background.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 30,
                            width: 80,
                            height: 200,
                            child: FadeAnimation(
                                1,
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'images/light-1.png'))),
                                )),
                          ),
                          Positioned(
                            left: 140,
                            width: 80,
                            height: 150,
                            child: FadeAnimation(
                                1.3,
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'images/light-2.png'))),
                                )),
                          ),
                          Positioned(
                            right: 40,
                            top: 40,
                            width: 80,
                            height: 150,
                            child: FadeAnimation(
                                1.5,
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'images/clock.png'))),
                                )),
                          ),
                          Positioned(
                            child: FadeAnimation(
                                1.6,
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: Center(
                                    child: Text(
                                        translator.translate('signuptitle'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Pacifico', fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:30.0,right: 30.0,bottom: 30.0,top: 20),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                              1.8,
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top:2.0,bottom: 2.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]))),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          name = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) return translator.translate('valdionname');
                                        },
                                        keyboardType: TextInputType.text,
                                        cursorColor: kMainColor,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: kMainColor,
                                            ),
                                            hintText:  translator.translate('name'),
                                            hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top:2.0,bottom: 2.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]))),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          email = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) return translator.translate('vaildationemail');
                                        },
                                        keyboardType: TextInputType.text,
                                        cursorColor: kMainColor,
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: kMainColor,
                                            ),
                                            border: InputBorder.none,
                                            hintText:  translator.translate('email'),
                                            hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top:2.0,bottom: 2.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]))),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          pass = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) return translator.translate('validationpass');
                                        },
                                       obscureText: true,
                                        cursorColor: kMainColor,
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: kMainColor,
                                            ),
                                            border: InputBorder.none,
                                            hintText:  translator.translate('password'),
                                            hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                              2,
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child:Builder(
                                  builder: (context)=> FlatButton(
                                    onPressed: () async {
                                      final modelhud=Provider.of <provider>(context,listen: false);
                                      modelhud.changeisloading(true);
                                      if (globalKey.currentState.validate()) {

                                        globalKey.currentState.save();
                                        try {
                                          final AuthResult authresult =
                                          await Auth.signup(email, pass);
                                          user u=user(
                                              name: name,
                                              email: email,
                                              pass: pass,
                                              passconfirmed: pass,
                                              totalscore: "0",
                                              pic:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoRHQjaTpvr8Au0Bp4oDy6z-X1Fioy0c0yfQ&usqp=CAU");
                                          s.adduser(u);
                                          //  modelhud.changeisloading(false);
                                          Navigator.pushNamed(context, loginscreen.id);

                                        }  on PlatformException catch ( error) {
                                          modelhud.changeisloading(false);

                                          Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
                                          print(error.message);
                                        }
                                      }
                                      modelhud.changeisloading(false);
                                    },
                                    child: Center(
                                      child: Text(
                                        translator.translate('signuobuttontext'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                              1.5,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      translator.translate('rowsignuppart2'),
                                    style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                                  ),
                                  Text( translator.translate('question'),

                                      style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1))),
                                  GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context,loginscreen.id);
                                      },
                                      child: Text( translator.translate('rowsignuppart1'),

                                          style: TextStyle(color: Colors.black))),
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ) );
  }
}

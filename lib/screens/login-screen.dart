import 'package:flutter/material.dart';
import 'package:ecommerce/screens/adminhome.dart';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/screens/signup-screen.dart';
import 'package:ecommerce/servies/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/provider/logindata.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/Animation/FadeAnimation.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class loginscreen extends StatefulWidget {
  static String id ="loginscreen";
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

  final GlobalKey <FormState> globalKey =  GlobalKey<FormState>();
  final Auth=auth();
  bool isadmin=false;
  @override
  Widget build(BuildContext context) {
    String email,pass;
    double height =MediaQuery.of(context).size.height;
    final data=Provider.of <logindata>(context);


    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
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
                            fit: BoxFit.fill
                        )
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeAnimation(1, Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/light-1.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(1.3, Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/light-2.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(1.5, Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/clock.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          child: FadeAnimation(1.6, Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(translator.translate('signintitle'), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Pacifico', fontSize: 35,),
                            )),
                          )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:30.0,right: 30.0,bottom: 30.0,top: 20),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(1.8, Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10)
                                )
                              ]
                          ),
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
                                      hintText: translator.translate('email'),
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
                                      hintText: translator.translate('password'),
                                      hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 30,),
                        FadeAnimation(2, Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]
                              )
                          ),
                          child: Builder(builder: (context)=>FlatButton(onPressed: ()async{
                            if (globalKey.currentState.validate()) {
                            globalKey.currentState.save();
                            if (isadmin)
                            {
                              if( pass == "admin1234")
                                Navigator.pushNamed(context,adminhome.id);

                              else
                              {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text(translator.translate('adminmsg'))));
                              }
                            }
                            else
                            {
                              try{
                                final AuthResult authresult = await Auth.signin(
                                    email, pass);
                                data.changedata(email, pass);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => home(email: email,pass: pass,)));
                              }
                              catch(e)
                              {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
                              }
                            }
                          }
                          }, child: Center(
                            child: Text(translator.translate('signintitle'), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),),
                          ),),)
                        )),
                        SizedBox(height: 20,),
                        FadeAnimation(1.5,Column(children: [Text(translator.translate('rowsignin'), style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1))),
                          SizedBox(height: 20,),
                          Row(
                          children: <Widget>[
                            Expanded (
                                child:GestureDetector
                                  (
                                    onTap: (){
                                      setState(() {
                                        isadmin=true;
                                      });
                                    },
                                    child: Text(translator.translate('admin'),textAlign: TextAlign.center,style: TextStyle(color: isadmin ?Colors.white :Colors.black),)
                                )
                            ),
                            Expanded (child:  GestureDetector(
                              onTap: (){
                                setState(() {
                                  isadmin=false;
                                });
                              },
                              child: Text(translator.translate('user'),textAlign: TextAlign.center,style: TextStyle(color: isadmin ? Colors.black :Colors.white),),
                            ),)
                          ],
                        ),],) ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          )
    ));
  }
}
import 'package:flutter/material.dart';
import 'screens/login-screen.dart';
import 'screens/signup-screen.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/provider.dart';
import 'screens/conract.dart';
import 'package:ecommerce/screens/about.dart';
import 'package:ecommerce/screens/adminhome.dart';
import 'package:ecommerce/screens/questionnaire.dart';
import 'screens/editprofile.dart';
import 'package:ecommerce/provider/logindata.dart';
import 'package:ecommerce/screens/startscreen.dart';
import 'package:ecommerce/screens/showquetion.dart';
import 'package:ecommerce/screens/addque.dart';
import 'screens/startexam.dart';
import 'screens/change password.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers:
      [
        ChangeNotifierProvider <provider> (create: (context)=> provider(),),
        ChangeNotifierProvider <logindata> (create: (context)=> logindata(),),
      ]
      ,child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:startscreen.id,
      routes: {
        loginscreen.id: (context) => loginscreen(),
        signup.id:(context)=>signup(),
        home.id:(context)=>home(),
        contact.id:(context)=>contact(),
        about.id:(context)=>about(),
        adminhome.id:(context)=>adminhome(),
        questionnaire.id:(context)=>questionnaire(),
        editprofile.id:(context)=>editprofile(),
        startscreen.id:(context)=>startscreen(),
        addque.id:(context)=>addque(),
        showquetion.id:(context)=>showquetion(),
        startexam.id:(context)=>startexam(),
        changepassword.id:(context)=>changepassword(),
      },
    ),);

  }
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("e-commerce"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        ],
      ),
    ),
  );
}


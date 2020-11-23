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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider <provider> (create: (context) => provider(),
      child:
      MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute:home.id,
          routes: {
            loginscreen.id: (context) => loginscreen(),
            signup.id:(context)=>signup(),
            home.id:(context)=>home(),
            contact.id:(context)=>contact(),
            about.id:(context)=>about(),
            adminhome.id:(context)=>adminhome(),
            questionnaire.id:(context)=>questionnaire(),
            editprofile.id:(context)=>editprofile()

          }
      ),
    );
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


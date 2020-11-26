import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import '../const.dart';
import 'package:ecommerce/screens/signup-screen.dart';


class startscreen extends StatelessWidget {
  static String id = "startscreen";
  @override
  Widget build(BuildContext context) {
    final windowHeight = MediaQuery.of(context).size.height;
    final windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: kMainColor,
          title: Text('Online Exam'),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.white,
                ),
                onPressed: () {}),
            new IconButton(
                icon: Icon(
                  Icons.add_alert,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
            child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 60, bottom: 7),
                            padding: EdgeInsets.only(bottom: 11),
                            child: Text("Digital Information",
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 25)),
                          ),
                          SizedBox(
                            height: windowHeight * .01,
                          ),
                          Center(
                              child: Text(
                                "We make online exam easy,",
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            height: windowHeight * .01,
                          ),
                          Center(
                              child: Text("Using our app to take exam anywhere ",
                                  style: TextStyle(fontSize: 16)))
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 0, right: 30, left: 30),
                      child: Center(
                        child: Image(image: AssetImage("images/exam.gif")),
                      ),
                    ),
                    Container(
                      width: 260,
                      padding: EdgeInsets.only(top: 50, bottom: 80),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, signup.id);
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: kMainColor),
                    )
                  ],
                )))
    );
  }
}

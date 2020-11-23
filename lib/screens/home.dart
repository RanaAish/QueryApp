import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/screens/login-screen.dart';
import '../const.dart';
import 'package:ecommerce/servies/auth.dart';
import 'package:ecommerce/screens/signup-screen.dart';
import 'package:ecommerce/screens/conract.dart';
import 'package:ecommerce/screens/about.dart';
import 'package:ecommerce/screens/editprofile.dart';
import 'package:ecommerce/model/query.dart';
import 'package:ecommerce/servies/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/user.dart';

class home extends StatelessWidget {
  static String id = "home";
  final Auth = auth();
  String email, pass;
  home({Key key, @required this.email, this.pass}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _store = store();
    final query _query = ModalRoute.of(context).settings.arguments;
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
        drawer: StreamBuilder<QuerySnapshot>(
            stream: _store.loaduser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<user> users = [];
                for (var doc in snapshot.data.documents) {
                  var item = doc.data;
                  if (item[kuseremail] == email &&  item[kuserpass] == pass) {
                  users.add(user(
                      name: item[kusername],
                      email:item[kuseremail],
                      pic: item[kuserpicture]
                  ));
                  //break;
                  //}

                return new Drawer(
                  child: new ListView(
                    children: <Widget>[
//            header
                      new UserAccountsDrawerHeader(
                        accountName: Text(users[0].name),
                        accountEmail: Text(users[0].email),
                        currentAccountPicture: GestureDetector(
                          child: new CircleAvatar(
                            //backgroundColor: Colors.grey,
                              backgroundImage:users[0].pic == null
                                  ? AssetImage("images/buy.png")
                                  : NetworkImage(
                                  users[0].pic),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 2,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          color: kSecondaryColor,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, editprofile.id);
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: kMainColor,
                                            size: 19,
                                          ),
                                        ),
                                      )),
                                  /* Positioned(
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white60,
                              ),
                              top: 8,
                              bottom: 10,
                              right: 25,
                              left: 10,
                            )*/
                                ],
                              )),
                        ),
                        decoration: new BoxDecoration(color: kMainColor),
                      ),
//            body
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text('Home Page'),
                          leading: Icon(Icons.home),
                        ),
                      ),

                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text('My account'),
                          leading: Icon(Icons.person),
                        ),
                      ),

                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text('My Degrees'),
                          leading: Icon(Icons.border_color),
                        ),
                      ),

                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text('Exams'),
                          leading: Icon(Icons.assignment),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text('Comments'),
                          leading: Icon(Icons.comment),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          {
                            Navigator.pushNamed(context, contact.id);
                          }
                        },
                        child: ListTile(
                          title: Text('Contact'),
                          leading: Icon(Icons.call),
                        ),
                      ),

                      Divider(),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text('Settings'),
                          leading: Icon(
                            Icons.settings,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          {
                            {
                              Navigator.pushNamed(context, about.id);
                            }
                          }
                        },
                        child: ListTile(
                          title: Text('About'),
                          leading: Icon(
                            Icons.help,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => loginscreen()));
                        },
                        child: ListTile(
                          title: Text('Log out'),
                          leading: Icon(
                            Icons.transit_enterexit,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }}}),
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
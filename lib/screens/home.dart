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
import 'package:provider/provider.dart';
import 'package:ecommerce/screens/startexam.dart';
import 'package:ecommerce/screens/change password.dart';
import 'package:ecommerce/provider/logindata.dart';

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
    final data = Provider.of<logindata>(context);
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

                  if (item[kuseremail] == data.email &&
                      item[kuserpass] == data.pass) {
                    users.add(user(
                        name: item[kusername],
                        email: item[kuseremail],
                        pid: doc.documentID,
                        pic: item[kuserpicture]));
                    // break;
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
                                  backgroundColor: Colors.grey,
                                  backgroundImage: users[0].pic ==
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoRHQjaTpvr8Au0Bp4oDy6z-X1Fioy0c0yfQ&usqp=CAU'
                                      ? NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoRHQjaTpvr8Au0Bp4oDy6z-X1Fioy0c0yfQ&usqp=CAU')
                                      : NetworkImage(users[0].pic),
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
                                                    context, editprofile.id,
                                                    arguments: users[0]);
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
                            onTap: () {
                              Navigator.pushNamed(context, changepassword.id,
                                  arguments: users[0]);
                            },
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
                            onTap: () async {
                              await Auth.logout();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginscreen()));
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
                }
              } else {
                return Center(
                  child: Text("loading.........."),
                );
              }
            }),
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadquery(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // not save old values
              List<query> queries = [];
              for (var doc in snapshot.data.documents) {
                var item = doc.data;
                queries.add(query(
                    title: item[kQuerytitle],
                    des: item[kQuerydesc],
                    category: item[kQuerycategory],
                    pid: doc.documentID));
              }
              return ListView(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Container(
                      padding: EdgeInsets.only(right: 15.0),
                      width: MediaQuery.of(context).size.width - 30.0,
                      height: MediaQuery.of(context).size.height - 50.0,
                      child: ListView.builder(
                          itemBuilder: (context, index) => Container(
                                padding: EdgeInsets.only(
                                    top: 5, right: 10, left: 10),
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: kMainColor, width: 0.5),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ListTile(

                                    title: Text(queries[index].title),
                                    subtitle: Text(queries[index].des),
                                    trailing: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "Start",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: kMainColor,
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, startexam.id,
                                          arguments: queries[index].pid);
                                    },
                                  ),
                                ),
                              ),
                          itemCount: queries.length)),
                  SizedBox(height: 15.0)
                ],
              );
            } else {
              return Center(
                child: Text("loading.........."),
              );
            }
          },
        ));
  }
}

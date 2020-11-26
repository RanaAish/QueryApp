import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
class contact extends StatefulWidget {
  static String id = "contact";
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: kMainColor,
        title: Text('Online Exam'),
        actions: <Widget>[
          new IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sentiment_satisfied,
                color: Colors.white,
              )),
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
    height: height,
          child:Center(
            child:  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height:0,
                ),
                Text(
                  'Contact',style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold,fontFamily: 'Pacifico',),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("i\'m available for Updating app for the best",style: TextStyle(fontSize: 15,),textAlign: TextAlign.center,),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: 
                  Column(
                    children: <Widget>[
                      TextFormField(
                          validator: (value){
                            if(value.isEmpty)
                              return 'Name is empty';
                          },
                          cursorColor: kMainColor,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: kMainColor,
                              ),
                              filled: true,
                              fillColor: kSecondaryColor,
                              enabledBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  ) )
                          )
                      ),
                      SizedBox(
                        height: height*.01,
                      ),
                      TextFormField(
                          validator: (value){
                            if(value.isEmpty)
                              return 'Email is empty';
                          },
                          cursorColor: kMainColor,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: kMainColor,
                              ),
                              filled: true,
                              fillColor: kSecondaryColor,
                              enabledBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  ) )
                          )
                      ),
                      SizedBox(
                        height: height*.01,
                      ),
                      TextFormField(
                          maxLines: 7,
                          validator: (value){
                            if(value.isEmpty)
                              return 'Message is empty';
                          },
                          cursorColor: kMainColor,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Message',


                              filled: true,
                              fillColor: kSecondaryColor,
                              enabledBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  ) )
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 343,

                  padding: EdgeInsets.only(top: 30),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: kMainColor),
                )


              ],

            ),
          )
      ),
    ));
  }
}

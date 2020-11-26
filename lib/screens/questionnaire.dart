import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/servies/store.dart';
import 'package:ecommerce/model/query.dart';

class questionnaire extends StatefulWidget {
  static String id ="questionnaire";

  @override
  _questionnaireState createState() => _questionnaireState();
}

class _questionnaireState extends State<questionnaire> {
  String title ,desc,category;
  final s= store();
  final GlobalKey <FormState> globalKey =  GlobalKey<FormState>();
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
              icon: Icon(
                Icons.sentiment_satisfied,
                color: Colors.white,
              ),
              onPressed: () {
              }),
          new IconButton(
              icon: Icon(
                Icons.add_alert,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: Form(
        key: globalKey,
        child: Center(
          child: Container(
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    onSaved:(value)
                    {
                      title=value;
                    },
                    cursorColor: kMainColor,
                    decoration: InputDecoration(
                        hintText: 'Title',
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
                  height: height * .01,
                ),
                TextFormField(
                    onSaved:(value)
                    {
                      desc=value;
                    },
                    cursorColor: kMainColor,
                    decoration: InputDecoration(
                        hintText: 'Description',
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
                  height: height * .01,
                ),
                TextFormField(
                    onSaved:(value)
                    {
                      category=value;
                    },
                    cursorColor: kMainColor,
                    decoration: InputDecoration(
                        hintText: 'Category',
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
                  height:20,
                ),
                Container(
                  width: 330,
                  child: RaisedButton(onPressed: (){
                    if(globalKey.currentState.validate())
                      globalKey.currentState.save();
                       s.addquery(query(title: title,des: desc,category: category));
                       Navigator.pop(context);
                   // globalKey.currentState.reset();
                  },
                      child:Text("Add", style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: kMainColor),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

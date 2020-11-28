import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'dart:core';
import 'package:ecommerce/screens/addque.dart';
import 'package:ecommerce/servies/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/question.dart';
import 'package:ecommerce/screens/home.dart';
class startexam extends StatefulWidget {

  static String id = "startexam";
  @override
  _startexamState createState() => _startexamState();
}

class _startexamState extends State<startexam> {

  final _store = store();
  List<String> allAnswers = [];
  int questionNo = 0;
  int scores = 0;
  final GlobalKey <FormState> globalKey =  GlobalKey<FormState>();
  int groupValue = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();

  getDecoration(hint,_color) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffdfdfdf)),
    );
    return InputDecoration(
      hintText: "$hint",
      hintStyle: TextStyle(color:_color),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
    );
  }


  @override
  Widget build(BuildContext context) {
    String pid_query = ModalRoute.of(context).settings.arguments;
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
      body:StreamBuilder<QuerySnapshot>(
        stream: _store.loadquestion(),
        builder: (context, snapshot) {
          List<quesion> questions = [];
          if (snapshot.hasData) {
            // not save old values
            for (var doc in snapshot.data.documents) {
              var item = doc.data;
              if (item[kcqueryid] == pid_query) {
                questions.add(quesion(
                    title: item[kquetitle],
                    query_id: pid_query,
                    correctanswer: item[kquecorrectanswer],
                    list_of_choices: item[kquelistofoptions]

                ));
              }
            }
            return
              // child: Center(
              Container(
                  padding: EdgeInsets.only(top: 50),
                  //width: 360,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: titleController,
                              decoration: getDecoration(questions[questionNo].title,Colors.red),
                            ),
                          ),
                          RadioListTile(
                            groupValue: groupValue,
                            value: 0,
                            activeColor: Colors.green,
                            title: TextFormField(
                              controller: oneController,

                              decoration: getDecoration(questions[questionNo].list_of_choices[0],Colors.green),
                            ),
                            onChanged: (t) {
                              setState(() {
                                groupValue = 0;
                              });
                            },
                          ),
                          RadioListTile(
                            groupValue: groupValue,
                            value: 1,
                            activeColor: Colors.blue,
                            title: TextFormField(
                              controller: twoController,
                              onSaved:(String value1)
                              {
                                twoController.text=value1;
                              },
                              decoration: getDecoration(questions[questionNo].list_of_choices[1],Colors.blue),

                            ),
                            onChanged: (t) {
                              setState(() {
                                groupValue = 1;
                              });
                            },
                          ),
                          RadioListTile(
                            groupValue: groupValue,
                            value: 2,
                            activeColor: Colors.green,
                            title: TextFormField(
                              controller: threeController,
                              onSaved:(String value2)
                              {
                                threeController.text=value2;
                              },
                              decoration: getDecoration(questions[questionNo].list_of_choices[2],Colors.green),

                            ),
                            onChanged: (t) {
                              setState(() {
                                groupValue = 2;
                              });
                            },
                          ),
                          RadioListTile(
                            groupValue: groupValue,
                            value: 3,
                            activeColor: Colors.blueAccent,
                            title: TextFormField(
                              controller: fourController,
                              onSaved:(String value3)
                              {
                                fourController.text=value3;
                              },
                              decoration: getDecoration(questions[questionNo].list_of_choices[3],Colors.blueAccent),

                            ),
                            onChanged: (t) {
                              setState(() {
                                groupValue = 3;
                              });
                            },
                          ),
                          SizedBox(
                            height:25.0,
                          ),
                          Container(
                            width: 150,
                            child: RaisedButton(onPressed: (){
                              if (groupValue != null && questionNo <= questions.length-1 ) {
                                List<String> all = [];
                                all.add(questions[questionNo].list_of_choices[0]);
                                all.add(questions[questionNo].list_of_choices[1]);
                                all.add(questions[questionNo].list_of_choices[2]);
                                all.add(questions[questionNo].list_of_choices[3]);
                                print(groupValue);
                                var correct = all[groupValue];
                                print(correct);
                                if(correct == questions[questionNo].correctanswer)
                                {
                                  setState(() {
                                    scores =scores+1;
                                  });
                                }
                                setState(() {
                                  if(questionNo == questions.length -1)
                                  {
                                    showResult();
                                  }
                                  else
                                  {
                                    questionNo =questionNo +1;
                                    groupValue=0;
                                  }
                                });
                              }
                              else
                              {
                                showResult();
                              }

                              print (scores);},
                                child:Text("Next", style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: kMainColor),
                          ),
                        ],),
                    ),
                  ));
          } else {
            return Center(
              child: Text("loading.........."),
            );
          }
        },
      ),
    );
  }
  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Text(
          "Correct Answers : $scores",
          style:TextStyle(color: Colors.red,fontSize: 20),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("CANCEL"),
            onPressed: () {
              Navigator.pushNamed(context,home.id);
            },
          ),
          FlatButton(
            child: Text("RETRY"),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
                questionNo=0;
                groupValue=0;
                scores=0;
              });
            },
          )
        ],
      ),
    );
  }
}

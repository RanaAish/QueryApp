import 'dart:async';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'dart:core';
import 'package:ecommerce/servies/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/question.dart';
import 'package:ecommerce/screens/report.dart';
import 'package:ecommerce/model/languge.dart';
import 'package:ecommerce/provider/logindata.dart';
import 'package:provider/provider.dart';



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
  String tittle, vrtitile;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  int groupValue = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();

  getDecoration(hint, _color) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffdfdfdf)),
    );
    return InputDecoration(
      hintText: "$hint",
      hintStyle: TextStyle(color: _color),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
    );
  }

  @override
  Widget build(BuildContext context) {
  //  query _query = ModalRoute.of(context).settings.arguments;
    //String pid_query = _query.pid;
    String pid_query=ModalRoute.of(context).settings.arguments;
    final data = Provider.of<logindata>(context);
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: kMainColor,
        title: Text(translator.translate('appbartitile')),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(3.0),
              child: DropdownButton(
                  onChanged: (languge langua) {
                    print(langua.name);
                  },
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  items: languge
                      .languageslist()
                      .map<DropdownMenuItem<languge>>((lang) =>
                          DropdownMenuItem(
                            value: lang,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text(lang.name)],
                            ),
                          ))
                      .toList())),
          new IconButton(
            onPressed: () {},
            icon: vrtitile == "Sucess"
                ? Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.white,
                  )
                : Icon(Icons.sentiment_dissatisfied, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
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
                    list_of_choices: item[kquelistofoptions]));
              }
            }
            return
                // child: Center(
                Container(
                    padding: EdgeInsets.only(top: 50),
                    //width: 360,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextFormField(
                                controller: titleController,
                                decoration: getDecoration(
                                    questions[questionNo].title, Colors.blue),
                              ),
                            ),
                            RadioListTile(
                              groupValue: groupValue,
                              value: 0,
                              activeColor: Colors.blue,
                              title: TextFormField(
                                controller: oneController,
                                decoration: getDecoration(
                                    questions[questionNo].list_of_choices[0],
                                    Colors.black),
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
                                onSaved: (String value1) {
                                  twoController.text = value1;
                                },
                                decoration: getDecoration(
                                    questions[questionNo].list_of_choices[1],
                                    Colors.black),
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
                              activeColor: Colors.blue,
                              title: TextFormField(
                                controller: threeController,
                                onSaved: (String value2) {
                                  threeController.text = value2;
                                },
                                decoration: getDecoration(
                                    questions[questionNo].list_of_choices[2],
                                    Colors.black),
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
                              activeColor: Colors.blue,
                              title: TextFormField(
                                controller: fourController,
                                onSaved: (String value3) {
                                  fourController.text = value3;
                                },
                                decoration: getDecoration(
                                    questions[questionNo].list_of_choices[3],
                                    Colors.black),
                              ),
                              onChanged: (t) {
                                setState(() {
                                  groupValue = 3;
                                });
                              },
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Container(
                              width: 150,
                              child: RaisedButton(
                                  onPressed: () {
                                    if (groupValue != null &&
                                        questionNo <= questions.length - 1) {
                                      List<String> all = [];
                                      all.add(questions[questionNo]
                                          .list_of_choices[0]);
                                      all.add(questions[questionNo]
                                          .list_of_choices[1]);
                                      all.add(questions[questionNo]
                                          .list_of_choices[2]);
                                      all.add(questions[questionNo]
                                          .list_of_choices[3]);
                                      print(groupValue);
                                      var correct = all[groupValue];
                                      print(correct);
                                      if (correct ==
                                          questions[questionNo].correctanswer) {
                                        setState(() {
                                          scores = scores + 1;
                                        });
                                      }

                                      setState(() {
                                        if (questionNo ==
                                            questions.length - 1) {
                                          showResult(data.userid, pid_query);
                                        } else {
                                          questionNo = questionNo + 1;
                                          groupValue = 0;
                                        }
                                      });
                                    } else {
                                      showResult(data.userid, pid_query);
                                    }

                                    print(scores);
                                  },
                                  child: Text(
                                    translator.translate('next'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: kMainColor),
                            ),
                            // SizedBox(height:100),
                            //Container(
                            //child: Icon(Icons.check_circle,color: correct==
                            //  questions[questionNo].correctanswer ? Colors.green: Colors.white),
                            //)
                          ],
                        ),
                      ),
                    ));
          } else {
            return Center(
              child: Text(translator.translate('load')),
            );
          }
        },
      ),
    );
  }

  showResult(String user_id, String queryid) {
    String des;
    double finalscore;

    final data = Provider.of<logindata>(context);

    finalscore = ((scores / 20) * 100);
    des = translator.translate('correctanswer') +
        finalscore.round().toString() +
        "%";
    setState(() {
      _store.updatedata(
          ({
            kuserscore: finalscore.round().toString(),
          }),
          user_id);
      _store.updatecategory(
          ({kcategoryscore: finalscore.round().toString()}), queryid);
      data.gettotalscore(finalscore.round().toString());
      print(data.totalscore);
    });

    print(user_id);
    if (scores >= 2) {
      setState(() {
        vrtitile = "Sucess";
        tittle = translator.translate('sucess');
      });
    } else {
      setState(() {
        vrtitile = "Failure";
        tittle = translator.translate('fauire');
      });
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: dialogcontent(context, tittle, des,queryid),
            ));
    /*AlertDialog(
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
    );*/
  }

  dialogcontent(BuildContext context, String title, String description,String pid) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 100, right: 16, bottom: 16, left: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(height: 16.0),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
              SizedBox(height: 24.0),
              Align(
                  alignment: Alignment.bottomRight,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    FlatButton(
                        child: Text(
                          translator.translate("RETRY"),
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                            questionNo = 0;
                            groupValue = 0;
                            scores = 0;
                          });
                        }),
                    /* FlatButton(
                      child: Text(translator.translate("CANCEL"),style: TextStyle(color:Colors.blueAccent,fontSize: 16)),
                      onPressed: () {
                        Navigator.pushNamed(context, home.id);
                      },
                    ),*/
                    FlatButton(
                      child:Text(pid =="btUe20myhVex9ItcRyO8"?
                          translator.translate("Continue"):translator.translate("Report"),
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 16)),
                      onPressed: () {
                        if(pid == "btUe20myhVex9ItcRyO8")
                          {
                            String id="fPbWRpiIi9WDWDnkAisl";
                            Navigator.pushNamed(context, startexam.id,
                                arguments:id);
                          }
                        else
                          {
                           // Navigator.pop(context);
                            //Navigator.pop(context);
                            //Navigator.pop(context);
                            Navigator.pushNamed(context, report.id);
                          }

                      },
                    )
                  ])),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            //backgroundColor: Colors.blueAccent,
            backgroundImage: AssetImage("images/AlVw.gif"),
            radius: 50,
          ),
        ),
      ],
    );
  }
}

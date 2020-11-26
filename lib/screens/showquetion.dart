import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/screens/addque.dart';
import 'package:ecommerce/servies/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/question.dart';

class showquetion extends StatefulWidget {
  static String id = "showque";
  @override
  _showquetionState createState() => _showquetionState();
}

class _showquetionState extends State<showquetion> {
  final _store = store();

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

                ));
              }
            }
            return ListView.builder(
                itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: kMainColor, width: 0.5),
                            borderRadius: BorderRadius.circular(50)),
                        child: ListTile(
                          title: Text(questions[index].title),
                          trailing: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                itemCount: questions.length);
          } else {
            return Center(
              child: Text("loading.........."),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, addque.id, arguments: pid_query);
        },
        child: Icon(Icons.add),
        backgroundColor: kMainColor,
      ),
    );
  }
}

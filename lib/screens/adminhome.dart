import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/screens/login-screen.dart';
import '../const.dart';
import 'package:ecommerce/screens/conract.dart';
import 'package:ecommerce/screens/about.dart';
import 'questionnaire.dart';
import 'package:ecommerce/servies/store.dart';
import 'package:ecommerce/model/query.dart';
import 'package:ecommerce/screens/showquetion.dart';
class adminhome extends StatefulWidget {
  static String id = "admin";
  @override
  _adminhomeState createState() => _adminhomeState();
}

class _adminhomeState extends State<adminhome> {
  final  _store=store();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
      body:StreamBuilder<QuerySnapshot>(

        stream:_store.loadquery(),
        builder:(context,snapshot)
        {
          if(snapshot.hasData)
          {
            // not save old values
            List<query> queries=[];
            for (var doc in snapshot.data.documents) {
              var item=doc.data;
              queries.add(query(
                  title: item[kQuerytitle],
                  des: item[kQuerydesc],
                  category: item[kQuerycategory],
                  pid: doc.documentID
              ));
            }
            return ListView.builder(itemBuilder:(context,index)=>Container( padding:EdgeInsets.only(top: 5,right: 10,left: 10) ,child: Card(  elevation: 2,
              shape: RoundedRectangleBorder(
                  side: BorderSide( color: kMainColor, width: 0.5),
                  borderRadius: BorderRadius.circular(50)),
              child: ListTile(title:Text(queries[index].title),
                trailing: Icon(Icons.arrow_forward_ios,color:kMainColor,size: 16,),onTap: ()
                {
                  Navigator.pushNamed(context,showquetion.id ,arguments: queries[index].pid);

                },),),),itemCount: queries.length);
          }
          else
          {
            return Center(child: Text("loading.........."),);
          }
        },),floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, questionnaire.id);
      },
      child: Icon(Icons.add),
      backgroundColor: kMainColor,

    ),
    ) ;
  }
}
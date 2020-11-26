import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/servies/store.dart';
import 'package:ecommerce/model/question.dart';

class addque extends StatefulWidget {
  static String id = "addque";

  @override
  _addqueState createState() => _addqueState();
}

class _addqueState extends State<addque> {
  String title;
  final s= store();
  final GlobalKey <FormState> globalKey =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String pid_query=  ModalRoute.of(context).settings.arguments;
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
            child:
                Container(
                  padding: EdgeInsets.only(bottom: 250),
                  width: 360,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center
                    ,children: [
                      TextFormField(
                          onSaved:(value)
                          {
                            title=value;
                          },
                          maxLines: 3,
                          cursorColor: kMainColor,
                          decoration: InputDecoration(
                              hintText: 'Enter Quesion',
                              hintStyle: TextStyle(color:Colors.blue),

                              filled: true,
                              fillColor: Colors.black12,
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
                        width: 340,
                        child: RaisedButton(onPressed: (){
                          if(globalKey.currentState.validate())
                            globalKey.currentState.save();
                         s..addquesion(quesion(title: title,query_id: pid_query));
                          Navigator.pop(context);
                        },
                            child:Text("Add", style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: kMainColor),
                      ),
                    ],),
                ),
          )
      ),
    );
  }
}

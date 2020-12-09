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
  int groupValue = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();

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
      body:Directionality(
        textDirection: TextDirection.rtl,
          child: Form(
        key: globalKey,
        // child: Center(
        child:
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
                      decoration: getDecoration("Question name",Colors.blue),

                      validator: (t) {
                        if (t.isEmpty)
                          return "*Required field";
                        else
                          return null;
                      },
                    ),
                  ),
                  RadioListTile(

                    groupValue: groupValue,
                    value: 0,
                    activeColor: Colors.blue,
                    title: TextFormField(
                      controller: oneController,
                      decoration: getDecoration("Option 1",Colors.black),
                      validator: (t) {
                        if (t.isEmpty)
                          return "*Required field";
                        else
                          return null;
                      },
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
                      decoration: getDecoration("Option 2",Colors.black),

                      validator: (t) {
                        if (t.isEmpty)
                          return "*Required field";
                        else
                          return null;
                      },
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
                      decoration: getDecoration("Option 3",Colors.black),
                      validator: (t) {
                        if (t.isEmpty)
                          return "*Required field";
                        else
                          return null;
                      },
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
                      decoration: getDecoration("Option 4",Colors.black),
                      validator: (t) {
                        if (t.isEmpty)
                          return "*Required field";
                        else
                          return null;
                      },
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
                      if (globalKey.currentState.validate()) if (oneController.text.isNotEmpty &&
                          twoController.text.isNotEmpty &&
                          threeController.text.isNotEmpty &&
                          fourController.text.isNotEmpty){
                        globalKey.currentState.save();
                        List<String> all = [];
                        all.add(oneController.text);
                        all.add(twoController.text);
                        all.add(threeController.text);
                        all.add(fourController.text);
                        var correct = all[groupValue];
                        s..addquesion(quesion(title: titleController.text,query_id: pid_query,correctanswer:correct,list_of_choices: all));
                        Navigator.pop(context);
                      }},
                        child:Text("Add", style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: kMainColor),
                  ),
                ],),
            ),
          ),
        ), //     )
      ),)
    );
  }
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
}
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/home.dart';

class customdialog extends StatelessWidget {

  final String title,description,buttontext;
  final Image img;

  customdialog({this.title,this.description,this.buttontext,this.img});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogcontent(context),
    );
  }
  dialogcontent(BuildContext context) {

    return Stack(
      children: <Widget> [
        Container(
          padding: EdgeInsets.only(
            top: 100,
            right: 16,
            bottom: 16,
            left: 16
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius:BorderRadius.circular(17),
            boxShadow:[
              BoxShadow(
              color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0,10.0),
            ),]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Text(
                title,
                style:TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                )
              ),
              SizedBox(height:16.0),
              Text(description,style: TextStyle(
                fontSize: 16
              ),)
              , SizedBox(height:24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.pushNamed(context,home.id);
                  },
                ),
              ),
            ],
          ),
        ),
       Positioned(
         top:0,
         left: 16,
           right: 16,
         child: CircleAvatar(
           backgroundColor: Colors.blueAccent,
           radius: 50,
         ),

        ),
      ],
    );
  }

}


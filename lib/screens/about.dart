import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce/const.dart';

class about extends StatefulWidget {
  static String id = "about";

  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    final windowHeight = MediaQuery.of(context).size.height;
    final windowWidth = MediaQuery.of(context).size.width;
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/digtal.png'),
          AssetImage('images/about.png'),
          AssetImage('images/do.jpg')
        ],
        autoplay: false,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),
    );
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
        backgroundColor: Colors.white,
        body: Container(
          child: Container(
              child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 100, right: 10, left: 10),
                child: Center(
                  child: Image(
                    image: AssetImage("images/about.png"),
                    height: 200,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 5),
                padding: EdgeInsets.only(bottom: 0),
                child: Center(
                  child:Column(
                    children: <Widget>[
                      Text("We use Digital transformation to apply",
                        style: TextStyle( fontSize: 16,),textAlign: TextAlign.center,),
                      SizedBox(
                        height: windowHeight * .01,
                      ),
                      Text("taking exam easy .whether you want to take exam  ",
                        style: TextStyle( fontSize: 16,),textAlign: TextAlign.center,),
                      SizedBox(
                        height: windowHeight * .01,
                      ),
                      Text("any where , know your strengths and weaknesses ,",

                        style: TextStyle( fontSize: 16,),textAlign: TextAlign.center,),
                      SizedBox(
                        height: windowHeight * .01,
                      ),
                      Text( "chat with  Your teachers and colleagues, notify you ",
                        style: TextStyle( fontSize: 16,),textAlign: TextAlign.center,),
                      SizedBox(
                        height: windowHeight * .01,
                      ),
                      Text(" exam to study,Your level in each question",style: TextStyle( fontSize: 16,),textAlign: TextAlign.center)
                    ],
                  )
                ),
              ),
              Container(
                width: 260,
                padding: EdgeInsets.only(top: 60, bottom: 80),
                child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Read More',
                      style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: kMainColor),
              )
            ],
          )),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import '../const.dart';
import 'package:ecommerce/screens/signup-screen.dart';
import 'package:ecommerce/model/languge.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class startscreen extends StatelessWidget {
  static String id = "startscreen";
  @override
  Widget build(BuildContext context) {
    final windowHeight = MediaQuery.of(context).size.height;
    final windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: kMainColor,
          title: Text(translator.translate('appbartitile')),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButton(
                    onChanged: (languge langua){
                      print(langua.name);
                    },
                    underline: SizedBox(),
                    onTap: (){ } ,
                    icon: Icon(Icons.language,color: Colors.white,),
                    items:
                    languge.languageslist().map <DropdownMenuItem<languge>>((lang) =>DropdownMenuItem(
                      value: lang,
                      onTap: (){translator.setNewLanguage(context, newLanguage:lang.languagecode, restart: true);},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(lang.name)],
                      ),

                    ) ).toList())
            ),
            new IconButton(
                icon: Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.white,
                ),
                onPressed: () {}),

          ],
        ),
        backgroundColor: Colors.white,
        body:SafeArea(
      child: SingleChildScrollView(child : Container(
            child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 60, bottom: 7),
                            padding: EdgeInsets.only(bottom: 11),
                            child: Text(translator.translate('appTitle'),
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 25)),
                          ),
                          SizedBox(
                            height: windowHeight * .01,
                          ),
                          Center(
                              child: Text(translator.translate('textAreafirst')
                                ,
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            height: windowHeight * .01,
                          ),
                          Center(
                              child: Text(translator.translate('textAreasecond'),
                                  style: TextStyle(fontSize: 16)))
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 0, right: 30, left: 30),
                      child: Center(
                        child: Image(image: AssetImage("images/transform.png"),height:350,width: 500,),
                      ),
                    ),
                    Container(
                      width: 260,
                      padding: EdgeInsets.only(top: 20, bottom: 110),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, signup.id);
                          },
                          child: Text(translator.translate('buttonTitle')
                            ,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: kMainColor),
                    )
                  ],
                )))))
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/servies/store.dart';
import 'package:ecommerce/model/user.dart';
import 'package:ecommerce/servies/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/logindata.dart';

class changepassword extends StatefulWidget {
  static String id = "changepassword";

  @override
  _changepasswordState createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  final _globalkey = GlobalKey<FormState>();
  String oldpass, newpass, confirmpass;
  final s = store();
  auth _auth=auth();


  @override
  Widget build(BuildContext context) {
    user _user = ModalRoute.of(context).settings.arguments;
    final data = Provider.of<logindata>(context);
    double height = MediaQuery.of(context).size.height;
    List<user> users = [];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: kMainColor,
            ),
          ),
        ),
        body: Container(

          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
          child: Form(
              key: _globalkey,
              child: ListView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  children: <Widget>[
                    //  padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: kMainColor),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        oldpass = value;
                      },
                      initialValue: data.pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 2),
                          labelText: 'Old Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      validator: (value){
                        _globalkey.currentState.save();
                        if(value.isEmpty)
                        {
                          return "please enter New password";
                        }
                        if(newpass.length <6 )
                        {
                          return "password at least 6 leterrs";
                        }


                      },
                      onSaved: (value) {
                        setState(() {
                          newpass = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 2),
                          labelText: 'New Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        setState(() {
                          confirmpass = value;
                        });
                      },
                      validator: (value) {
                        _globalkey.currentState.save();
                        if(value.isEmpty)
                        {
                          return "please enter confirm password";
                        }
                        if(newpass != confirmpass)
                        {
                          return "pass don't match";
                        }

                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 2),
                          labelText: 'Confirm Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      //  obscureText: true,
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlineButton(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {},
                          child: Text("CANCEL",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black)),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_globalkey.currentState.validate())
                            {
                              _globalkey.currentState.save();
                              _auth.changePassword(newpass);
                              s.updatedata(
                                  ({
                                    kuserpass: newpass,
                                    kuserpassconfirmed:newpass,
                                  }),
                                  _user.pid);

                              data.setpass(newpass);
                              print(data.pass);
                              Navigator.pop(context);
                            }
                          },
                          color: kMainColor,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ])),
        ));
  }
}

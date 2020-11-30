import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:ecommerce/servies/store.dart';
import 'package:ecommerce/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/logindata.dart';
import 'package:http/http.dart';
import 'dart:core';

class editprofile extends StatefulWidget {
  static String id = "editprofile";
  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  final ImagePicker _picker = ImagePicker();

  File _imageFile;
  final s = store();
  String name, email, pass, confirmpass, picpath;
  final _globalkey = GlobalKey<FormState>();


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
        body: StreamBuilder<QuerySnapshot>(
            stream: s.loaduser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var doc in snapshot.data.documents) {
                  var item = doc.data;
                  if (item[kuseremail] == data.email &&
                      item[kuserpass] == data.pass) {
                    users.add(user(
                        name: item[kusername],
                        email: item[kuseremail],
                        pid: doc.documentID,
                        pic: item[kuserpicture]));
                    //   break;
                  }
                }
                return Form(
                    key: _globalkey,
                    child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        children: <Widget>[
                          //  padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: kMainColor),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          imageProfile(context, users[0].pic),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(

                            onSaved: (value) {
                              name = value;
                            },
                           initialValue: users[0].name,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 2),
                                labelText: 'Full Name',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                              email = value;
                            },
                            initialValue: data.email,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 2),
                                labelText: 'Email',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                               // hintText: data.email,
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
                              pass = value;
                            },
                            initialValue: data.pass,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 2),
                                labelText: 'Password',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: data.pass,
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              confirmpass = value;
                            },
                            obscureText: true,
                            initialValue: data.pass,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 2),
                                labelText: 'Confirm Password',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          ),
                          SizedBox(
                            height: 40,
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
                                  var storageimag = FirebaseStorage.instance
                                      .ref()
                                      .child(_imageFile.path);
                                  var task = storageimag.putFile(_imageFile);
                                  picpath = await (await task.onComplete)
                                      .ref
                                      .getDownloadURL();
                                  if (_globalkey.currentState.validate())
                                    _globalkey.currentState.save();
                                  s.updatedata(({
                                    kusername:name,
                                    kuserpass:pass,
                                    kuseremail:email,
                                    kuserpassconfirmed:confirmpass,
                                    kuserpicture:picpath

                                  }),_user.pid);
                                  Navigator.pop(context);
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
                        ]));
              }
            }));
  }

  Widget imageProfile(BuildContext context, String path) {
    return Center(
        child: Stack(children: <Widget>[
      CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? NetworkImage(
                  path)
              : FileImage(_imageFile) // : NetworkImage(path),
          ),
      Positioned(
          bottom: 11.0,
          right: 0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: kMainColor,
              size: 29.0,
            ),
          )),
    ]));
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    var pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}

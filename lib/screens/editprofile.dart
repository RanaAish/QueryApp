import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:ecommerce/servies/store.dart';
import 'package:ecommerce/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class editprofile extends StatefulWidget {
  static String id = "editprofile";
  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {

  final ImagePicker _picker = ImagePicker();
   File _imageFile;
  final s = store();
  String name, email, pass, confirmpass,picpath;
  final _globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
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
        body: Form(
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
                  imageProfile(context),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    onSaved:(value)
                    {
                      name=value;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 2),
                        labelText: 'Full Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: '',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    onSaved:(value)
                    {
                      email=value;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 2),
                        labelText: 'Email',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: '',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    onSaved:(value)
                    {
                      pass=value;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 2),
                        labelText: 'Password',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: '',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    onSaved:(value)
                    {
                      confirmpass=value;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 2),
                        labelText: 'Confirm Password',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: '',
                        labelStyle: TextStyle(
                          fontSize: 16,
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
                          if(_globalkey.currentState.validate())
                          _globalkey.currentState.save();
                          var storageimag=FirebaseStorage.instance.ref().child(_imageFile.path);
                           var task =storageimag.putFile(_imageFile);
                            picpath=await (await task.onComplete).ref.getDownloadURL();
                          s.adduser(user(name: name,email: email,pass: pass,passconfirmed: confirmpass,pic: picpath));
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
                ])));
  }

  Widget imageProfile(BuildContext context) {
    return Center(
        child: Stack(children: <Widget>[
      CircleAvatar(
        radius: 80.0,
        backgroundImage: _imageFile == null
            ? AssetImage("images/buy.png")
            : FileImage(_imageFile),
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
    var pickedFile = await ImagePicker.pickImage (
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}

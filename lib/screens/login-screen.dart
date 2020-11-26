import 'package:flutter/material.dart';
import 'package:ecommerce/screens/adminhome.dart';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/screens/signup-screen.dart';
import 'package:ecommerce/servies/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/provider/logindata.dart';
import 'package:provider/provider.dart';

class loginscreen extends StatefulWidget {
  static String id ="loginscreen";
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

  final GlobalKey <FormState> globalKey =  GlobalKey<FormState>();
  final Auth=auth();
  bool isadmin=false;
  @override
  Widget build(BuildContext context) {
    String email,pass;
    double height =MediaQuery.of(context).size.height;
    final data=Provider.of <logindata>(context);
    return Scaffold(

        backgroundColor:kMainColor,
        body: Form(
          key: globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height*.2,
                  child:Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(image:AssetImage("images/regulation.png"),width: 90,height: 90),
                      Positioned(
                          bottom: 0,
                          child:
                          Text("Exam",style: TextStyle(fontFamily: 'Pacifico',fontSize: 25),)
                      ),

                    ],
                  ) ,
                ),
              ),
              SizedBox(
                height: height*.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child:  TextFormField(
                    validator: (value){
                      if(value.isEmpty)
                        return 'email is empty';
                    },
                    cursorColor: kMainColor,
                    onSaved: (value)
                    {
                      email=value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: kMainColor,
                      ),
                      filled: true,
                      fillColor: kSecondaryColor,
                      enabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.white
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.white
                        ),

                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.white
                          )
                      ),
                    )
                ),
              ),
              SizedBox(
                height: height*.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child:  TextFormField(
                    validator: (value){
                      if(value.isEmpty)
                        return 'password is empty';
                    },
                    cursorColor: kMainColor,
                    onSaved: (value)
                    {
                      pass=value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: kMainColor,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
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
              ),
              SizedBox(
                height: height*.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child:Builder(
                    builder:(context) =>
                        FlatButton(onPressed: () async {
                          if (globalKey.currentState.validate()) {
                            globalKey.currentState.save();
                            if (isadmin)
                            {
                              if( pass == "admin1234")
                                Navigator.pushNamed(context,adminhome.id);

                              else
                              {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!")));
                              }
                            }
                            else
                            {
                              try{
                                final AuthResult authresult = await Auth.signin(
                                    email, pass);
                                data.changedata(email, pass);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => home(email: email,pass: pass,)));
                              }
                              catch(e)
                              {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
                              }
                            }
                          }
                        },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "login", style: TextStyle(color: Colors.white),),
                          color: Colors.black,)

                ),
              ),
              SizedBox(
                height: height*.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don\'t have an account?",style: TextStyle(color: Colors.white,fontSize: 16),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context,signup.id);
                      },
                      child: Text("Sign up",style: TextStyle(color: Colors.black,fontSize: 16)))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30 ,vertical:10),
                child: Row(
                  children: <Widget>[
                    Expanded (
                        child:GestureDetector
                          (
                            onTap: (){
                              setState(() {
                                isadmin=true;
                              });
                            },
                            child: Text("i\'m admin",textAlign: TextAlign.center,style: TextStyle(color: isadmin ? kMainColor :Colors.white),)
                        )
                    ),
                    Expanded (child:  GestureDetector(
                      onTap: (){
                        setState(() {
                          isadmin=false;
                        });
                      },
                      child: Text("i\'m user",textAlign: TextAlign.center,style: TextStyle(color: isadmin ? Colors.white :kMainColor),),
                    ),)
                  ],
                ),
              ),

            ],
          ),)
    );
  }
}
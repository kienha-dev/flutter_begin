import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/src/blocs/login_bloc.dart';
import 'package:flutter_first_app/src/resource/register_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'forgot_pass.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<bool> SavePre(bool check) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("check", check);
  return prefs.commit();
}
Future<bool> Savetoken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
  return prefs.commit();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();
  bool _showpass = false;
  int statusCode;
  String messega = "";
  bool isKYCVerified;
  String token = null;
  var extra;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  String url = 'http://142.93.253.93:81/web-api/login';
  Future<String> GetData() async {
    var respone = await http.post(Uri.encodeFull(url), headers: {
      "Accept": "application/json"
    }, body: {
      "username": _userController.text,
      "password": _passController.text
    });

    extra = json.decode(respone.body);
    statusCode = extra["statusCode"];
    var data = extra["data"];
    var user = data["user"];
    isKYCVerified = user["isKYCVerified"];
    token = data["token"];
    print(token);
    if (statusCode == 1) {
      messega = "";
      Savetoken(token);
      SavePre(isKYCVerified).then((bool committed) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else {
      setState(() {
        messega = extra["message"];
      });
    }
  }

  @override
  initState() {
    super.initState();
    // Add listeners to this class
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black38),
                    child: FlutterLogo()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Text("Hello \nWelcome Back",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: TextField(
                    controller: _userController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black26, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: "UserName",
                        labelStyle:
                            TextStyle(color: Colors.black38, fontSize: 15)),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: _passController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: !_showpass,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Colors.black38, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: GestureDetector(
                        onTap: onShowPass,
                        child: Text(
                          _showpass ? "Hide" : "Show",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      messega,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.lightBlue,
                    onPressed: onSignInClick,
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          text: "New User? ",
                          style: TextStyle(color: Colors.black38, fontSize: 15),
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()));
                                  },
                                text: "SIGN UP",
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 15)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "FORGOT PASSWORD",
                        style: TextStyle(
                          color: Colors.lightBlue, fontSize: 15),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPass()));
                          }
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSignInClick() {
    GetData();
  }

  void onShowPass() {
    setState(() {
      _showpass = !_showpass;
    });
  }
}

import 'package:begin/screens/mainAppScreen.dart';
import 'package:begin/services/locales.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:begin/screens/register.dart';
import 'package:begin/screens/forgotPass.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showpass = false;
  int status;
  String message = "";
  bool isKYCVerified;
  var extra;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  void getData(BuildContext context) async {
    final url = 'http://142.93.253.93:81/web-api/user/login';
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "username": _userController.text.trim(),
      "password": _passController.text
    };
    String jsonString = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    Response response =
        await post(url, headers: headers, body: jsonString, encoding: encoding);
    String responseBody = response.body;
    debugPrint(responseBody);
    dynamic data = await json.decode(response.body);
    status = data["status"];
    if (status == 1) {
      print(data["message"]);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Opps!!!"),
              content: new Text(data["message"]),
              actions: <Widget>[
                new FlatButton(
                    child: new Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
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
                child: Text(AppLocalizations.of(context).welTxtLoginScreen,
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
                        labelText: AppLocalizations.of(context).userNameTxtBox,
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
                          labelText: AppLocalizations.of(context).passwordTxtBox,
                          labelStyle:
                              TextStyle(color: Colors.black38, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            _showpass = !_showpass;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            _showpass = !_showpass;
                          });
                        },
                        child: Text(
                          _showpass ? AppLocalizations.of(context).hideTitle : AppLocalizations.of(context).showTitle,
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
                      message,
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
                    onPressed: () {
                      getData(context);
                    },
                    child: Text(
                      AppLocalizations.of(context).loginBtn,
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
                          text: AppLocalizations.of(context).newUserQues,
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
                                text: AppLocalizations.of(context).registerTitle,
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 15)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context).forgotPasswordTitle,
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPass()));
                            }),
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
}

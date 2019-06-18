import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/src/blocs/login_bloc.dart';
import 'package:flutter_first_app/src/resource/register_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();
  bool _showpass = false;

  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.userStream,
                    builder: (context, snapshot) => TextField(
                          controller: _userController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black26, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: "UserName",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Colors.black38, fontSize: 15)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    StreamBuilder(
                        stream: bloc.passStream,
                        builder: (context, snapshot) => TextField(
                              controller: _passController,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              obscureText: !_showpass,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black26, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      color: Colors.black38, fontSize: 15)),
                            )),
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
                    Container(
                      child: Text("FORGOT PASSWORD",
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 15)),
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
    setState(() {
      if (bloc.isValidInfor(_userController.text, _passController.text)) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  void onShowPass() {
    setState(() {
      _showpass = !_showpass;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:toast/toast.dart';

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameTxtCtrl = new TextEditingController();
  final TextEditingController passwordTxtCtrl = new TextEditingController();
  final TextEditingController reenterpasswordTxtCtrl =
      new TextEditingController();
  final TextEditingController emailTxtCtrl = new TextEditingController();
  bool errUser = false, errPass = false, errRePass = false, errEmail = false;
  String errTxt = "";

  void sendData() async {
    final uri = "http://142.93.253.93:81/web-api/new";
    final headers = {'Content-Type': 'application/json'};
    setState(() {
      usernameTxtCtrl.text.isEmpty ? errUser = true : errUser = false;
      emailTxtCtrl.text.isEmpty ? errEmail = true : errEmail = false;
      passwordTxtCtrl.text.isEmpty ? errPass = true : errPass = false;
      (!errPass && passwordTxtCtrl.text != reenterpasswordTxtCtrl.text)
          ? errRePass = true
          : errRePass = false;
    });

    if (passwordTxtCtrl.text != reenterpasswordTxtCtrl.text) {
    } else {
      Map<String, dynamic> body = {
        'username': usernameTxtCtrl.text.trim(),
        'password': passwordTxtCtrl.text,
        'email': emailTxtCtrl.text.trim()
      };
      String jsonString = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      Response response = await post(uri,
          headers: headers, body: jsonString, encoding: encoding);
      String responseBody = response.body;
      debugPrint(responseBody);
      dynamic data = await json.decode(response.body);
      if (data["statusCode"] == 0) {
        setState(() {
          errTxt = data["message"].toString();
        });       
      }

      // usernameTxtCtrl.text = "";
      // passwordTxtCtrl.text = "";
      // reenterpasswordTxtCtrl.text = "";
      // emailTxtCtrl.text = "";
    }
  }

  void presss() async {
    this.sendData();
  }

  @override
  Widget build(BuildContext context) {
    final title = new Container(
      child: new Text('Register',
          style: TextStyle(
            fontSize: 50,
            //  color: Colors.white
          )),
    );

    final errNoti = new Container(
      child: new Text(
        errTxt,
        style: TextStyle(fontSize: 20, color: Colors.red),
      ),
    );

    final usernameTextField = new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextField(
        controller: usernameTxtCtrl,
        onTap: () {
          setState(() {
            errUser = false;
          });
        },
        decoration: InputDecoration(
            labelText: 'User name',
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.blue)),
            errorText: errUser ? "Please enter username" : null),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );

    final passwordTextField = new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextField(
        obscureText: true,
        controller: passwordTxtCtrl,
        onTap: () {
          setState(() {
            errPass = false;
          });
        },
        decoration: InputDecoration(
            labelText: 'Password',
            border: new OutlineInputBorder(borderSide: new BorderSide()),
            errorText: errPass ? "Please enter password" : null),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );

    final reenterPasswordTextField = new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextField(
        obscureText: true,
        controller: reenterpasswordTxtCtrl,
        onTap: () {
          setState(() {
            errRePass = false;
          });
        },
        decoration: InputDecoration(
            labelText: 'Re-enter password',
            border: new OutlineInputBorder(borderSide: new BorderSide()),
            errorText: errRePass ? "Password does not match" : null),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );

    final emailTextField = new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextField(
        controller: emailTxtCtrl,
        onTap: () {
          setState(() {
            errEmail = false;
          });
        },
        decoration: InputDecoration(
            labelText: 'Email',
            border: new OutlineInputBorder(borderSide: new BorderSide()),
            errorText: errEmail ? "Please enter email" : null),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // this.sendData();
          this.presss();
        },
        child: Text("Sign up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return new Scaffold(
      body: Container(
        padding: EdgeInsets.all(25.0),
        width: double.infinity,
        child: new Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(0, -0.75),
              child: title,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                usernameTextField,
                passwordTextField,
                reenterPasswordTextField,
                emailTextField
              ],
            ),
            errNoti,
            Container(
              alignment: Alignment(0, 0.7),
              child: loginButon,
            ),
          ],
        ),
      ),
    );
  }
}

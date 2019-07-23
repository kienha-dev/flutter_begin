import 'package:begin/services/locales.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameTxtCtrl = new TextEditingController();
  final TextEditingController passwordTxtCtrl = new TextEditingController();
  final TextEditingController reenterpasswordTxtCtrl =
      new TextEditingController();
  final TextEditingController emailTxtCtrl = new TextEditingController();
  bool errUser = false, errPass = false, errRePass = false, errEmail = false;
  String errTxt = "";

  void sendData() async {
    final url = "http://142.93.253.93:81/web-api/user/new";
    final headers = {'Content-Type': 'application/json'};
    setState(() {
      usernameTxtCtrl.text.isEmpty ? errUser = true : errUser = false;
      emailTxtCtrl.text.isEmpty ? errEmail = true : errEmail = false;
      passwordTxtCtrl.text.isEmpty ? errPass = true : errPass = false;
      (!errPass && passwordTxtCtrl.text != reenterpasswordTxtCtrl.text)
          ? errRePass = true
          : errRePass = false;
    });

    if (passwordTxtCtrl.text == reenterpasswordTxtCtrl.text &&
        (passwordTxtCtrl.text != null || passwordTxtCtrl.text != "")) {
      Map<String, dynamic> body = {
        'username': usernameTxtCtrl.text.trim(),
        'password': passwordTxtCtrl.text,
        'email': emailTxtCtrl.text.trim()
      };
      String jsonString = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      Response response = await post(url,
          headers: headers, body: jsonString, encoding: encoding);
      String responseBody = response.body;
      debugPrint(responseBody);
      dynamic data = await json.decode(response.body);
      if (data["statusCode"] == 0) {
        setState(() {
          errTxt = data["message"].toString();
        });
      } else {
        Navigator.pop(context);
      }
    }
  }

  void presss() async {
    this.sendData();
  }

  @override
  Widget build(BuildContext context) {
    final title = new Container(
      child: new Text(AppLocalizations.of(context).registerTitle,
          style: TextStyle(
            fontSize: 50,
          )),
    );

    final errNoti = new Container(
      child: new Text(
        errTxt,
        style: TextStyle(fontSize: 20, color: Colors.red),
      ),
    );

    final usernameTextField = new Container(
      margin: EdgeInsets.fromLTRB(
          0, 0, 0, MediaQuery.of(context).size.height * 0.01),
      child: TextField(
        controller: usernameTxtCtrl,
        onTap: () {
          setState(() {
            errUser = false;
          });
        },
        decoration: InputDecoration(
            labelText: AppLocalizations.of(context).userNameTxtBox,
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorText: errUser ? "Please enter username" : null),
        style: TextStyle(fontSize: 18),
      ),
    );

    final passwordTextField = new Container(
      margin: EdgeInsets.fromLTRB(
          0, 0, 0, MediaQuery.of(context).size.height * 0.01),
      child: TextField(
        obscureText: true,
        controller: passwordTxtCtrl,
        onTap: () {
          setState(() {
            errPass = false;
          });
        },
        decoration: InputDecoration(
            labelText: AppLocalizations.of(context).passwordTxtBox,
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorText: errPass ? "Please enter password" : null),
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );

    final reenterPasswordTextField = new Container(
      margin: EdgeInsets.fromLTRB(
          0, 0, 0, MediaQuery.of(context).size.height * 0.01),
      child: TextField(
        obscureText: true,
        controller: reenterpasswordTxtCtrl,
        onTap: () {
          setState(() {
            errRePass = false;
          });
        },
        decoration: InputDecoration(
            labelText: AppLocalizations.of(context).reenterPassTxtBox,
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorText: errRePass ? "Password does not match" : null),
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );

    final emailTextField = new Container(
      margin: EdgeInsets.fromLTRB(
          0, 0, 0, MediaQuery.of(context).size.height * 0.01),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: emailTxtCtrl,
        onTap: () {
          setState(() {
            errEmail = false;
          });
        },
        decoration: InputDecoration(
            labelText: AppLocalizations.of(context).emailAddressTitle,
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorText: errEmail ? "Please enter email" : null),
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );

    final registerButon = Material(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.lightBlue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          this.presss();
        },
        child: Text(AppLocalizations.of(context).signUpBtn,
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return new Scaffold(
      body: Center(
        child: new SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(30.0),
                  width: MediaQuery.of(context).size.width,
                  height: 0.2 * MediaQuery.of(context).size.height,
                  child: title,
                ),
                SizedBox(
                  height: 0.02 * MediaQuery.of(context).size.height,
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
                SizedBox(
                  height: 0.02 * MediaQuery.of(context).size.height,
                ),
                Container(
                  child: registerButon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

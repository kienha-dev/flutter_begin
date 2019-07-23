import 'dart:convert';
import 'package:begin/screens/login.dart';
import 'package:begin/services/locales.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class ForgotPass extends StatefulWidget {
  ForgotPass({Key key}) : super(key: key);

  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  bool isEmailEnter = true;
  final TextEditingController emailInput = new TextEditingController();
  final TextEditingController codeInput = new TextEditingController();
  final TextEditingController passInput = new TextEditingController();
  final TextEditingController reenterpassInput = new TextEditingController();

  void _confirmEmail() async {
    if (emailInput.text.isNotEmpty) {
      final url = "http://142.93.253.93:81/web-api/forgotpassword";
      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        'email': emailInput.text.trim(),
      };
      String jsonString = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      Response response = await post(url,
          headers: headers, body: jsonString, encoding: encoding);
      String responseBody = response.body;
      debugPrint(responseBody);
      setState(() {
        isEmailEnter = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return isEmailEnter ? _enterEmail(context) : _enterCode(context);
  }

  Widget _enterEmail(BuildContext context) {
    return Scaffold(
      body: Container(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 0.8 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border:
                            new Border.all(width: 0.2, color: Colors.black87),
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(7.0),
                        boxShadow: [
                          new BoxShadow(
                            offset: new Offset(5.0, 10.0),
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Container(
                                height: 0.1 * MediaQuery.of(context).size.height,
                                padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                                decoration: new BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    topRight: Radius.circular(7),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .forgotPasswordScreenTitle,
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            AppLocalizations.of(context).enterEmailMessage,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: TextField(
                            controller: emailInput,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .emailAddressTitle),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(20),
                        ),
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10))),
                          child: MaterialButton(
                            minWidth: 0.5 * MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: _confirmEmail,
                            child: Text(
                              AppLocalizations.of(context).confirmBtnTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10))),
                          child: MaterialButton(
                            minWidth: 0.5 * MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context).cancelBtnTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _confirmCode() async {
    if (codeInput.text.isNotEmpty &&
        passInput.text.isNotEmpty &&
        passInput.text == reenterpassInput.text) {
      Toast.show("click", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      final url = "http://142.93.253.93:81/web-api/forgotpassword.newpassword";
      final headers = {'Content-Type': 'application/json'};
      print(codeInput.text);
      print(passInput.text);
      print(reenterpassInput.text);
      Map<String, dynamic> body = {
        'code': codeInput.text.trim(),
        'newpassword': passInput.text,
      };
      String jsonString = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      Response response = await post(url,
          headers: headers, body: jsonString, encoding: encoding);
      String responseBody = response.body;
      debugPrint(responseBody);
      _showDialog(true);
    } else {
      _showDialog(false);
    }
  }

  void _resendEmail() {
    Toast.show("click", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    // final url = "";
    // final header = "";
  }

  void _showDialog(bool check) {
    check
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Successful!!!"),
                content:
                    new Text("You have successfully changed your password"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Go to login screen"),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  )
                ],
              );
            })
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Failed!!!"),
                content: new Text("You changed the password failed"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Try again"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child:
                        new Text(AppLocalizations.of(context).cancelBtnTitle),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                  )
                ],
              );
            });
  }

  Widget _enterCode(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
            0, 0.12 * MediaQuery.of(context).size.height, 0, 0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 0.8 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border:
                            new Border.all(width: 0.2, color: Colors.black87),
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(7.0),
                        boxShadow: [
                          new BoxShadow(
                            offset: new Offset(5.0, 10.0),
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                                height: 0.1 * MediaQuery.of(context).size.height,
                                decoration: new BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    topRight: Radius.circular(7),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .forgotPasswordScreenTitle,
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            AppLocalizations.of(context).enterVerifyCodeMessage,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            controller: codeInput,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20),
                            decoration:
                                InputDecoration(labelText: "Verify code"),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: TextField(
                            controller: passInput,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            style: TextStyle(fontSize: 20),
                            decoration:
                                InputDecoration(labelText: "New password"),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: TextField(
                            obscureText: true,
                            controller: reenterpassInput,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                labelText: "Re-enter new password"),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            "If you have not received any notification emails, press resend email",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Resend email",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.lightBlue,
                                      fontSize: 17),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _resendEmail,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(20),
                        ),
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10))),
                          child: MaterialButton(
                            minWidth: 0.5 * MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: _confirmCode,
                            child: Text(
                              "Confirm",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10))),
                          child: MaterialButton(
                            minWidth: 0.5 * MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              setState(() {
                                isEmailEnter = true;
                              });
                            },
                            child: Text(
                              "Back",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          child: Container(),
                          padding: EdgeInsets.all(15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    child: Container(),
                    padding: EdgeInsets.fromLTRB(
                        0, 0, 0, 0.12 * MediaQuery.of(context).size.height),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

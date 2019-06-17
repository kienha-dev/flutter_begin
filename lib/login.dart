import 'package:flutter/material.dart';

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = new Container(
      child: new Text('Register',
          style: TextStyle(
            fontSize: 50,
            //  color: Colors.white
          )),
    );

    final usernameTextField = new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: new Theme(
        data: new ThemeData(),
        child: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'User name',
            border: new OutlineInputBorder(borderSide: new BorderSide()),
          ),
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );

    final passwordTextField = new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Password',
            border: new OutlineInputBorder(borderSide: new BorderSide())),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );

    final reenterPasswordTextField = new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Re-enter password',
            border: new OutlineInputBorder(borderSide: new BorderSide())),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );

    final emailTextField = new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Email',
            border: new OutlineInputBorder(borderSide: new BorderSide())),
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
        onPressed: () {},
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
            Container(
              alignment: Alignment(0, 0.7),
              child: loginButon,
            )
          ],
        ),
      ),
    );  
  }
}

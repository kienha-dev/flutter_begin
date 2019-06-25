import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool check = false;
  String token = "";
  File file = null;


  void _choose() async {
    file =
    await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 240.0,
        maxWidth: 240.0);
    setState(() {
      Image.file(file);
    });
  }

  void _take() async {
    file = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 240.0,
        maxWidth: 240.0);
    setState(() {
      Image.file(file);
    });
  }


  void _upload() async {



    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();

    var uri = Uri.parse("http://142.93.253.93:81/web-api/KYC-upload-img");

    var request = new http.MultipartRequest("POST", uri,);
    var multipartFile = new http.MultipartFile('myImage', stream, length,
        filename: basename(file.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    print(token);
    request.headers.addAll({"authorization":token});
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  void initState() {
    GetPre().then(UpdateCheck);
    getToken().then(updatToken);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: !check ? SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: _take,
                  child: Text('Take Image'),
                ),
                SizedBox(width: 3.0),
                RaisedButton(
                  onPressed: _choose,
                  child: Text('Choose Image'),
                ),
                SizedBox(width: 15.0),
                RaisedButton(
                  onPressed: _upload,
                  child: Text('Upload Image'),
                )
              ],
            ),
            file == null ? Text('No Image Selected') : Image.file(file),
          ],
        ),
      ): SingleChildScrollView(
        child: Center(
          child: Text("Chào mừng bạn đến với Trái Đất"),
        ),
      )
    );
  }

  void UpdateCheck(bool value) {
    setState(() {
      this.check = value;
    });
  }


  void updatToken(String value) {
    setState(() {
      this.token = value;
    });
  }
}

Future<bool> GetPre() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool check = prefs.getBool("check");
  return check;
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token");
  return token;
}


import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:dio/dio.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool check = false;
  int statusCode;
  String token = "";
  List<UploadFileInfo> files = new List<UploadFileInfo>();
  List<Asset> images = List<Asset>();
  String _error = "No Image Selected!";

  _openGallary() {
    loadAssets();
    Navigator.of(context).pop();
  }

  _openCamera() {}
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Text("Gallary"),
                      onTap: () {
                        _openGallary();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget buildGridView() {
    return GridView.count(
      padding: EdgeInsets.all(8),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 350,
          height: 350,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    files.clear();

    List<Asset> resultList = List<Asset>();
    String error = "";

    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 2,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Example App",
            allViewTitle: "All Photos",
            selectCircleStrokeColor: "#000000",
          ));
    } on PlatformException catch (e) {
      error = e.message;
    }

    for (var asset in resultList) {
      ByteData byteData = await asset.requestOriginal(quality: 80);

      if (byteData != null) {
        List<int> imageData = byteData.buffer.asUint8List();
        UploadFileInfo u = UploadFileInfo.fromBytes(imageData, asset.name);
        files.add(u);
      }
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  /*Upload Image*/
  Future<List<String>> uploadImage() async {
    FormData formData = new FormData.from({"files": files});

    Dio dio = new Dio();

    var response = await dio
        .post("http://142.93.253.93:81/web-api/KYC-upload-img",
        data: {'myImage': formData},
        options: Options(headers: {
          'authorization':
          token
        }, contentType: ContentType.parse("multipart/related")))
        .then((response) => (){
           print(response);
           statusCode = response.statusCode;
        })
        .catchError((error) => print(error));
//    print(response.body);
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
      body: !check ? Scaffold(
        appBar: AppBar(
          title: Text("Check User Page"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Text(_error),
              ),
              Container(
                child: buildGridView(),
                height: MediaQuery.of(context).size.width * 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    child: Text("Select Image"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  RaisedButton(
                    onPressed: () {
                      uploadImage();
                      print("click");
                    },
                    child: Text("Upload Image"),
                  ),
                ],
              )
            ],
          ),
        ),
      ): Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text("Bính Giáp"),
                accountEmail: Text("giapnguyen086@gmail.com"),
                currentAccountPicture: new GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: new NetworkImage(
                        "https://scontent.fdad1-1.fna.fbcdn.net/v/t1.0-9/20597211_663798927143386_2859871727786322816_n.jpg?_nc_cat=105&_nc_oc=AQnbfy5VyWTHmsenh1EegSZ9MOl6foGJ1_SW30nNmMzILF_53NL3MbXVuhOPuGglWxk&_nc_ht=scontent.fdad1-1.fna&oh=c5ef18a35d2311a13394ac689841ef63&oe=5D81067D"),
                  ),
                ),
              ),
              ListTile(
                leading: new Icon(Icons.photo_album),
                title: Text("Photo"),
                trailing: new Icon(Icons.arrow_right),
              ),
              ListTile(
                leading: new Icon(Icons.notifications),
                title: Text("Notification"),
                trailing: new Icon(Icons.arrow_right),
              ),
              ListTile(
                leading: new Icon(Icons.settings),
                title: Text("Setting"),
                trailing: new Icon(Icons.arrow_right),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    leading: new Icon(Icons.assignment_ind),
                    title: Text("Log Out"),
                    trailing: new Icon(Icons.assignment_return),
                    onTap: () {
                      _logout();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Center(child: Text("Chào mừng bạn đến với Trái Đất =))"),),
        ),
      )
    );

  }
  void _logout() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));

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


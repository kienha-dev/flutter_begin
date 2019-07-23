import 'package:begin/services/locales.dart';
import 'package:flutter/material.dart';

class ColorComponent {
  final Color color;
  bool status;
  ColorComponent({this.color, this.status});

  void setstatus(bool status) {
    this.status = status;
  }

  Color getColor() {
    return this.color;
  }
}

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isShowThemeColor = false;
  List _colorsData = [
    new ColorComponent(color: Colors.red, status: false),
    new ColorComponent(color: Colors.orange, status: false),
    new ColorComponent(color: Colors.yellow, status: false),
    new ColorComponent(color: Colors.green, status: false),
    new ColorComponent(color: Colors.cyan, status: false),
    new ColorComponent(color: Colors.blue, status: true),
    new ColorComponent(color: Colors.purple, status: false),
    new ColorComponent(color: Colors.blueGrey, status: false),
  ];
  int selectedColor = 0;

  void showThemeColor() {
    setState(() {
      isShowThemeColor = !isShowThemeColor;
    });
  }

  void setColor(index) {
    print(index);
    setState(() {
      _colorsData.forEach((color) => {color.setstatus(false)});
      _colorsData[index].setstatus(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).themeColorTitle,
                  style: TextStyle(fontSize: 20),
                ),
                trailing: isShowThemeColor
                    ? Icon(Icons.keyboard_arrow_up)
                    : Icon(Icons.keyboard_arrow_down),
                onTap: showThemeColor,
              ),
            ),
            isShowThemeColor
                ? Container(
                    height: 0.18 * MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: new GridView.count(
                      crossAxisCount: 6,
                      children: new List.generate(_colorsData.length, (index) {
                        return new GridTile(
                          child: new GestureDetector(
                            child: new Card(
                              color: _colorsData[index].color,
                              child: _colorsData[index].status
                                  ? new LayoutBuilder(
                                      builder: (context, constraint) {
                                      return new Icon(
                                        Icons.check_circle,
                                        size: 0.5 * constraint.biggest.height,
                                        color: Colors.white,
                                      );
                                    })
                                  : Container(),
                            ),
                            onTap: () {
                              setColor(index);
                            },
                          ),
                        );
                      }),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

import 'package:begin/screens/editProfile.dart';
import 'package:begin/screens/homeScreen.dart';
import 'package:begin/screens/login.dart';
import 'package:begin/screens/settingScreen.dart';
import 'package:begin/services/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Screen {
  final Text title;
  final StatefulWidget widget;
  const Screen({this.title, this.widget});
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavBarIndex = 0;
  static final assetUserImage = new AssetImage('lib/assets/images/logo_op.jpg');

  void _onBottomBarItemTapped(int index) {
    setState(() {
      _bottomNavBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Screen> _listScreen = <Screen>[
      new Screen(title: Text(AppLocalizations.of(context).titleHomeScreen), widget: HomeScreen()),
      new Screen(title: Text(AppLocalizations.of(context).titleSettingsScreen), widget: SettingsScreen())
    ];
    SystemChrome.setEnabledSystemUIOverlays([]);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: _listScreen[_bottomNavBarIndex].title,
      ),
      drawer: SizedBox(
        width: 0.7 * size.width,
        child: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: assetUserImage,
                ),
                accountName: Text("Ha Minh Kien"),
                accountEmail: Text("luffy.onepiece2208@gmail.com"),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context).profileTitle),
                trailing: new Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()));
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context).logoutTitle),
                trailing: new Icon(Icons.power_settings_new),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(child: _listScreen[_bottomNavBarIndex].widget),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text(AppLocalizations.of(context).titleHomeScreen)),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text(AppLocalizations.of(context).titleSettingsScreen)),
        ],
        elevation: 10,
        currentIndex: _bottomNavBarIndex,
        selectedItemColor: Colors.red,
        onTap: _onBottomBarItemTapped,
      ),
    );
  }
}

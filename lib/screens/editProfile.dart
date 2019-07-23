import 'package:begin/services/locales.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static final assetUserImage = new AssetImage('lib/assets/images/logo_op.jpg');
  TextStyle textStyle = new TextStyle(fontSize: 20);
  String name = "Ha Minh Kien";
  String email = "luffy.onepiece2208@gmail.com";
  String phone = "0776978875";
  String role = "user";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 0.3 * size.height,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: new Container(
                child: new Row(
                  children: <Widget>[
                    new CircleAvatar(
                      backgroundImage: assetUserImage,
                      radius: 0.05 * size.width,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(name),
                    IconButton(
                      icon: Icon(Icons.edit,color: Colors.white,),
                      onPressed: () {
                        Toast.show("edit", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      },
                    ),
                  ],
                ),
              ),
              background: Image.network(
                "https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: new Text(
                          AppLocalizations.of(context).emailAddressTitle,
                          style: textStyle,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: new Text(
                          email,
                          style: textStyle,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Toast.show("edit", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: new Text(
                          AppLocalizations.of(context).phoneTitle,
                          style: textStyle,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: new Text(
                          phone,
                          style: textStyle,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Toast.show("edit", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: new Text(
                          AppLocalizations.of(context).roleTitle,
                          style: textStyle,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: new Text(
                          role,
                          style: textStyle,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Toast.show("edit", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

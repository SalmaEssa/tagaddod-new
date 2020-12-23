import 'package:flutter/material.dart';

import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/ui/home/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print("holsss  homeee");

    return Scaffold(
      backgroundColor: AppColors.lightGrayBackground,
      drawer: SideDrawer(),
      body: Container(),
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.settings,
              color: AppColors.white,
              size: 30,
            ),
          )
        ],
      ),
      key: _scaffoldKey,
    );
  }
}

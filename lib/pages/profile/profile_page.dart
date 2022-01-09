import 'package:flutter/material.dart';
import 'package:food_rest/pages/profile/dashboard_tab.dart';
import 'package:food_rest/pages/profile/delivery_tab.dart';
import 'package:food_rest/pages/profile/profile_details_tab.dart';
import 'package:food_rest/widget/profile_bottom_nav_item.dart';

class ProfilePage extends StatefulWidget {
  final int tabId;

  const ProfilePage({Key key, this.tabId = 0}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _active = 0;

  @override
  void initState() {
    super.initState();
    _active = widget.tabId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_active == 0
            ? "Dashboard"
            : _active == 1 ? "Delivery Schedule" : "Profile"),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: MediaQuery.of(context).size.height / 3,
              child: _background(),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 55,
              child: Container(
                child: _active == 0
                    ? ProfileDashBoard()
                    : _active == 1 ? Profiledelivery() : ProfileDetails(),
              ),
            ),
            Positioned(
                bottom: 0,
                height: 60,
                left: 0,
                right: 0,
                child: _bottomNavWidget())
          ],
        ),
      ),
    );
  }

  Widget _bottomNavWidget() {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyBottomNavBarItem(
            active: _active,
            id: 0,
            icon: Icons.dashboard,
            text: "DashBoard",
            function: () {
              setState(() {
                _active = 0;
              });
            },
          ),
          MyBottomNavBarItem(
            active: _active,
            id: 1,
            icon: Icons.local_taxi,
            text: "Delivery",
            function: () {
              setState(() {
                _active = 1;
              });
            },
          ),
          MyBottomNavBarItem(
            active: _active,
            id: 2,
            icon: Icons.person,
            text: "Profile",
            function: () {
              setState(() {
                _active = 2;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _background() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
            color: Theme.of(context).accentColor.withRed(100),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

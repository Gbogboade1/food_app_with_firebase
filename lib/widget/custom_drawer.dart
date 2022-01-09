import 'package:flutter/material.dart';
import 'package:food_rest/pages/cooked_meal_pages/cooked_meal_dashboard.dart';
import 'package:food_rest/pages/food_stuff_pages/food_stuff_dashboard.dart';
import 'package:food_rest/pages/profile/profile_page.dart';
import 'package:food_rest/widget/background.dart';

class CustomDrawer extends StatefulWidget {
  final bool type;

  const CustomDrawer({Key key, this.type}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  @override
  Widget build(BuildContext context) {
  TextStyle  navTextStyle = TextStyle(color: Theme.of(context).accentColor);
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          elevation: 0,
          child: Stack(
            children: <Widget>[
              BackgroundWidget(),
              ListView(
                children: <Widget>[
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "FoodRest",
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text("Menu", style: navTextStyle),
                  ),
                  Divider(),
                 widget.type? ListTile(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (c) => FoodStuffDashBoardPage()));
                    },
                    leading: Icon(Icons.folder_special),
                    title: Text("Buy Foodstuff Instead", style: navTextStyle),
                  ) : 
                  ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (c) => CookedMealDashboard()));
                      },
                      leading: Icon(Icons.folder_special),
                      title: Text("Buy Cooked Meals Instead"),
                    ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => ProfilePage(
                                    tabId: 1,
                                  )));
                    },
                    leading: Icon(Icons.library_books),
                    title: Text("Orders", style: navTextStyle),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => ProfilePage(
                                    tabId: 1,
                                  )));
                    },
                    leading: Icon(Icons.local_taxi),
                    title: Text("Delivery", style: navTextStyle),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => ProfilePage()));
                    },
                    leading: Icon(Icons.person),
                    title: Text("Profile", style: navTextStyle),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text("Share", style: navTextStyle),
                  ),
                  Divider(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

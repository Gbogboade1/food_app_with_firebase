import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rest/pages/cooked_meal_pages/cooked_meal_dashboard.dart';
import 'package:food_rest/pages/food_stuff_pages/food_stuff_dashboard.dart';
import 'package:food_rest/widget/background.dart';

class DecisionPage extends StatefulWidget {
  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: Text("Exit FoodRest"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Yes"),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("No"),
                  ),
                ],
              ),
            )) ??
            false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              BackgroundWidget(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * .15),
                    Text(
                      "I would like to have...",
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext c) =>
                                    CookedMealDashboard()));
                      },
                      child: buildCard(
                        "assets/food2.jpeg",
                        "Cooked meal",
                        "Order rich and tasty cooked meals that would keep you nourished for up to 7 days.",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap:(){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext c) =>
                                    FoodStuffDashBoardPage()));
                      },
                      child:buildCard(
                      "assets/food5.jpeg",
                      "Food barn",
                      "Stock up your food store with high grade farm produce.",
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(img, title, subTitle) {
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height * .3,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                child: Image.asset(
                  img,
                  fit: BoxFit.fill,
                  height: 54,
                  width: 64,
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        title,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .apply(fontSizeFactor: .8, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

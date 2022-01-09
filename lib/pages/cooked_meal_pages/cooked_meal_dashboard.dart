import 'package:flutter/material.dart';
import 'package:food_rest/model/meal_model.dart';
import 'package:food_rest/pages/food_stuff_pages/food_stuff_dashboard.dart';
import 'package:food_rest/pages/profile/profile_page.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/custom_drawer.dart';
import 'package:food_rest/widget/meal_card.dart';

import 'meal_add_on_page.dart';

class CookedMealDashboard extends StatefulWidget {
  @override
  _CookedMealDashboardState createState() => _CookedMealDashboardState();
}

class _CookedMealDashboardState extends State<CookedMealDashboard> {
  bool isSearching = false;
  TextEditingController searchEdittingController;
  TextStyle navTextStyle;
  @override
  void initState() {
    super.initState();
    navTextStyle = TextStyle(color: Theme.of(context).accentColor);
    searchEdittingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(type: true),
      appBar: AppBar(
        centerTitle: true,
        title: isSearching
            ? TextField(
                maxLines: 1,
                controller: searchEdittingController,
                keyboardType: TextInputType.text,
                onChanged: (t) {},
                onEditingComplete: () {},
                decoration: InputDecoration(
                  hintText: "e.g.",
                  fillColor: Colors.white,
                ),
              )
            : Text("Menu"),
        actions: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          BackgroundWidget(),
          ListView.builder(
            padding: const EdgeInsets.only(top: 16.0),
            itemCount: 9,
            itemBuilder: (c, index) {
              Meal meal = Meal(
                  name: "Egusi Vegetable Soup",
                  imageUrl: "assets/food${index + 1}.jpeg");
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext c) => MealAddOnPage(
                          meal: meal,
                        ),
                      ),
                    );
                  },
                  child: MealCardWidget(meal: meal),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

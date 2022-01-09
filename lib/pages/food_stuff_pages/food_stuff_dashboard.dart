import 'package:flutter/material.dart';
import 'package:food_rest/model/cart/cart_model.dart';
import 'package:food_rest/model/meal_model.dart';
import 'package:food_rest/pages/cooked_meal_pages/cooked_meal_dashboard.dart';
import 'package:food_rest/pages/food_stuff_pages/food_stuff_type.dart';
import 'package:food_rest/pages/profile/profile_page.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/cart.dart';
import 'package:food_rest/widget/custom_drawer.dart';
import 'package:food_rest/widget/fs_appbar.dart';
import 'package:food_rest/widget/meal_card.dart';
import 'package:scoped_model/scoped_model.dart';

class FoodStuffDashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: CartModel(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
        ),
        debugShowCheckedModeBanner: false,
        home: FDB(),
      ),
    );
  }
}

class FDB extends StatefulWidget {
  @override
  _FDBState createState() => _FDBState();
}

class _FDBState extends State<FDB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(type:false),
      appBar: FoodStuffAppBar(
        title: "Now Available",
        actions: <Widget>[
          InkWell(
            child: Icon(Icons.search),
            onTap: () {},
          ),
          SizedBox(width: 8),
          CartWidget(),
        ],
      ),
      body: Stack(
        children: <Widget>[
          BackgroundWidget2(),
          ListView.builder(
            padding: const EdgeInsets.only(top: 16.0),
            itemCount: 9,
            itemBuilder: (c, index) {
              Meal meal = Meal(
                  name: "Tuber Crops", imageUrl: "assets/fs${index + 1}.jpg");
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext c) => FoodStuffTypePage(
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

import 'package:flutter/material.dart';
import 'package:food_rest/model/meal_model.dart';

class MealCardWidget extends StatelessWidget {
  final Meal meal;

  const MealCardWidget({Key key, this.meal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              meal.imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 2),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 8),
                  Text(
                    meal.name,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

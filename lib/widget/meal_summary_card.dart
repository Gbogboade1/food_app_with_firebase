import 'package:flutter/material.dart';
import 'package:food_rest/model/meal_model.dart';

class MealSummaryCardWidget extends StatelessWidget {
  final Meal meal;

  const MealSummaryCardWidget({Key key, this.meal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              meal.imageUrl,
              fit: BoxFit.cover,
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
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "With",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        flex: 1,
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                      SizedBox(height: 4),
                  Column(
                    children: List.generate(
                      meal.addOnList.length,
                      (index) {
                        return Text(
                          meal.addOnList[index],
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        );
                      },
                    ),
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

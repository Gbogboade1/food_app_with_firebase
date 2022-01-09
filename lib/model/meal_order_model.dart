import 'package:food_rest/model/meal_model.dart';
import 'package:food_rest/model/user_model.dart';

class MealOrder{
  final Meal meal;
  final User user;
  final String orderDate;
  final int noOfDays;
  final int noOfMeals;

  MealOrder({this.meal, this.user, this.orderDate, this.noOfDays, this.noOfMeals});
}
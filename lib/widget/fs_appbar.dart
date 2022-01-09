import 'package:flutter/material.dart';
import 'package:food_rest/widget/cart.dart';

Widget FoodStuffAppBar({String title, List<Widget> actions = const []}) {
  final List<Widget> action1 = <Widget>[Padding(
    padding: const EdgeInsets.only(right:8.0),
    child: CartWidget(),
  )];
  if (actions.isEmpty) {
    actions = action1;
  }
  return AppBar(
    centerTitle: true,
    title: Text(title, style: TextStyle(color: Colors.white),),
    actions: actions,
  );
}

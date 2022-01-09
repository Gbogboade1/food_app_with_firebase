import 'package:flutter/material.dart';
import 'package:food_rest/model/cart/cart_model.dart';
import 'package:food_rest/pages/food_stuff_pages/cart_page.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/food_item_card.dart';
import 'package:food_rest/widget/fs_appbar.dart';
import 'package:food_rest/widget/input_field.dart';
import 'package:scoped_model/scoped_model.dart';

class FoodMeasurementPage extends StatefulWidget {
  final List<String> foodItemList;

  const FoodMeasurementPage({Key key, this.foodItemList}) : super(key: key);
  @override
  _FoodMeasurementPageState createState() => _FoodMeasurementPageState();
}

class _FoodMeasurementPageState extends State<FoodMeasurementPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
          builder:(c,_ , model) => Scaffold(
        floatingActionButton: model.itemCount == 0? null: FloatingActionButton(
          child: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext c) => CartPage()));
          },
        ),
        appBar: FoodStuffAppBar(title: "Add Quantity"),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            BackgroundWidget2(),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GridView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8.0),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: .6,
                    ),
                    children: List<Widget>.generate(
                      widget.foodItemList.length,
                      (int index) {
                        return FoodItemCard(
                            name: widget.foodItemList[index],
                            imageUrl: "assets/fs${index + 1}.jpg");
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

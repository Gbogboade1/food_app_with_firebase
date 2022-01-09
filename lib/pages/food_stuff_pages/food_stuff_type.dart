import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rest/model/addonitem_model.dart';
import 'package:food_rest/model/meal_model.dart';
import 'package:food_rest/pages/food_stuff_pages/food_measurement_page.dart';
import 'package:food_rest/widget/fs_appbar.dart';
import 'check_out_page.dart';
import 'package:food_rest/widget/addon_item_card.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/meal_card.dart';

class FoodStuffTypePage extends StatefulWidget {
  final Meal meal;

  const FoodStuffTypePage({Key key, this.meal}) : super(key: key);
  @override
  _FoodStuffTypePageState createState() => _FoodStuffTypePageState();
}

class _FoodStuffTypePageState extends State<FoodStuffTypePage> {
  List<AddOnItem> addOnItems = [
    AddOnItem(name: "Dry Yam", imageUrl: "assets/fs1.jpg"),
    AddOnItem(name: "Potato", imageUrl: "assets/fs2.jpg"),
    AddOnItem(name: "Water Yam", imageUrl: "assets/fs8.jpg"),
    AddOnItem(name: "Coacoa Yam", imageUrl: "assets/fs9.jpg"),
  ];

  List<AddOnItem> selectedItemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodStuffAppBar(title: "Choose Food item(s)"),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackgroundWidget2(),
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: buildAddOnList(),
              ),
              selectedItemList.length > 0 ? actionButtons() : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget actionButtons() {
    return Container(
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.all(8),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedItemList.clear();
                });
              },
              child: Icon(
                CupertinoIcons.delete,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext c) => FoodMeasurementPage(
                        foodItemList: getFoodStuffType(),
                      ),
                    ),
                  );
                },
                child: Icon(
                  CupertinoIcons.forward,
                  color: Colors.white,
                  size: 32,
                )),
          ),
        ],
      ),
    );
  }

  List<String> getFoodStuffType() {
    List<String> list = List.generate(selectedItemList.length, (index) {
      return selectedItemList[index].name;
    });
    return list;
  }

  Widget buildAddOnList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16.0),
      itemCount: addOnItems.length,
      itemBuilder: (c, index) {
        AddOnItem item = addOnItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedItemList.contains(item)
                    ? selectedItemList.remove(item)
                    : selectedItemList.add(item);
              });
            },
            child: AddOnItemCard(
              item: item,
              isSelected: selectedItemList.contains(item),
            ),
          ),
        );
      },
    );
  }
}

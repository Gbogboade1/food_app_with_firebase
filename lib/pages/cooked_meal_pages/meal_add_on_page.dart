import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rest/model/addonitem_model.dart';
import 'package:food_rest/model/meal_model.dart';
import 'check_out_page.dart';
import 'package:food_rest/widget/addon_item_card.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/meal_card.dart';

class MealAddOnPage extends StatefulWidget {
  final Meal meal;

  const MealAddOnPage({Key key, this.meal}) : super(key: key);
  @override
  _MealAddOnPageState createState() => _MealAddOnPageState();
}

class _MealAddOnPageState extends State<MealAddOnPage> {
  List<AddOnItem> addOnItems = [
    AddOnItem(name: "Beef", imageUrl: "assets/meat1.jpg"),
    AddOnItem(name: "Chicken", imageUrl: "assets/meat2.jpg"),
    AddOnItem(name: "Goat Meat", imageUrl: "assets/meat3.jpg"),
    AddOnItem(name: "Fish", imageUrl: "assets/meat1.jpg"),
  ];

  List<AddOnItem> selectedAddOnList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Choose Add-ons"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackgroundWidget(),
          Column(
            children: <Widget>[
              MealCardWidget(meal: widget.meal),
              Expanded(
                flex: 1,
                child: buildAddOnList(),
              ),
              selectedAddOnList.length > 0 ? actionButtons() : SizedBox(),
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
                  selectedAddOnList.clear();
                });
              },
              child: Icon(CupertinoIcons.delete,  color: Colors.white, size: 32,)//Icons.delete_outline),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext c) => CheckOutPage(meal: getMeal(),),),);
              },
              child: Icon(CupertinoIcons.forward, color: Colors.white,size: 32,)),
          ),
        ],
      ),
    );
  }

  List<String> getMealAddOn() {
    List<String> list = List.generate(selectedAddOnList.length, (index) {
      return selectedAddOnList[index].name;
    });
    return list;
  }

  Meal getMeal() {
    return Meal(
      name: widget.meal.name,
      addOnList: getMealAddOn(),
      description: widget.meal.description,
      imageUrl: widget.meal.imageUrl,
      price: widget.meal.price,
    );
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
                selectedAddOnList.contains(item)
                    ? selectedAddOnList.remove(item)
                    : selectedAddOnList.add(item);
              });
            },
            child: AddOnItemCard(
              item: item,
              isSelected: selectedAddOnList.contains(item),
            ),
          ),
        );
      },
    );
  }
}

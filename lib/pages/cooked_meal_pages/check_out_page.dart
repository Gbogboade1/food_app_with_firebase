import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rest/model/meal_model.dart';
import 'package:food_rest/pages/cooked_meal_pages/complete_order_page.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/choice_chip.dart';
import 'package:food_rest/widget/meal_summary_card.dart';

class CheckOutPage extends StatefulWidget {
  final Meal meal;

  const CheckOutPage({Key key, this.meal}) : super(key: key);
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int perDayIndexSelected = -1;
  int perWeekIndexSelected = 0;
  int amount = 2000;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackgroundWidget(),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.transparent,
            ),
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView(
                  children: <Widget>[
                    MealSummaryCardWidget(meal: widget.meal),
                    SizedBox(height: 8),
                    buildPerDayPlan(),
                    SizedBox(height: 8),
                    show ? buildPerWeekPlan() : SizedBox(height: 8),
                  ],
                ),
              ),
              show ? actionButtons() : SizedBox(height: 8),
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
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "NGN $amount",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
                onTap: () {
                  List<int> meals = [1, 2, 3];
                  List<int> days = [1, 3, 7];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext c) => CompleteOrder(
                        meal: widget.meal,
                        price: amount,
                        noOFMeals: meals[perDayIndexSelected],
                        noOfDays: days[perWeekIndexSelected],
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

  Widget buildPerDayPlan() {
    List<String> items = [
      "1 time",
      "2 times",
      "3 times",
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
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
                  "Meals Per day",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
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
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              items.length,
              (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      show = true;
                      perDayIndexSelected = index;
                    });
                  },
                  child: SelectionChip(
                    title: items[index],
                    isSelected: perDayIndexSelected == index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPerWeekPlan() {
    List<String> items = [
      "1 day",
      "3 days",
      "7 day",
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
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
                  "Number of days",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
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
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              items.length,
              (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      perWeekIndexSelected = index;
                    });
                  },
                  child: SelectionChip(
                    title: items[index],
                    isSelected: perWeekIndexSelected == index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rest/model/cart/cart_model.dart';
import 'package:food_rest/model/meal_model.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/input_field.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:rave_flutter/rave_flutter.dart';

class CompleteOrder extends StatefulWidget {
  final Meal meal;
  final int price;
  final int noOfDays;
  final int noOFMeals;

  const CompleteOrder(
      {Key key, this.meal, this.price, this.noOfDays, this.noOFMeals})
      : super(key: key);
  @override
  _CompleteOrderState createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  bool changePhoneNo;
  bool changeAddress;
  String phoneNo = "0901234567";
  String address = "15, Aja Junction, FUTA, Akure.";
  TextEditingController phoneNoEdittingController;
  TextEditingController addressEdittingController;

  int shippingMode = 0;
  List<int> shippingFeeList = [0, 200];
  @override
  void initState() {
    super.initState();
    changePhoneNo = false;
    changeAddress = false;
    phoneNoEdittingController = TextEditingController();
    addressEdittingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            BackgroundWidget(),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "FoodRest",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 42.0, 8, 8),
              child: ListView(
                children: <Widget>[
                  buildPriceCard(),
                  buildMealCard(),
                  SizedBox(height: 4),
                  buildContactCard(),
                  SizedBox(height: 4),
                  buildShippingCard(),
                  SizedBox(height: 4),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () {},
                    child: Text(
                      "Pay Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget buildPriceCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(width: 4),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: Center(
                  child: Text(
                    "NGN ${widget.price + shippingFeeList[shippingMode]}",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildShippingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Shipping mode",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(fontSizeFactor: .8),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      shippingMode = 0;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Radio(
                          value: shippingMode == 0,
                          onChanged: (c) {
                            setState(() {
                              shippingMode = 0;
                            });
                          },
                          groupValue: true),
                      Text("Pick Up")
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      shippingMode = 1;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Radio(
                          value: shippingMode == 1,
                          onChanged: (c) {
                            setState(() {
                              shippingMode = 1;
                            });
                          },
                          groupValue: true),
                      Text("Standard Shipping")
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "NGN ${shippingFeeList[shippingMode]}",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContactCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                buildPhoneDetails(),
                SizedBox(height: 8),
                Divider(color: Colors.grey),
                SizedBox(height: 8),
                // Delevery detail
                buildDeliveryDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildPhoneDetails() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Contact",
            style: Theme.of(context).textTheme.title.apply(fontSizeFactor: .75),
          ),
        ),
        SizedBox(height: 8),
        Container(
          child: changePhoneNo
              ? Column(
                  children: <Widget>[
                    CustomInputField(
                      topLabel: "Phone number",
                      onChaged: (s) {
                        setState(() {
                          phoneNoEdittingController.text;
                        });
                      },
                      controller: phoneNoEdittingController,
                      keyboardType: TextInputType.phone,
                      fieldSubmitted: (s) {
                        setState(() {
                          changePhoneNo = false;
                          phoneNo = phoneNoEdittingController.text;
                          phoneNoEdittingController = TextEditingController();
                        });
                      },
                    ),

                    // SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: IconButton(
                            icon: Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              String text = phoneNoEdittingController.text;
                              if (text == null || text == "") {
                                setState(() {
                                  changePhoneNo = false;
                                });
                              } else {
                                setState(() {
                                  phoneNoEdittingController.clear();
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        CircleAvatar(
                          child: IconButton(
                            icon: Icon(Icons.done),
                            onPressed: phoneNoEdittingController.text.isNotEmpty
                                ? () {
                                    setState(() {
                                      changePhoneNo = false;
                                      phoneNo = phoneNoEdittingController.text;
                                      phoneNoEdittingController =
                                          TextEditingController();
                                    });
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : contactChildItem(
                  text: phoneNo,
                  onTap: () {
                    setState(() {
                      changePhoneNo = true;
                    });
                  }),
        ),
      ],
    );
  }

  buildDeliveryDetails() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Delivery Location",
            style: Theme.of(context).textTheme.title.apply(fontSizeFactor: .75),
          ),
        ),
        SizedBox(height: 8),
        Container(
          child: changeAddress
              ? Column(
                  children: <Widget>[
                    CustomInputField(
                      topLabel: "Address",
                      onChaged: (s) {
                        setState(() {
                          addressEdittingController.text;
                        });
                      },
                      controller: addressEdittingController,
                      keyboardType: TextInputType.phone,
                      fieldSubmitted: (s) {
                        setState(() {
                          changeAddress = false;
                          address = addressEdittingController.text;
                          addressEdittingController = TextEditingController();
                        });
                      },
                    ),

                    // SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("City: Akure"),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: IconButton(
                            icon: Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              String text = addressEdittingController.text;
                              if (text == null || text == "") {
                                setState(() {
                                  changeAddress = false;
                                });
                              } else {
                                setState(() {
                                  addressEdittingController.clear();
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        CircleAvatar(
                          child: IconButton(
                            icon: Icon(Icons.done),
                            onPressed: addressEdittingController.text.isNotEmpty
                                ? () {
                                    setState(() {
                                      changeAddress = false;
                                      address = addressEdittingController.text;
                                      addressEdittingController =
                                          TextEditingController();
                                    });
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : contactChildItem(
                  text: address,
                  onTap: () {
                    setState(() {
                      changeAddress = true;
                    });
                  }),
        ),
      ],
    );
  }

  Widget contactChildItem({text, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Text(text),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "Change",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMealCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(widget.meal.imageUrl,
                      width: MediaQuery.of(context).size.width * .3),
                ),
                SizedBox(width: 16),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              widget.meal.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .apply(fontSizeFactor: .95),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            Text(
                              widget.meal.addOnsToStrng(),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: <Widget>[
                            Text(
                              "${widget.noOFMeals} meals for ${widget.noOfDays} days",
                              // style: Theme.of(context).textTheme.title.apply(fontSizeFactor: .7),
                            ),
                          ],
                        ),
                        // SizedBox(height: 8),
                        // Text(
                        //   "Price: NGN${widget.price}",
                        //   style: Theme.of(context).textTheme.title.apply(
                        //       fontSizeFactor: .7,
                        //       color: Theme.of(context).accentColor),
                        // ),
                      ],
                    ),
                  ),
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

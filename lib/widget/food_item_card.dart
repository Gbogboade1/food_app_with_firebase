import 'package:flutter/material.dart';
import 'package:food_rest/model/cart/cart_item.dart';
import 'package:food_rest/model/cart/cart_item_storage.dart';
import 'package:food_rest/model/cart/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class FoodItemCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  CartStorage cartStorage = CartStorage();

  FoodItemCard({Key key, this.imageUrl, this.name}) : super(key: key);

  @override
  _FoodItemCardState createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  final int minQ = 1;
  final int maxQ = 10;
  TextEditingController controller;

  int quantity;
  @override
  void initState() {
    super.initState();
    quantity = minQ;
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(builder: (b, c, model) {
      bool isInCart =
          model.itemInCart(CartItem(name: widget.name, total: quantity));
      return Card(
        color: Theme.of(context).accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              widget.imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Text(
              widget.name,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Flex(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              direction: Axis.horizontal,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: quantity == maxQ
                        ? null
                        : () {
                            if (mounted) {
                              setState(() {
                                quantity += 1;
                                controller = TextEditingController(
                                    text: quantity.toString());
                              });
                            }

                            if (isInCart) {
                              model.updateQuantity(
                                  CartItem(name: widget.name, total: quantity));
                            }
                          },
                    child: Container(
                        color: Colors.white,
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        )),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: quantity == minQ
                        ? null
                        : () {
                            if (mounted) {
                              setState(() {
                                quantity -= 1;
                                controller = TextEditingController(
                                    text: quantity.toString());
                              });
                            }

                            if (isInCart) {
                              model.updateQuantity(
                                  CartItem(name: widget.name, total: quantity));
                            }
                          },
                    child: Container(
                        color: Colors.white,
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                        )),
                  ),
                ),
                Flexible(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  style: TextStyle(color: Colors.white),
                  onSubmitted: (text) {
                    setState(() {
                      quantity = int.parse(text);
                      controller =
                          TextEditingController(text: quantity.toString());
                    });
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "$quantity",
                      hintStyle: TextStyle(color: Colors.white)),
                )),
                SizedBox(width: 4),
              ],
            ),
            Text(
              "$quantity congos",
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: isInCart
                  ? RaisedButton(
                      color: Colors.redAccent,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.remove_shopping_cart,
                            color: Colors.white,
                          ),
                          Text(
                            "Remove",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        model.removeFromCart(
                          CartItem(name: widget.name, total: quantity),
                        );

                        setState(() {
                          quantity = 1;

                          controller =
                              TextEditingController(text: quantity.toString());
                        });
                      })
                  : RaisedButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add_shopping_cart),
                          Text("Add to Cart"),
                        ],
                      ),
                      onPressed: () => model.addToCart(
                          CartItem(name: widget.name, total: quantity)),
                    ),
            )
          ],
        ),
      );
    });
  }
}



import 'package:flutter/material.dart';
import 'package:food_rest/model/cart/cart_item.dart';
import 'package:food_rest/model/cart/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartListItem extends StatefulWidget {
  final String imageUrl = "assets/fs7.jpg";
  final CartItem cartItem;

  const CartListItem({Key key, this.cartItem}) : super(key: key);

  @override
  CartListItemState createState() => CartListItemState();
}

class CartListItemState extends State<CartListItem> {
  final int minQ = 1;
  final int maxQ = 10;
  int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartItem.total;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(builder: (b, c, model) {
      bool isInCart = model
          .itemInCart(CartItem(name: widget.cartItem.name, total: quantity));
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
              widget.cartItem.name,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                direction: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: quantity == maxQ
                        ? null
                        : () {
                            if (mounted) {
                              setState(() {
                                quantity += 1;
                              });
                            }

                            if (isInCart) {
                              model.updateQuantity(
                                CartItem(
                                    name: widget.cartItem.name,
                                    total: quantity),
                              );
                            }
                          },
                    child: Container(
                        color: Colors.white,
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: quantity == minQ
                        ? null
                        : () {
                            if (mounted) {
                              setState(() {
                                quantity -= 1;
                              });
                            }

                            if (isInCart) {
                              model.updateQuantity(
                                CartItem(
                                    name: widget.cartItem.name,
                                    total: quantity),
                              );
                            }
                          },
                    child: Container(
                        color: Colors.white,
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                      flex: 1,
                      child: Text(
                        "$quantity congos",
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(width: 4),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: isInCart
                  ? RaisedButton(
                      color: Colors.redAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          CartItem(name: widget.cartItem.name, total: quantity),
                        );

                        setState(() {
                          quantity = 1;
                        });
                      })
                  : RaisedButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add_shopping_cart),
                          Text("Add to Cart"),
                        ],
                      ),
                      onPressed: () => model.addToCart(CartItem(
                          name: widget.cartItem.name, total: quantity)),
                    ),
            )
          ],
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rest/model/cart/cart_item.dart';
import 'package:food_rest/model/cart/cart_model.dart';
import 'package:food_rest/pages/cooked_meal_pages/check_out_page.dart';
import 'package:food_rest/pages/food_stuff_pages/check_out_page.dart';
import 'package:food_rest/pages/food_stuff_pages/food_stuff_dashboard.dart';
import 'package:food_rest/widget/background.dart';
import 'package:food_rest/widget/cart_list_item.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (c, r, model) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FDB(),
                ),
              );
            },
          ),
          body: Stack(
            children: <Widget>[
              BackgroundWidget2(),
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: ListView.builder(
                  itemCount: model.itemCount,
                  itemBuilder: (c, index) {
                    CartItem item = model.cartItemAtIndex(index);
                    return CartListItem(
                      cartItem: item,
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child:model.itemCount == 0? SizedBox() :actionButtons(() {
                  model.emptyCart();
                }),
              )
            ],
          ),
        );
      },
    );
  }

  Widget actionButtons(clear) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.all(8),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: InkWell(
                onTap: clear,
                child: Icon(
                  CupertinoIcons.delete,
                  color: Colors.white,
                  size: 32,
                ) //Icons.delete_outline),
                ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext c) => FoodStuffCheckOutPage()),
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
}

import 'package:flutter/material.dart';
import 'package:food_rest/model/cart/cart_item_storage.dart';
import 'package:food_rest/model/cart/cart_model.dart';
import 'package:food_rest/pages/food_stuff_pages/cart_page.dart';
import 'package:food_rest/pages/food_stuff_pages/check_out_page.dart';
import 'package:scoped_model/scoped_model.dart';

class CartWidget extends StatefulWidget {
  final CartStorage cartStorage = CartStorage();
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (b, c, model) {
        return InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext c) => CartPage()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.shopping_cart),
                Text(
                  "${model.itemCount}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

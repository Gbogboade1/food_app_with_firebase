import 'package:food_rest/model/cart/cart_item.dart';

class CartStorage {
  List<CartItem> cartItems = [];

  int get cartItemCount => cartItems.length;

  void writeCart(CartItem item) {
    return cartItems.add(item);
  }

  bool itemInCart(CartItem item) {
    for (var c in cartItems) {
      if (c.name == item.name) {
        return true;
      }
    }
    return false;
  }

  void removeItem(CartItem item) {
    print("remove ${item.name}");
    cartItems.removeWhere((i) => item.name == i.name);
  }

  itemAtIndex(int index) => cartItems[index];

  clearAll() => cartItems.clear();

  void updateQuantity(CartItem cartItem) {
    int id = 0;
    for (var i = 0; i < cartItems.length; i++) {
      if (cartItem.name == cartItems[i].name) {
        id = i;
        break;
      }
    }
    cartItems.replaceRange(id, id + 1, [cartItem]);
  }

  String fetchSummary() {
    print("fetch");
    String text = "";
    for (var item in cartItems) {
      text += "${item.name}  ${item.total}congos\n";
    }
    print(text);
    return text;
  }
}

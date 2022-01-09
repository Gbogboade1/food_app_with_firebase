import 'package:food_rest/model/cart/cart_item.dart';
import 'package:food_rest/model/cart/cart_item_storage.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  final cartStorage = CartStorage();

  int get itemCount => cartStorage.cartItemCount;

  void addToCart(CartItem data) {
    cartStorage.writeCart(data);
    notifyListeners();
  }

  bool itemInCart(CartItem data) => cartStorage.itemInCart(data);

  CartItem cartItemAtIndex(int index) => cartStorage.itemAtIndex(index);

  void removeFromCart(CartItem item) {
    cartStorage.removeItem(item);
    notifyListeners();
  }

  void emptyCart() {
    cartStorage.clearAll();
    notifyListeners();
  }

  void updateQuantity(CartItem item){
    cartStorage.updateQuantity(item);
    notifyListeners();
  }

  String get fetchSummary => cartStorage.fetchSummary();
}

import 'package:flutter/foundation.dart';

import '../catalog/product.dart';
import 'cart_item.dart';

class CartController extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();
  int get itemCount => _items.values.fold(0, (total, item) => total + item.quantity);
  double get total => _items.values.fold(0, (sum, item) => sum + item.subtotal);

  void add(Product product) {
    final current = _items[product.id];
    _items[product.id] = current == null
        ? CartItem(product: product, quantity: 1)
        : current.copyWith(quantity: current.quantity + 1);
    notifyListeners();
  }

  void decrease(Product product) {
    final current = _items[product.id];
    if (current == null) return;

    if (current.quantity <= 1) {
      _items.remove(product.id);
    } else {
      _items[product.id] = current.copyWith(quantity: current.quantity - 1);
    }
    notifyListeners();
  }

  void remove(Product product) {
    _items.remove(product.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

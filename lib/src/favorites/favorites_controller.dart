import 'package:flutter/foundation.dart';

import '../catalog/product.dart';

class FavoritesController extends ChangeNotifier {
  final Map<int, Product> _items = {};

  List<Product> get items => _items.values.toList();

  bool contains(Product product) => _items.containsKey(product.id);

  void toggle(Product product) {
    if (contains(product)) {
      _items.remove(product.id);
    } else {
      _items[product.id] = product;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

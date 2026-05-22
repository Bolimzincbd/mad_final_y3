import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  // Read-only list of items
  List<CartItem> get items => _items;

  // Get total count of unique items
  int get itemCount => _items.length;

  // Calculate total money price
  double get totalPrice {
    double total = 0.0;
    for (var item in _items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // Add product to cart
  void addToCart(Product product) {
    // Check if the product is already in the cart
    int index = _items.indexWhere((item) => item.product.id == product.id);
    
    if (index >= 0) {
      // If it exists, just increase the quantity
      _items[index].quantity++;
    } else {
      // If it's new, add it to the list
      _items.add(CartItem(product: product));
    }
    notifyListeners(); // Tell the UI to update!
  }

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      // If quantity is 1 and user decreases, remove it from cart
      _items.remove(cartItem);
    }
    notifyListeners();
  }

  void removeItem(CartItem cartItem) {
    _items.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

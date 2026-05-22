import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_card.dart';
import '../utils/currency_formatter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  void _checkout(BuildContext context, CartProvider cart) {
    // 1. Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: const Text('Your order has been placed.'),
        actions: [
          TextButton(
            onPressed: () {
              // 2. Close the dialog
              Navigator.of(context).pop();
              // 3. Clear the cart
              cart.clearCart();
              // 4. Go back to Home Screen
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          return Column(
            children: [

              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    return CartItemCard(cartItem: cart.items[index]);
                  },
                ),
              ),
              

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, -5))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 16, color: Colors.grey)),
                        Text(
                          CurrencyFormatter.format(cart.totalPrice),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      onPressed: () => _checkout(context, cart),
                      child: const Text('CHECKOUT', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../config/environment.dart';
import '../utils/currency_formatter.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isCartEnabled = AppConfig.instance.enableCart;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [

            Expanded(
              child: product.imageUrl.isNotEmpty
                  ? Image.network(product.imageUrl, fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 50))
                  : const Icon(Icons.image, size: 50),
            ),
            const SizedBox(height: 8),

            Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),

            Text(CurrencyFormatter.format(product.price), style: const TextStyle(color: Colors.green, fontSize: 14)),
            const SizedBox(height: 8),

            if (isCartEnabled)
              ElevatedButton(
                onPressed: () {
                  // Save to provider state
                  Provider.of<CartProvider>(context, listen: false).addToCart(product);
                  // Show a tiny message at the bottom
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} added to cart!'), duration: const Duration(seconds: 1)),
                  );
                },
                child: const Text('Add to Cart'),
              ),
          ],
        ),
      ),
    );
  }
}
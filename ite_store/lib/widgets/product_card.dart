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
            // Image takes the remaining flexible space safely
            Expanded(
              child: product.imageUrl.isNotEmpty
                  ? Image.network(product.imageUrl, fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 50))
                  : const Icon(Icons.image, size: 50),
            ),
            const SizedBox(height: 8),

            // FIXED: Prevent long product names from wrapping infinitely and causing overflow
            Text(
              product.name, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            // FIXED: Use FittedBox so large price strings shrink instead of wrapping/overflowing
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                CurrencyFormatter.format(product.price), 
                style: const TextStyle(color: Colors.green, fontSize: 14)
              ),
            ),
            const SizedBox(height: 8),

            if (isCartEnabled)
              // prevent overflow on small screens
              SizedBox(
                width: double.infinity, // Button takes full width cleanly
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8), // Tighter padding
                  ),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart!'), duration: const Duration(seconds: 1)),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
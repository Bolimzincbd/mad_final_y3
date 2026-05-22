import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/environment.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductService _productService = ProductService();
  List<Product> _allProducts = [];
  List<Product> _displayedProducts = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProducts(); // Load data when screen starts
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productService.fetchProducts();
      setState(() {
        _allProducts = products;
        _displayedProducts = products; // Show all products at first
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // Search logic
  void _searchProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedProducts = _allProducts;
      } else {
        // Filter the list based on the user's typed word
        _displayedProducts = _allProducts
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCartEnabled = AppConfig.instance.enableCart;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.instance.appName),
        actions: [
          // Only show cart icon if not in Demo mode
          if (isCartEnabled)
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        // Go to Cart Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartScreen()),
                        );
                      },
                    ),
                    // Red dot with number for items in cart
                    if (cart.itemCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text('${cart.itemCount}',
                              style: const TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                      )
                  ],
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Image.asset(
              AppConfig.instance.logoPath,
              height: 100, 
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: _searchProducts, 
            ),
          ),
          
          // Main Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator()) // Loading spinner
                : _errorMessage.isNotEmpty
                    ? Center(child: Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red))) // Error message
                    : _displayedProducts.isEmpty
                        ? const Center(child: Text('No products found.'))
                        : GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 items per row
                              childAspectRatio: 0.75, 
                            ),
                            itemCount: _displayedProducts.length,
                            itemBuilder: (context, index) {
                              return ProductCard(product: _displayedProducts[index]);
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
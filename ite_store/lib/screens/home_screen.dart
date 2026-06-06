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
    _loadProducts(); 
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productService.fetchProducts();
      setState(() {
        _allProducts = products;
        _displayedProducts = products; 
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _searchProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedProducts = _allProducts;
      } else {
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
      // FIXED: Prevents bottom overflow when the keyboard pops up for the search bar
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: Text(AppConfig.instance.appName),
        actions: [
          if (isCartEnabled)
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartScreen()),
                        );
                      },
                    ),
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
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.store, size: 80, color: Colors.grey),
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
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator()) 
                : _errorMessage.isNotEmpty
                    ? Center(child: Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red))) 
                    : _displayedProducts.isEmpty
                        ? const Center(child: Text('No products found.'))
                        : GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, 
                              childAspectRatio: 0.75, // Aspect ratio determines item height based on screen width
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
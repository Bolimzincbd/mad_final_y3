import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/environment.dart';
import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    // Combine the Base URL with the file name
    final String url = '${AppConfig.instance.baseUrl}products.json';
    
    try {
      final response = await http.get(Uri.parse(url));

      // 200 means OK (success)
      if (response.statusCode == 200) {
        // Decode the JSON string into a List
        List<dynamic> data = json.decode(response.body);
        // Convert the JSON list into a List of Product objects
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
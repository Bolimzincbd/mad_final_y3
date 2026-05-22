class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  // This factory function reads the JSON dictionary and creates a Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? 'Unknown Product',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['image_url'] ?? '', // Assume the JSON has an 'image_url' field
    );
  }
}
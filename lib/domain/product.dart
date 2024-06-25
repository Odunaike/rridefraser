import 'dart:convert';

class ProductModel {
  final List<Product> products;

  ProductModel({required this.products});

  factory ProductModel.fromRawJson(String str) {
    List<dynamic> json = jsonDecode(str);
    List<Product> _products = [];
    for (dynamic product in json) {
      dynamic xxx = Product.fromJson(product);
      _products.add(xxx);
    }
    return ProductModel(products: _products);
  }
}

class Product {
  String id;
  String name;
  String description;
  int price;
  List<dynamic> imageUrls;
  String userID;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrls,
      required this.userID});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrls: json['images'],
      userID: json['userId']);
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc_api/screens/data/Product_model.dart';

class ProductRepository {
  Future<List<Product>> getProduct() async {
    final url = 'https://dummyjson.com/products';
    final response = await http.get(Uri.parse(url));
    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<Product> products = (jsonData['products'] as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
      return products;
    } else {
      print('Failed to load products: ${response.statusCode}');
      throw Exception('Failed to load products');
    }
  }
}

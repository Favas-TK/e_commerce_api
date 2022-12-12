import 'dart:convert';

import 'package:ecommerce_api/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Uri url = Uri.parse("https://fakestoreapi.com/products");
  Future<List<Products>> fetchProduct() async {
    final response = await http.get(url);
//print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body).cast<Map<String, dynamic>>();
      // print(data[0]);
      var products =
          data.map<Products>((json) => Products.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('failed to laod products');
    }
  }

  Future<void> addProduct({
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Map? rating,
  }) async {
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          "title": title,
          "price": price,
          "description": description,
          "category": category,
          "image": image,
          "rating": rating,
        },
      ),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  Future<void> updateProduct({
    String? id,
    String? title,
    double? price,
  }) async {
    final response = await http.put(
      Uri.parse(
        'https://fakestoreapi.com/products/$id',
      ),
      body: jsonEncode(
        <String, dynamic>{
          "title": title,
          "price": price,
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  Future<void> deleteProduct({
    String? id,
  }) async {
    final  response = await http.delete(
      Uri.parse(
        'https://fakestoreapi.com/products/$id',
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
    }
  }
}

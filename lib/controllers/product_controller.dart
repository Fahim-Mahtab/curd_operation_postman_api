import 'dart:convert';

import 'package:curd_api_postman/model/products_data.dart';
import 'package:curd_api_postman/utils/urls.dart';
import 'package:http/http.dart' as http;

class ProductController {
  List<Data> products = [];

  Future fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ProductsData model = ProductsData.fromJson(data);
      products = model.data ?? [];
      return products;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<bool> deleteProduct(String productId) async {
    final response = await http.get(
      Uri.parse(Urls.deleteProductById(productId)),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addProduct(
    String name,
    String img,
    int qty,
    int unitPrice,
    int totalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.createProduct),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );

    ///For Debug
    /*    print(response.body);
    print(response.statusCode);*/
    if (response.statusCode == 200) {
      await fetchProducts();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduct(
    String productId,
    String name,
    String img,
    int qty,
    int unitPrice,
    int totalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.updateProductById(productId)),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );

    ///For Debug
    /*    print(response.body);
    print(response.statusCode);*/
    if (response.statusCode == 200) {
      await fetchProducts();
      return true;
    } else {
      return false;
    }
  }
}

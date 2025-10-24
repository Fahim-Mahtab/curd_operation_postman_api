import 'dart:convert';

import 'package:curd_api_postman/model/products_data.dart';
import 'package:curd_api_postman/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductController {
  List<Data> products = [];

  Future fetchProducts() async {
    final response = await http.get(
      Uri.parse(Urls.readProduct),
      // headers: {"Accept": "application/json"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //products = data.map((item) => Data.fromJson(item)).toList();
      ProductsData model = ProductsData.fromJson(data);
      products = model.data ?? [];
      print(products);
    } else {
      throw Exception('Failed to load users');
    }
  }

  //   log(response.body);
  /* if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
      });
    } else {
      SnackBar(
        content: Text(
          'Error fetching users: ${response.reasonPhrase} ${response.statusCode}',
        ),
        duration: Duration(seconds: 3),
      );
    }
  }*/
}

import 'package:curd_api_postman/controllers/product_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController productController = ProductController();
  @override
  void initState() {
    // TODO: implement initState
    productController.fetchProducts();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Curd Operations')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.59,
          crossAxisCount: 2,
        ),
        itemCount: productController.products.length,

        itemBuilder: (context, index) {
          final products = productController.products[index];
          return Card(
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: Image.network(
                    products.img!,
                    fit: BoxFit.cover,
                  ),
                ),
                Text("${products.productName}"),
                Text("Price: \$${products.unitPrice} | Qty: ${products.qty}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

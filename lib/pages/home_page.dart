import 'package:curd_api_postman/controllers/product_controller.dart';
import 'package:curd_api_postman/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController productController = ProductController();
  Future fetchData() async {
    await productController.fetchProducts();
    if (mounted) setState(() {});
  }

  productDialog({
    String? sId,
    String? productName,
    int? productCode,
    String? img,
    int? qty,
    int? unitPrice,
    int? totalPrice,
    required bool isUpdate,
  }) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController imgController = TextEditingController();
    TextEditingController qtyController = TextEditingController();
    TextEditingController unitPriceController = TextEditingController();
    TextEditingController totalPriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? 'Update Product' : 'Add Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextField(
              controller: imgController,
              decoration: InputDecoration(
                labelText: 'Product Image',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextField(
              controller: unitPriceController,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextField(
              controller: qtyController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextField(
              controller: totalPriceController,
              decoration: InputDecoration(
                labelText: 'Total Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    await productController.addProduct(
                      productNameController.text,
                      imgController.text,
                      int.parse(unitPriceController.text),
                      int.parse(qtyController.text),
                      int.parse(totalPriceController.text),
                    );
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Add"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
          return ProductCard(
            products: products,
            onDelete: () async {
              await productController.fetchProducts();
              productController.deleteProduct(products.sId.toString()).then((
                value,
              ) {
                if (value == true) {
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Product Deleted')),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product Not Deleted')),
                  );
                }
              });
            },
            onAdd: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productDialog(isUpdate: false);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

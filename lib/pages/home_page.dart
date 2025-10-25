import 'package:curd_api_postman/controllers/product_controller.dart';
import 'package:curd_api_postman/widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../widgets/my_textfield.dart';

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
    TextEditingController productNameController = TextEditingController(
      text: productName,
    );
    TextEditingController imgController = TextEditingController(text: img);
    TextEditingController qtyController = TextEditingController(
      text: qty?.toString(),
    );
    TextEditingController unitPriceController = TextEditingController(
      text: unitPrice?.toString(),
    );
    TextEditingController totalPriceController = TextEditingController(
      text: totalPrice?.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? 'Update Product' : 'Add Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextField(
              controller: productNameController,
              labelText: 'Product Name',
            ),
            MyTextField(controller: imgController, labelText: 'Product Image'),
            MyTextField(controller: unitPriceController, labelText: 'Price'),
            MyTextField(controller: qtyController, labelText: 'Quantity'),
            MyTextField(
              controller: totalPriceController,
              labelText: 'Total Price',
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    isUpdate
                        ? await productController.updateProduct(
                            sId!,
                            productNameController.text,
                            imgController.text,
                            int.parse(unitPriceController.text),
                            int.parse(qtyController.text),
                            int.parse(totalPriceController.text),
                          )
                        : await productController.addProduct(
                            productNameController.text,
                            imgController.text,
                            int.parse(unitPriceController.text),
                            int.parse(qtyController.text),
                            int.parse(totalPriceController.text),
                          );
                    if (mounted) {
                      Navigator.pop(context);
                    }
                    await fetchData();
                  },
                  child: isUpdate ? Text("Update") : Text("Add"),
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
              bool deleted = await productController.deleteProduct(
                products.sId.toString(),
              );
              if (deleted) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product Deleted')),
                  );
                  await fetchData();
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product Not Deleted')),
                  );
                }
              }
            },
            onEdit: () {
              productDialog(
                sId: products.sId,
                productName: products.productName,
                qty: products.qty,
                unitPrice: products.unitPrice,
                totalPrice: products.totalPrice,
                img: products.img,
                isUpdate: true,
              );
            },
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

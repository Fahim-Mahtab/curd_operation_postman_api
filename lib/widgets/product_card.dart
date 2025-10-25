import 'package:flutter/material.dart';

import '../model/products_data.dart';

class ProductCard extends StatefulWidget {
  final VoidCallback onDelete;
  final VoidCallback onAdd;
  const ProductCard({
    super.key,
    required this.products,
    required this.onDelete, required this.onAdd,
  });

  final Data products;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Container(
              color: Colors.grey[200],
              child: Image.network(
                widget.products.img ?? '',
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.broken_image, size: 60, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'Image not found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(height: 40, child: Text("${widget.products.productName}")),
          SizedBox(height: 10),
          Text(
            "Price: \$${widget.products.unitPrice} | Qty: ${widget.products.qty}",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: widget.onAdd, icon: Icon(Icons.edit)),
              IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete)),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nodejs_tutorial/model/product.dart';
import 'package:nodejs_tutorial/model/services/api.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  const ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    nameController.text = (widget.product != null) ? widget.product!.name : '';
    priceController.text = (widget.product != null)
        ? widget.product!.price
        : '';
    descController.text = (widget.product != null)
        ? widget.product!.description
        : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Create' : 'Update'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(hintText: 'Price'),
              ),
              TextField(
                controller: descController,
                decoration: InputDecoration(hintText: 'Description'),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  var data = Product(
                    name: nameController.text.trim(),
                    price: priceController.text.trim(),
                    description: descController.text.trim(),
                  );

                  if (widget.product == null) {
                    Api.addProduct(Product.toMap(data));
                  } else {
                    // log(widget.product!.id ?? 'null');

                    final data = Product(
                      id: widget.product!.id,
                      name: nameController.text.trim(),
                      price: priceController.text.trim(),
                      description: descController.text.trim(),
                    );
                    Api.updateProduct(widget.product!.id!, Product.toMap(data));
                  }
                },
                child: Text(widget.product == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

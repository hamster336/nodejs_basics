import 'package:flutter/material.dart';
import 'package:nodejs_tutorial/model/custom_enums.dart';
import 'package:nodejs_tutorial/model/product.dart';
import 'package:nodejs_tutorial/model/services/api.dart';
import 'package:nodejs_tutorial/screens/product_form.dart';

class DataViewScreen extends StatefulWidget {
  final Task? task;
  const DataViewScreen({super.key, this.task});

  @override
  State<DataViewScreen> createState() => _DataViewScreenState();
}

class _DataViewScreenState extends State<DataViewScreen> {
  @override
  Widget build(BuildContext context) {
    String title = 'Fetch';
    if (widget.task == Task.delete) {
      title = 'Delete';
    } else if (widget.task == Task.update) {
      title = 'Update';
    }
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: FutureBuilder(
        future: Api.getProduct(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final List<Product> products = snapshot.data ?? [];

            if (products.isEmpty) {
              return Center(
                child: const Text(
                  'No products available',
                  style: TextStyle(color: Colors.black54),
                ),
              );
            }

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final pdata = products[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .center,
                    children: [
                      Icon(Icons.storage_rounded),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: .start,
                        children: [
                          Text(
                            pdata.name.isNotEmpty ? pdata.name : 'No name',
                            style: TextStyle(
                              color: pdata.name.isNotEmpty
                                  ? null
                                  : Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            pdata.price.isNotEmpty
                                ? '\$ ${pdata.price}'
                                : 'No price',
                            style: TextStyle(
                              fontSize: 16,
                              color: pdata.price.isNotEmpty
                                  ? null
                                  : Colors.black54,
                            ),
                          ),
                          Text(
                            pdata.description.isNotEmpty
                                ? pdata.description
                                : 'No description',
                            style: TextStyle(
                              color: pdata.description.isNotEmpty
                                  ? null
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      if (widget.task == Task.update)
                        IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductForm(product: pdata),
                            ),
                          ),
                          icon: Icon(Icons.edit),
                        ),

                      if (widget.task == Task.delete)
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Delete Product',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: const Text(
                                    'Are you sure you want to delete this product?',
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final nav = Navigator.of(context);
                                        await Api.deleteProduct(pdata.id!);
                                        products.removeAt(index);
                                        setState(() {});
                                        nav.pop();
                                      },
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nodejs_tutorial/model/product.dart';
import 'package:nodejs_tutorial/model/services/api.dart';

class FetchScreen extends StatelessWidget {
  const FetchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fetch'), centerTitle: true),
      body: FutureBuilder(
        future: Api.getProduct(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            final List<Product> products = snapshot.data ?? [];

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final pdata = products[index];

                return ListTile(
                  leading: Icon(Icons.storage_rounded),
                  title: Text(pdata.name.isNotEmpty ? pdata.name : 'No name'),
                  subtitle: Text(
                    pdata.description.isNotEmpty
                        ? pdata.description
                        : 'No description',
                  ),
                  trailing: Text(
                    pdata.price.isNotEmpty ? pdata.price : 'No price',
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

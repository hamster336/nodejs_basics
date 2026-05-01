import 'package:flutter/material.dart';
import 'package:nodejs_tutorial/screens/product_form.dart';
import 'package:nodejs_tutorial/screens/fetch.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nodejs Tutorial'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductForm()),
                ),
                child: const Text('CREATE'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FetchScreen()),
                ),
                child: const Text('READ'),
              ),
              ElevatedButton(onPressed: () {
                
              }, child: const Text('UPDATE')),
              ElevatedButton(onPressed: () {}, child: const Text('DELETE')),
            ],
          ),
        ),
      ),
    );
  }
}

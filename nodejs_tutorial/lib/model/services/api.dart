import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:nodejs_tutorial/model/product.dart';

class Api {
  // static const baseUrl = "http://192.168.18.6:2000/api/";
  // proxy setting ma success status na aaya bela yesari port specify garera chalya thiyo

  // static const baseUrl = "http://192.168.18.6/api/";
  //// emulator proxy setting ma ip ra port number set garera status success aayo vane pardaina

  static const baseUrl = 'http://10.0.2.2:2000/api/';
  // 10.0.2.2 is a special emulator alias that always routes to your PC locally, bypassing the WiFi network entirely
  // so individual router ko IPv4 address ley proxy setting change gari rakhnu pardaina

  // add product
  static void addProduct(Map pdata) async {
    log('$pdata');
    var url = Uri.parse("${baseUrl}add_product");

    try {
      final res = await http.post(url, body: pdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        log('$data');
      } else {
        log("Failed to get response!");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // get products
  static Future<List<Product>> getProduct() async {
    var url = Uri.parse("${baseUrl}get_product");

    try {
      final res = await http.get(url);

      final List<Product> products = [];

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        // log(' $data');

        final list = data['products'];

        for (var i in list) {
          products.add(Product.fromMap(i));
        }
      } else {
        log("Failed to get response!");
      }
      return products;
    } catch (e) {
      log("Fetch Error: ${e.toString()}");
      return [];
    }
  }

  // update put method
  static Future<void> updateProduct(
    String id,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse("${baseUrl}update/$id");

    final res = await http.put(url, body: data);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      log('$data');
    } else {
      log('Failed to get response!');
    }
  }

  // delete product
  static Future<void> deleteProduct(String id) async {
    final url = Uri.parse("${baseUrl}delete/$id");

    final res = await http.delete(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body.toString());
      log('$data');
    } else if (res.statusCode == 404) {
      log('Product Not Found!');
    } else {
      log('Failed to get response!');
    }
  }
}

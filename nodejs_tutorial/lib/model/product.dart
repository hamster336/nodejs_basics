class Product {
  String? id;
  String name;
  String price;
  String description;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['pname'],
      price: map['pprice'],
      description: map['pdesc'],
    );
  }

  Map<String, dynamic> toMap(Product p) {
    return {'pname': p.name, 'pprice': p.price, 'pdesc': p.description};
  }
}

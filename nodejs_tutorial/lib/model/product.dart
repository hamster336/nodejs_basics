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

  static Map<String, dynamic> toMap(Product p) {
    final map = {'pname': p.name, 'pprice': p.price, 'pdesc': p.description};

    if (p.id != null) {
      map['id'] = p.id!;
    }

    return map;
  }
}

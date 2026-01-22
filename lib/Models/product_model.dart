class ProductModel {
  int? id;
  String? name;
  double? price;
  String? description;
  bool? isAvailable;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.isAvailable,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = (json['price'] as num?)?.toDouble();
    description = json['description'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'isAvailable': isAvailable,
    };
  }
}

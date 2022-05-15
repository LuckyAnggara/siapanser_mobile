// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

class ProductModel {
  ProductModel({
    this.data,
  });

  final Data? data;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      data: Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    this.data,
    this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  final List<Product>? data;
  final String? nextPageUrl;
  final String? lastPageUrl;
  final dynamic prevPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Data(
      data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      lastPageUrl: json["last_page_url"],
      nextPageUrl: json["next_page_url"],
      prevPageUrl: json["prev_page_url"],
    );
  }
}

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.quantity,
    this.unit,
    // this.type,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? description;
  int? quantity;
  // Type? type;
  Unit? unit;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      quantity: json["quantity"],
      // type: Type.fromJson(json["type"]),
      unit: Unit.fromJson(json["unit"]),
      createdAt: json['created_at'] == null ? null : DateTime.parse(json["created_at"]),
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json["updated_at"]),
    );
  }
}

class Type {
  Type({
    required this.id,
    required this.name,
  });

  int id;
  String? name;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
      );
}

class Unit {
  Unit({
    required this.id,
    required this.name,
  });

  int id;
  String? name;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
      );
}

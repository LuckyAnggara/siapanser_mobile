import 'dart:convert';

class PermintaanModel {
  PermintaanModel({this.userId, this.notes, required this.detail});

  int? userId;
  String? notes;
  List<PermintaanProduct> detail;

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "notes": notes,
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
      };
}

String permintaanModelToJson(PermintaanModel model) {
  final jsonData = model.toJson();
  return json.encode(jsonData);
}

class PermintaanProduct {
  PermintaanProduct(
      {required this.productId, required this.name, required this.quantity, this.unitName});

  final int productId;
  final String name;
  final int quantity;
  final String? unitName;

  Map<String, dynamic> toJson() => {
        "id": productId,
        "quantity": quantity,
      };
}

// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'package:siap_baper/models/product_model.dart';

import 'auth_model.dart';

class RequestModel {
  RequestModel({
    this.data,
  });

  Data? data;

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.data,
  });

  List<RequestData>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<RequestData>.from(json["data"].map((x) => RequestData.fromJson(x))),
      );
}

class RequestData {
  RequestData({
    this.id,
    this.userId,
    this.userAdmin,
    this.noTicket,
    this.notes,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.detail,
    this.timeLog,
  });

  int? id;
  dynamic userId;
  dynamic userAdmin;
  String? noTicket;
  String? notes;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel2? user;
  List<RequestDetail>? detail;
  List<TimeLog>? timeLog;

  factory RequestData.fromJson(Map<String, dynamic> json) {
    return RequestData(
      id: json["id"],
      userId: json["user_id"],
      userAdmin: json["user_admin"],
      noTicket: json["no_ticket"],
      notes: json["notes"],
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      user: UserModel2.fromJson(json["user"]),
      detail: json['detail'] == null
          ? null
          : List<RequestDetail>.from(json["detail"].map((x) => RequestDetail.fromJson(x))),
      timeLog: json['time_log'] == null
          ? null
          : List<TimeLog>.from(json["time_log"].map((x) => TimeLog.fromJson(x))),
    );
  }
}

class RequestDetail {
  RequestDetail({
    this.id,
    this.requestId,
    this.productId,
    this.quantity,
    this.accQuantity,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  int? id;
  int? requestId;
  int? productId;
  int? quantity;
  int? accQuantity;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  factory RequestDetail.fromJson(Map<String, dynamic> json) {
    return RequestDetail(
      id: json["id"],
      requestId: json["request_id"],
      productId: json["product_id"],
      quantity: json["quantity"],
      accQuantity: json["acc_quantity"],
      status: json["status"] == null ? '' : json['status'],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      product: json['product'] == null ? null : Product.fromJson(json["product"]),
    );
  }
}

class TimeLog {
  TimeLog({
    this.id,
    this.requestId,
    this.userId,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? requestId;
  int? userId;
  String? keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel2? user;

  factory TimeLog.fromJson(Map<String, dynamic> json) {
    return TimeLog(
      id: json["id"] == null ? null : json["id"],
      requestId: json["request_id"] == null ? null : json["request_id"],
      userId: json["user_id"] == null ? null : json["user_id"],
      keterangan: json["keterangan"] == null ? null : json["keterangan"],
      createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      user: json["user"] == null ? null : UserModel2.fromJson(json["user"]),
    );
  }
}

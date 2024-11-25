// To parse this JSON data, do
//
//     final storemenulistmodel = storemenulistmodelFromJson(jsonString);

import 'dart:convert';

TotalFloatingOrderModel totalfloatingordermodelFromJson(String str) =>
    TotalFloatingOrderModel.fromJson(json.decode(str));

String totalfloatingordermodelToJson(TotalFloatingOrderModel data) =>
    json.encode(data.toJson());

class TotalFloatingOrderModel {
  String status;
  List<FloatingOrders> list;
  String code;
  String message;

  TotalFloatingOrderModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory TotalFloatingOrderModel.fromJson(Map<String, dynamic> json) =>
      TotalFloatingOrderModel(
        status: json["status"],
        list: List<FloatingOrders>.from(
            json["list"].map((x) => FloatingOrders.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class FloatingOrders {
  int id;

  String dish;
  int item;

  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  FloatingOrders({
    required this.id,
    required this.dish,
    required this.item,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory FloatingOrders.fromJson(Map<String, dynamic> json) => FloatingOrders(
        id: json["id"],
        dish: json["dish"],
        item: json["item"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dish": dish,
        "item": item,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}

// To parse this JSON data, do
//
//     final orderpickupdishlistmodel = orderpickupdishlistmodelFromJson(jsonString);

import 'dart:convert';

Orderpickupdishlistmodel orderpickupdishlistmodelFromJson(String str) =>
    Orderpickupdishlistmodel.fromJson(json.decode(str));

String orderpickupdishlistmodelToJson(Orderpickupdishlistmodel data) =>
    json.encode(data.toJson());

class Orderpickupdishlistmodel {
  String status;
  List<OrderdeatilsList> list;
  String code;
  String message;

  Orderpickupdishlistmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory Orderpickupdishlistmodel.fromJson(Map<String, dynamic> json) =>
      Orderpickupdishlistmodel(
        status: json["status"],
        list: List<OrderdeatilsList>.from(
            json["list"].map((x) => OrderdeatilsList.fromJson(x))),
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

class OrderdeatilsList {
  int pickupItemsCount;
  String orderId;
  String itemsname1;
  String itemsqty1;
  String itemsname2;
  String itemsqty2;
  String itemsname3;
  String itemsqty3;
  String totalItems;
  int status;
  int active;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  OrderdeatilsList({
    required this.pickupItemsCount,
    required this.orderId,
    required this.itemsname1,
    required this.itemsqty1,
    required this.itemsname2,
    required this.itemsqty2,
    required this.itemsname3,
    required this.itemsqty3,
    required this.totalItems,
    required this.status,
    required this.active,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory OrderdeatilsList.fromJson(Map<String, dynamic> json) =>
      OrderdeatilsList(
        pickupItemsCount: json["pickupItemsCount"],
        orderId: json["orderId"],
        itemsname1: json["itemsname1"],
        itemsqty1: json["itemsqty1"],
        itemsname2: json["itemsname2"],
        itemsqty2: json["itemsqty2"],
        itemsname3: json["itemsname3"],
        itemsqty3: json["itemsqty3"],
        totalItems: json["totalItems"],
        status: json["status"],
        active: json["active"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "pickupItemsCount": pickupItemsCount,
        "orderId": orderId,
        "itemsname1": itemsname1,
        "itemsqty1": itemsqty1,
        "itemsname2": itemsname2,
        "itemsqty2": itemsqty2,
        "itemsname3": itemsname3,
        "itemsqty3": itemsqty3,
        "totalItems": totalItems,
        "status": status,
        "active": active,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}

// To parse this JSON data, do
//
//     final storemenulistmodel = storemenulistmodelFromJson(jsonString);

import 'dart:convert';

TotalFloatingModel totalfloatingmodelFromJson(String str) =>
    TotalFloatingModel.fromJson(json.decode(str));

String totalfloatingmodelToJson(TotalFloatingModel data) =>
    json.encode(data.toJson());

class TotalFloatingModel {
  String status;
  List<Floatings> list;
  String code;
  String message;

  TotalFloatingModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory TotalFloatingModel.fromJson(Map<String, dynamic> json) =>
      TotalFloatingModel(
        status: json["status"],
        list: List<Floatings>.from(
            json["list"].map((x) => Floatings.fromJson(x))),
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

class Floatings {
  int id;
  String orderid;
  String time;

  String item;
  String earningstatus;
  int status;
  int active;
  int createdBy;
  dynamic createdDate;
  int updatedBy;
  dynamic updatedDate;

  Floatings({
    required this.id,
    required this.orderid,
    required this.time,
    required this.item,
    required this.earningstatus,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory Floatings.fromJson(Map<String, dynamic> json) => Floatings(
        id: json["id"],
        orderid: json["orderid"],
        time: json["time"],
        item: json["item"],
        earningstatus: json["earningstatus"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderid": orderid,
        "time": time,
        "item": item,
        "earningstatus": earningstatus,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}

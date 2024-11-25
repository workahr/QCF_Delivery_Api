// To parse this JSON data, do
//
//     final storemenulistmodel = storemenulistmodelFromJson(jsonString);

import 'dart:convert';

TotalEarningModel totalearningmodelFromJson(String str) =>
    TotalEarningModel.fromJson(json.decode(str));

String totalearningmodelToJson(TotalEarningModel data) =>
    json.encode(data.toJson());

class TotalEarningModel {
  String status;
  List<Earnings> list;
  String code;
  String message;

  TotalEarningModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory TotalEarningModel.fromJson(Map<String, dynamic> json) =>
      TotalEarningModel(
        status: json["status"],
        list:
            List<Earnings>.from(json["list"].map((x) => Earnings.fromJson(x))),
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

class Earnings {
  int id;
  String orderid;
  String time;

  int item;
  String earningstatus;
  int status;
  int active;
  int createdBy;
  DateTime? createdDate;
  int updatedBy;
  DateTime? updatedDate;

  Earnings({
    required this.id,
    required this.orderid,
    required this.time,
    required this.item,
    required this.earningstatus,
    required this.status,
    required this.active,
    required this.createdBy,
    this.createdDate,
    required this.updatedBy,
    this.updatedDate,
  });

  factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
        id: json["id"],
        orderid: json["orderid"],
        time: json["time"],
        item: json["item"],
        earningstatus: json["earningstatus"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"] != null
            ? DateTime.parse(json["created_date"]) // Parse string to DateTime.
            : DateTime.now(), // Default to current date if null.
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] != null
            ? DateTime.parse(json["updated_date"]) // Parse string to DateTime.
            : DateTime.now(), // Defaul
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
        "created_date": createdDate?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
      };
}

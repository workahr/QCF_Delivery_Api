// To parse this JSON data, do
//
//     final orderpickstatusmodel = orderpickstatusmodelFromJson(jsonString);

import 'dart:convert';

Orderpickstatusmodel orderpickstatusmodelFromJson(String str) =>
    Orderpickstatusmodel.fromJson(json.decode(str));

String orderpickstatusmodelToJson(Orderpickstatusmodel data) =>
    json.encode(data.toJson());

class Orderpickstatusmodel {
  String status;
  String code;
  String message;

  Orderpickstatusmodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory Orderpickstatusmodel.fromJson(Map<String, dynamic> json) =>
      Orderpickstatusmodel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}

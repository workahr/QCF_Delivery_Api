
import 'dart:convert';

DashboardDeliveryModel dashboardDeliveryModelFromJson(String str) =>
    DashboardDeliveryModel.fromJson(json.decode(str));

String dashboardDeliveryModelToJson(DashboardDeliveryModel data) =>
    json.encode(data.toJson());

class DashboardDeliveryModel {
  String status;
  DeliveryEarningData list;
  String code;
  String message;

  DashboardDeliveryModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory DashboardDeliveryModel.fromJson(Map<String, dynamic> json) =>
      DashboardDeliveryModel(
        status: json["status"],
        list: DeliveryEarningData.fromJson(json["list"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list.toJson(),
        "code": code,
        "message": message,
      };
}

class DeliveryEarningData {
  String cash;
  String myEarn;
  String allAmount;

  DeliveryEarningData({
    required this.cash,
    required this.myEarn,
    required this.allAmount,
  });

  factory DeliveryEarningData.fromJson(Map<String, dynamic> json) =>
      DeliveryEarningData(
        cash: _convertToString(json["cash"]),
        myEarn: _convertToString(json["my_earn"]),
        allAmount: _convertToString(json["all_amount"]),
      );

  Map<String, dynamic> toJson() => {
        "cash": cash,
        "my_earn": myEarn,
        "all_amount": allAmount,
      };

  // Helper function to handle dynamic types
  static String _convertToString(dynamic value) {
    if (value == null) return '0'; // Default value if null
    if (value is String) return value;
    if (value is int) return value.toString();
    throw Exception("Unexpected type for value: $value");
  }
}


// // To parse this JSON data, do
// //
// //     final dashboardDeliveryModel = dashboardDeliveryModelFromJson(jsonString);

// import 'dart:convert';

// DashboardDeliveryModel dashboardDeliveryModelFromJson(String str) => DashboardDeliveryModel.fromJson(json.decode(str));

// String dashboardDeliveryModelToJson(DashboardDeliveryModel data) => json.encode(data.toJson());

// class DashboardDeliveryModel {
//     String status;
//     DeliveryEarningData list;
//     String code;
//     String message;

//     DashboardDeliveryModel({
//         required this.status,
//         required this.list,
//         required this.code,
//         required this.message,
//     });

//     factory DashboardDeliveryModel.fromJson(Map<String, dynamic> json) => DashboardDeliveryModel(
//         status: json["status"],
//         list: DeliveryEarningData.fromJson(json["list"]),
//         code: json["code"],
//         message: json["message"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "list": list.toJson(),
//         "code": code,
//         "message": message,
//     };
// }

// class DeliveryEarningData {
//     String cash;
//     String myEarn;
//     String allAmount;

//     DeliveryEarningData({
//         required this.cash,
//         required this.myEarn,
//         required this.allAmount,
//     });

//     factory DeliveryEarningData.fromJson(Map<String, dynamic> json) => DeliveryEarningData(
//         cash: json["cash"],
//         myEarn: json["my_earn"],
//         allAmount: json["all_amount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "cash": cash,
//         "my_earn": myEarn,
//         "all_amount": allAmount,
//     };
// }

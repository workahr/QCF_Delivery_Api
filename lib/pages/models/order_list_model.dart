import 'dart:convert';

// Parse JSON data
OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) =>
    json.encode(data.toJson());

// Root Model
class OrderListModel {
  String status;
  List<OrderList> list;
  String code;
  String message;

  OrderListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) =>
      OrderListModel(
        status: json["status"],
        list: List<OrderList>.from(
            json["list"].map((x) => OrderList.fromJson(x))),
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

// Order List Model
class OrderList {
  int id;
  String? orderId;
  String? time;
  String? items;
  String? orderStatus;
  String? deliveryPerson;
  String? reachingTime;

  int status;
  int active;
  int createdBy;
 DateTime? createdDate; // Changed from String? to DateTime.
  int updatedBy;
  DateTime? updatedDate; //

  OrderList({
    required this.id,
    required this.orderId,
    this.time,
    this.items,
    this.orderStatus,
    this.deliveryPerson,
    this.reachingTime,
    required this.status,
    required this.active,
    required this.createdBy,
    this.createdDate,
    required this.updatedBy,
    this.updatedDate,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) =>
      OrderList(
        id: json["id"],
        orderId: json["order_id"],
        time: json["time"],
        items: json["items"],
        orderStatus: json["order_status"],
        deliveryPerson: json["delivery_person"],
        reachingTime: json["reaching_time"],
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
        "order_id": orderId,
        "time": time,
        "items": items,
        "order_status": orderStatus,
        "delivery_person": deliveryPerson,
        "reaching_time": reachingTime,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate?.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
      };

  @override
  String toString() {
    return 'Order ID: $orderId, Status: $orderStatus, Items: $items';
  }
}

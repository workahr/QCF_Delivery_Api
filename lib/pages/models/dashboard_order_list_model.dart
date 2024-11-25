import 'dart:convert';

// Parse JSON data
DashboardOrderListmodel dashboardOrderListModelFromJson(String str) =>
    DashboardOrderListmodel.fromJson(json.decode(str));

String dashboardOrderListModelToJson(DashboardOrderListmodel data) =>
    json.encode(data.toJson());

// Root Model
class DashboardOrderListmodel {
  String status;
  List<DashboardOrderList> list;
  String code;
  double totalEarning;
  double floatingBalance;
  String message;

  DashboardOrderListmodel(
      {required this.status,
      required this.list,
      required this.code,
      required this.message,
      required this.totalEarning,
      required this.floatingBalance});

  factory DashboardOrderListmodel.fromJson(Map<String, dynamic> json) =>
      DashboardOrderListmodel(
        status: json["status"],
        list: List<DashboardOrderList>.from(
            json["list"].map((x) => DashboardOrderList.fromJson(x))),
        code: json["code"],
        message: json["message"],
        totalEarning: json["total_earning"],
        floatingBalance: json["floating_balance"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "code": code,
        "message": message,
        "total_earning": totalEarning,
        "floating_balance": floatingBalance
      };
}

// Order List Model
class DashboardOrderList {
  int id;
  String? orderId;
  String? time;
  String? items;
  String? orderStatus;
  String? deliveryPerson;
  int status;
  int active;
  int createdBy;
  String? createdDate;
  int updatedBy;
  String? updatedDate;

  DashboardOrderList({
    required this.id,
    required this.orderId,
    this.time,
    this.items,
    this.orderStatus,
    this.deliveryPerson,
    required this.status,
    required this.active,
    required this.createdBy,
    this.createdDate,
    required this.updatedBy,
    this.updatedDate,
  });

  factory DashboardOrderList.fromJson(Map<String, dynamic> json) =>
      DashboardOrderList(
        id: json["id"],
        orderId: json["order_id"],
        time: json["time"],
        items: json["items"],
        orderStatus: json["order_status"],
        deliveryPerson: json["delivery_person"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "time": time,
        "items": items,
        "order_status": orderStatus,
        "delivery_person": deliveryPerson,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };

  @override
  String toString() {
    return 'Order ID: $orderId, Status: $orderStatus, Items: $items';
  }
}

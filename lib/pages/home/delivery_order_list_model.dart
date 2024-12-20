// To parse this JSON data, do
//
//     final deliveryOrderListModel = deliveryOrderListModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

DeliveryOrderListModel deliveryOrderListModelFromJson(String str) =>
    DeliveryOrderListModel.fromJson(json.decode(str));

String deliveryOrderListModelToJson(DeliveryOrderListModel data) =>
    json.encode(data.toJson());

class DeliveryOrderListModel {
  String status;
  List<DeliveryOrderList> list;
  String code;
  String message;

  DeliveryOrderListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory DeliveryOrderListModel.fromJson(Map<String, dynamic> json) =>
      DeliveryOrderListModel(
        status: json["status"],
        list: List<DeliveryOrderList>.from(
            json["list"].map((x) => DeliveryOrderList.fromJson(x))),
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

class DeliveryOrderList {
  String? invoiceNumber;
  int? code;
  int? totalProduct;
  String? totalPrice;
  String? deliveryCharges;
  String? orderStatus;
  String? paymentMethod;
  int? prepareMin;
  DateTime createdDate;
  int? userId;
  String? deliveryPartnerId;
  String? customerName;
  String? customerMobile;
  String? deliveryBoyName;
  String? deliveryBoyMobile;
  List<OrderItems> items;
  CustomerAddress customerAddress;
  //StoreAddress storeAddress;
  CustomerDetails customerDetails;

  DeliveryOrderList({
    this.invoiceNumber,
    this.code,
    this.totalProduct,
    this.totalPrice,
    this.deliveryCharges,
    this.orderStatus,
    this.paymentMethod,
    this.prepareMin,
    required this.createdDate,
    this.userId,
    this.deliveryPartnerId,
    this.customerName,
    this.customerMobile,
    this.deliveryBoyName,
    this.deliveryBoyMobile,
    required this.items,
    required this.customerAddress,
    //required this.storeAddress,
    required this.customerDetails,
  });

  factory DeliveryOrderList.fromJson(Map<String, dynamic> json) =>
      DeliveryOrderList(
        invoiceNumber: json["invoice_number"],
        code: json["code"],
        totalProduct: json["total_product"],
        totalPrice: json["total_price"],
        deliveryCharges: json["delivery_charges"],
        orderStatus: json["order_status"],
        paymentMethod: json["payment_method"],
        prepareMin: json["prepare_min"],
        createdDate: DateTime.parse(json["created_date"]),
        userId: json["user_id"],
        deliveryPartnerId: json["delivery_partner_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        deliveryBoyName: json["delivery_boy_name"],
        deliveryBoyMobile: json["delivery_boy_mobile"],
        items: List<OrderItems>.from(
            json["items"].map((x) => OrderItems.fromJson(x))),
        customerAddress: CustomerAddress.fromJson(json["customer_address"]),
        //storeAddress: StoreAddress.fromJson(json["store_address"]),
        customerDetails: CustomerDetails.fromJson(
            json["customer_details"]), // Parsing new field
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "code": code,
        "total_product": totalProduct,
        "total_price": totalPrice,
        "delivery_charges": deliveryCharges,
        "order_status": orderStatus,
        "payment_method": paymentMethod,
        "prepare_min": prepareMin,
        "created_date": createdDate.toIso8601String(),
        "user_id": userId,
        "delivery_partner_id": deliveryPartnerId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "delivery_boy_name": deliveryBoyName,
        "delivery_boy_mobile": deliveryBoyMobile,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "customer_address": customerAddress.toJson(),
        //"store_address": storeAddress.toJson(),
        "customer_details": customerDetails.toJson(),
      };
}

class CustomerAddress {
  int id;
  int? orderId;
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? addressLine2;
  int? status;
  DateTime createdDate;

  CustomerAddress({
    required this.id,
    this.orderId,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.addressLine2,
    this.status,
    required this.createdDate,
  });

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      CustomerAddress(
        id: json["id"],
        orderId: json["order_id"],
        address: json["address"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        addressLine2: json["address_line_2"],
        status: json["status"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "address": address,
        "landmark": landmark,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "address_line_2": addressLine2,
        "status": status,
        "created_date": createdDate.toIso8601String(),
      };
}

class OrderItems {
  int? orderItemId;
  int? storeId;
  int? orderId;
  int? productId;
  String? productName;
  int? userId;
  String? price;
  int? quantity;
  String? totalPrice;
  String? storePrice;
  String? storeTotalPrice;
  String? imageUrl;
  int? status;
  int? createdBy;
  DateTime? createdDate;
  String? updatedBy;
  String? updatedDate;

  OrderItems({
    this.orderItemId,
    this.storeId,
    this.orderId,
    this.productId,
    this.productName,
    this.userId,
    this.price,
    this.quantity,
    this.totalPrice,
    this.storePrice,
    this.storeTotalPrice,
    this.imageUrl,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
        orderItemId: json["order_item_id"],
        storeId: json["store_id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        userId: json["user_id"],
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        storePrice: json["store_price"],
        storeTotalPrice: json["store_total_price"],
        imageUrl: json["image_url"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "order_item_id": orderItemId,
        "store_id": storeId,
        "order_id": orderId,
        "product_id": productId,
        "product_name": productName,
        "user_id": userId,
        "price": price,
        "quantity": quantity,
        "total_price": totalPrice,
        "store_price": storePrice,
        "store_total_price": storeTotalPrice,
        "image_url": imageUrl,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate!.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}

class StoreAddress {
  int storeId;
  int? userId;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? city;
  String? state;
  String? country;
  String? logo;
  String? gstNo;
  String? panNo;
  String? terms;
  String? zipcode;
  String? frontImg;
  String? onlineVisibility;
  String? tags;
  int? status;
  int? createdBy;
  String? createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  String? slug;
  int storeStatus;

  StoreAddress({
    required this.storeId,
    this.userId,
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.city,
    this.state,
    this.country,
    this.logo,
    this.gstNo,
    this.panNo,
    this.terms,
    this.zipcode,
    this.frontImg,
    this.onlineVisibility,
    this.tags,
    this.status,
    this.createdBy,
    this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    this.slug,
    required this.storeStatus,
  });

  factory StoreAddress.fromJson(Map<String, dynamic> json) => StoreAddress(
        storeId: json["store_id"],
        userId: json["user_id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        logo: json["logo"],
        gstNo: json["gst_no"],
        panNo: json["pan_no"],
        terms: json["terms"],
        zipcode: json["zipcode"],
        frontImg: json["front_img"],
        onlineVisibility: json["online_visibility"],
        tags: json["tags"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
        slug: json["slug"],
        storeStatus: json["store_status"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "user_id": userId,
        "name": name,
        "mobile": mobile,
        "email": email,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "logo": logo,
        "gst_no": gstNo,
        "pan_no": panNo,
        "terms": terms,
        "zipcode": zipcode,
        "front_img": frontImg,
        "online_visibility": onlineVisibility,
        "tags": tags,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
        "slug": slug,
        "store_status": storeStatus,
      };
}

class CustomerDetails {
  int id;
  String? username;
  String? password;
  String? fullname;
  String? email;
  String? mobile;
  int? role;
  String? regOtp;
  int? status;
  int? active;
  int? createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime updatedDate;
  String? mobilePushId;
  String? imageUrl;
  String? licenseNo;
  String? vehicleNo;
  String? vehicleName;
  String? licenseFrontImg;
  String? licenseBackImg;
  String? vehicleImg;
  String? address;
  String? area;
  String? city;
  String? pincode;

  CustomerDetails({
    required this.id,
    this.username,
    this.password,
    this.fullname,
    this.email,
    this.mobile,
    this.role,
    this.regOtp,
    this.status,
    this.active,
    this.createdBy,
    required this.createdDate,
    this.updatedBy,
    required this.updatedDate,
    this.mobilePushId,
    this.imageUrl,
    this.licenseNo,
    this.vehicleNo,
    this.vehicleName,
    this.licenseFrontImg,
    this.licenseBackImg,
    this.vehicleImg,
    this.address,
    this.area,
    this.city,
    this.pincode,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        fullname: json["fullname"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"],
        regOtp: json["reg_otp"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: DateTime.parse(json["updated_date"]),
        mobilePushId: json["mobile_push_id"],
        imageUrl: json["image_url"],
        licenseNo: json["license_no"],
        vehicleNo: json["vehicle_no"],
        vehicleName: json["vehicle_name"],
        licenseFrontImg: json["license_front_img"],
        licenseBackImg: json["license_back_img"],
        vehicleImg: json["vehicle_img"],
        address: json["address"],
        area: json["area"],
        city: json["city"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "fullname": fullname,
        "email": email,
        "mobile": mobile,
        "role": role,
        "reg_otp": regOtp,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate.toIso8601String(),
        "mobile_push_id": mobilePushId,
        "image_url": imageUrl,
        "license_no": licenseNo,
        "vehicle_no": vehicleNo,
        "vehicle_name": vehicleName,
        "license_front_img": licenseFrontImg,
        "license_back_img": licenseBackImg,
        "vehicle_img": vehicleImg,
        "address": address,
        "area": area,
        "city": city,
        "pincode": pincode,
      };
}

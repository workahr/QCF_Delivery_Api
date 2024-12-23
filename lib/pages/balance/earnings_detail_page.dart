import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:namdelivery/widgets/heading_widget.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../widgets/sub_heading_widget.dart';
import '../home/delivery_order_list_model.dart';

class EarningsDetailPage extends StatefulWidget {
  final String orderId;
  final String time;
  final String deliveryCharges;
  final String CreatedDate;
  CustomerAddress customerAddress;
  StoreAddress storeAddress;
  CustomerDetails customerDetails;
  List<OrderItems> orderitems;
  EarningsDetailPage(
      {super.key,
      required this.customerAddress,
      required this.customerDetails,
      required this.storeAddress,
      required this.orderitems,
      required this.orderId,
      required this.time,
      required this.CreatedDate,
      required this.deliveryCharges});

  @override
  State<EarningsDetailPage> createState() => _EarningsDetailPageState();
}

class _EarningsDetailPageState extends State<EarningsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: HeadingWidget(
        title: "Back",
      )),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    HeadingWidget(
                      title: "Order ID ",
                      color: AppColors.black,
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    HeadingWidget(
                      title: widget.orderId.toString(),
                      color: AppColors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border:
                            Border.all(color: AppColors.lightGrey3, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SubHeadingWidget(
                                  title: '${widget.time.toString()} mins',
                                  color: AppColors.black,
                                  fontSize: 16.0,
                                ),
                                SizedBox(height: 4.0),
                                SubHeadingWidget(
                                  title:
                                      "Date:${widget.CreatedDate.toString()}",
                                  color: AppColors.black,
                                  fontSize: 16.0,
                                ),
                                SizedBox(width: 8.0),
                              ],
                            ),
                          ),

                          // Arrow Icon
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: HeadingWidget(
                              title: widget.deliveryCharges.toString(),
                              color: Colors.white,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(255, 217, 216, 216),
                      width: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Pickup Details
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Pickup Image
                            Column(
                              children: [
                                Image.asset(
                                  AppAssets.location_pickup_icon,
                                  height: 30,
                                  width: 30,
                                ),
                                // Dotted Line Between the Images
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Dash(
                                    direction: Axis.vertical,
                                    length: 80, // Adjust length for the spacing
                                    dashLength: 8,
                                    dashColor: Colors.grey,
                                  ),
                                ),
                                // Delivery Image
                                Image.asset(
                                  AppAssets.order_delivery_icon,
                                  height: 30,
                                  width: 30,
                                  color: AppColors.red,
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            // Details Section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Pickup Information
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.red,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      "Pickup",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.light,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  // Text(
                                  //   widget.storeAddress.name.toString(),
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  // SizedBox(height: 4),
                                  // Text(
                                  //   //"No 37 Paranjothi Nagar Thylakoid, velour Nagar Trichy-620005",
                                  //   "${widget.storeAddress.address.toString()}, ${widget.storeAddress.city.toString()}, ${widget.storeAddress.state.toString()}, ${widget.storeAddress.zipcode.toString()}",
                                  //   style: TextStyle(
                                  //       fontSize: 14, color: Colors.black),
                                  // ),
                                  // SizedBox(height: 4),
                                  // Text(
                                  //  "Contact : ${widget.storeAddress.mobile}",
                                  //   style: TextStyle(
                                  //       fontSize: 14, color: Colors.black),
                                  // ),
                                  SizedBox(height: 16),
                                  // Delivery Information
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.red,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      "Delivery",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.light,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    widget.customerDetails.fullname.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${widget.customerAddress.address.toString()}, ${widget.customerAddress.city.toString()}, ${widget.customerAddress.state.toString()}, ${widget.customerAddress.pincode.toString()}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Contact : ${widget.customerDetails.mobile.toString()}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

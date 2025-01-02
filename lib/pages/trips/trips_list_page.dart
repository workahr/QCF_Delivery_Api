import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/heading_widget.dart';
import '../home/delivery_order_list_model.dart';
import '../models/trips_list_model.dart';

class TripsListPage extends StatefulWidget {
  const TripsListPage({super.key});

  @override
  State<TripsListPage> createState() => _TripsListPageState();
}

class _TripsListPageState extends State<TripsListPage> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();

    getAllDeliveryBoyOrders();
  }

  List<TripList> tripList = [];
  List<TripList> tripListAll = [];

  bool isLoading = false;

  Future getTripList() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getTripList();
      var response = tripListModelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          tripList = response.list;
          tripListAll = tripList;
          isLoading = false;
          print(tripListAll);
        });
      } else {
        setState(() {
          tripList = [];
          tripListAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        tripList = [];
        tripListAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

  List<DeliveryOrderList> orderList = [];
  List<DeliveryOrderList> orderListAll = [];

  Future getAllDeliveryBoyOrders() async {
    await apiService.getBearerToken();
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getAllDeliveryBoyOrders();
      var response = deliveryOrderListModelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          orderList = response.list;
          orderListAll = orderList;
          isLoading = false;
          print(orderListAll);
        });
      } else {
        setState(() {
          orderList = [];
          orderListAll = [];
          isLoading = false;
        });
        // showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderList = [];
        orderListAll = [];
        isLoading = false;
      });
      //  showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 80,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: HeadingWidget(
            title: "Total Trips",
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          automaticallyImplyLeading: false,
        ),
        body: isLoading
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _buildShimmerPlaceholder();
                },
              )
            : SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HeadingWidget(
                            title: "Current Trips",
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          if (orderList.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orderList.length,
                              itemBuilder: (context, index) {
                                final order = orderList[index];
                                return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: Column(
                                      children: [
                                        if (order.orderStatus != "Cancelled")
                                          _buildOrderCard(
                                            orderId:
                                                order.invoiceNumber.toString(),
                                            time: order.prepareMin.toString(),
                                            items:
                                                order.items.length.toString(),
                                            status:
                                                order.orderStatus.toString(),
                                            color: order.orderStatus ==
                                                    "Order Placed"
                                                ? AppColors.green
                                                : AppColors.darkgold,
                                          ),
                                      ],
                                    ));
                              },
                            ),
                        ]))));
  }

  // Widget for Recent Orders Card
  Widget _buildOrderCard({
    required String orderId,
    required String time,
    required String items,
    required String status,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.lightGrey3, width: 1.5),
      ),
      child: Row(
        children: [
          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    HeadingWidget(
                      title: "Order ID ",
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                    HeadingWidget(
                      title: orderId.toString(),
                      fontWeight: FontWeight.bold,
                      color: AppColors.red,
                      fontSize: 17.0,
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Text(
                      "$time | $items items",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: HeadingWidget(
                        title: status,
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Status Badge

          SizedBox(width: 8.0),
          // Arrow Icon
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

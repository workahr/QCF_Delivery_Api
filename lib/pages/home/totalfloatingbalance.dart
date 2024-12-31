import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namdelivery/pages/models/lotalfloatingbalance_model.dart';

import 'package:namdelivery/widgets/heading_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/sub_heading_widget.dart';
import 'delivery_order_list_model.dart';
import 'floatingbalancedetailspage.dart';

class Totalfloatingbalance extends StatefulWidget {
  const Totalfloatingbalance({super.key});

  @override
  State<Totalfloatingbalance> createState() => _TotalfloatingbalanceState();
}

class _TotalfloatingbalanceState extends State<Totalfloatingbalance> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();

    getAllDeliveryBoyOrders();
  }

  bool isLoading = false;

  List<DeliveryOrderList> orderList = [];
  List<DeliveryOrderList> orderListAll = [];

  List<DeliveryOrderList> ordersForToday = [];
  List<DeliveryOrderList> ordersNotForToday = [];

  // double totalDiscountPrice = 0.0;

  double totalEarning = 0;
  double floatingBalance = 0;

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
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

          // Filter orders with the current date.
          ordersForToday = orderListAll.where((order) {
            return order.createdDate != null &&
                DateFormat('yyyy-MM-dd').format(order.createdDate) == today;
          }).toList();

          // Filter orders with other dates or null dates.
          ordersNotForToday = orderListAll.where((order) {
            return order.createdDate == null ||
                DateFormat('yyyy-MM-dd').format(order.createdDate) != today;
          }).toList();
        });
      } else {
        setState(() {
          orderList = [];
          orderListAll = [];
          isLoading = false;
        });
        //showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderList = [];
        orderListAll = [];
        isLoading = false;
      });
      //showInSnackBar(context, 'Error occurred: $e');
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
                height: 50,
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
        //backgroundColor: AppColors.grey,
        title: HeadingWidget(
          title: 'Total Floating Balance',
        ),
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
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: "Today Balance",
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (ordersForToday.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ordersForToday.length,
                        itemBuilder: (context, index) {
                          final earning = ordersForToday[index];
                          String createDate = DateFormat('dd-MM-yyyy')
                              .format(earning.createdDate);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildOrderCard(
                                orderId: earning.invoiceNumber.toString(),
                                time: earning.prepareMin.toString(),
                                items: earning.items.length.toString(),
                                status: earning.totalPrice.toString(),
                                color: AppColors.red,
                                customerAddress: earning.customerAddress,
                                storeAddress: earning.storeAddress,
                                customerDetails: earning.customerDetails,
                                orderitems: earning.items,
                                createdDate: createDate.toString()),
                          );
                        },
                      )
                    else
                      //SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SubHeadingWidget(
                            title: "No Today Balance",
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (ordersNotForToday.isNotEmpty) ...[
                      HeadingWidget(
                        title: "Yesterday Balance",
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ordersNotForToday.length,
                        itemBuilder: (context, index) {
                          final earning = ordersNotForToday[index];
                          String createDate = DateFormat('dd-MM-yyyy')
                              .format(earning.createdDate);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildOrderCard(
                                orderId: earning.invoiceNumber.toString(),
                                time: earning.prepareMin.toString(),
                                items: earning.items.length.toString(),
                                status: earning.totalPrice.toString(),
                                color: AppColors.red,
                                customerAddress: earning.customerAddress,
                                storeAddress: earning.storeAddress,
                                customerDetails: earning.customerDetails,
                                orderitems: earning.items,
                                createdDate: createDate.toString()),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  // Widget for Recent Orders Card
  Widget _buildOrderCard({
    required String orderId,
    required String time,
    required String items,
    required String status,
    required String createdDate,
    required Color color,
    required List<OrderItems> orderitems,
    required CustomerAddress customerAddress,
    required CustomerDetails customerDetails,
    required StoreAddress storeAddress,
  }) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Floatingbalancedetailspage(
                customerAddress: customerAddress,
                storeAddress: storeAddress,
                customerDetails: customerDetails,
                orderId: orderId.toString(),
                time: time.toString(),
                totalPrice: status.toString(),
                orderitems: orderitems,
                CreatedDate: createdDate.toString(),
              ),
            ),
          );
        },
        child: Container(
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
                          "${time}PM" ' | ' "${items}items",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Status Badge

              SizedBox(width: 8.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "₹ ${status}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namdelivery/widgets/heading_widget.dart';
import 'package:namdelivery/widgets/sub_heading_widget.dart';

import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../home/delivery_order_list_model.dart';
import '../models/order_list_model.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {

   final NamFoodApiService apiService = NamFoodApiService();

@override
void initState() {
  super.initState();
  getAllDeliveryBoyOrders();
}

// List<OrderList> orderList = [];
// List<OrderList> orderListAll = [];
// List<OrderList> ordersForToday = []; 
// List<OrderList> ordersNotForToday = [];

// bool isLoading = false;

// Future getOrderList() async {
//   setState(() {
//     isLoading = true;
//   });

//   try {
//     var result = await apiService.getOrderList();
//     var response = orderListModelFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         orderList = response.list;
//         orderListAll = orderList;

       
//         String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

//         // Filter orders with the current date.
//         ordersForToday = orderList.where((order) {
//           return order.createdDate != null &&
//               DateFormat('yyyy-MM-dd').format(order.createdDate!) == today;
//         }).toList();

//         // Filter orders with other dates or null dates.
//         ordersNotForToday = orderList.where((order) {
//           return order.createdDate == null ||
//               DateFormat('yyyy-MM-dd').format(order.createdDate!) != today;
//         }).toList();

//         isLoading = false;
//         print('Orders for today: $ordersForToday');
//         print('Orders not for today: $ordersNotForToday');
//       });
//     } else {
//       setState(() {
//         orderList = [];
//         orderListAll = [];
//         ordersForToday = [];
//         ordersNotForToday = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, response.message.toString());
//     }
//   } catch (e) {
//     setState(() {
//       orderList = [];
//       orderListAll = [];
//       ordersForToday = [];
//       ordersNotForToday = [];
//       isLoading = false;
//     });
//     showInSnackBar(context, 'Error occurred: $e');
//   }
// }


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
              DateFormat('yyyy-MM-dd').format(order.createdDate) == today && order.orderStatus != "New";
        }).toList();

        // Filter orders with other dates or null dates.
        ordersNotForToday = orderListAll.where((order) {
          return order.createdDate == null ||
              DateFormat('yyyy-MM-dd').format(order.createdDate) != today && order.orderStatus != "New";
        }).toList();

        });
      } else {
        setState(() {
          orderList = [];
          orderListAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderList = [];
        orderListAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: HeadingWidget(
        title: "Total Orders",
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      automaticallyImplyLeading: false,
    ),
    body:  orderList.isEmpty
          ? Center(child: CircularProgressIndicator())
          :
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingWidget(
              title: "Today Orders",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 6.0,),
            if(ordersForToday.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ordersForToday.length,
              itemBuilder: (context, index) {
                final order = ordersForToday[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildOrderCard(
                    orderId: order.invoiceNumber.toString(),
                    time: order.prepareMin.toString(),
                    items: order.items.length.toString(),
                    status: order.orderStatus.toString(),
                    //reachingTime: order.reachingTime.toString(),
                    color: AppColors.green,
                  ),
                );
              },
            )
            else
            //SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubHeadingWidget(title: "No Today Completed Orders", color: AppColors.black,),
              ],
            ),

            SizedBox(height: 10.0,),
            
            if (ordersNotForToday.isNotEmpty) ...[
              HeadingWidget(
                title: "Yesterday Orders",
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
               SizedBox(height: 6.0,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ordersNotForToday.length,
                itemBuilder: (context, index) {
                  final order = ordersNotForToday[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _buildOrderCard(
                      orderId: order.invoiceNumber.toString(),
                      time: order.prepareMin.toString(),
                      items: order.items.length.toString(),
                      status: order.orderStatus.toString(),
                      //reachingTime: order.reachingTime.toString(),
                      color: AppColors.red,
                    ),
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
     String? reachingTime="",
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
                      "$time mins | $items items $reachingTime",
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
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

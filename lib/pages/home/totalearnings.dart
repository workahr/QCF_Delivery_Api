import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namdelivery/widgets/button1_widget.dart';
import 'package:namdelivery/widgets/heading_widget.dart';

import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/sub_heading_widget.dart';
import '../balance/earnings_detail_page.dart';
import '../models/totalearning_model.dart';

class Totalearnings extends StatefulWidget {
  const Totalearnings({super.key});

  @override
  State<Totalearnings> createState() => _TotalearningsState();
}

class _TotalearningsState extends State<Totalearnings> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();

    gettotalearning();
  }

  //orderdetails
  List<Earnings> earnings = [];
  List<Earnings> earningsAll = [];
  List<Earnings> earningsForToday = [];
  List<Earnings> earningsNotForToday = [];
  bool isLoading = false;

  Future gettotalearning() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.gettotalearning();
      var response = totalearningmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          earnings = response.list;
          earningsAll = earnings;

          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

          // Filter orders with the current date.
          earningsForToday = earnings.where((order) {
            return order.createdDate != null &&
                DateFormat('yyyy-MM-dd').format(order.createdDate!) == today;
          }).toList();

          // Filter orders with other dates or null dates.
          earningsNotForToday = earnings.where((order) {
            return order.createdDate == null ||
                DateFormat('yyyy-MM-dd').format(order.createdDate!) != today;
          }).toList();
          isLoading = false;
          print('Orders for today: $earningsForToday');
          print('Orders not for today: $earningsNotForToday');
        });
      } else {
        setState(() {
          earnings = [];
          earningsAll = [];
          earningsForToday = [];
          earningsNotForToday = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        earnings = [];
        earningsAll = [];
        earningsForToday = [];
        earningsNotForToday = [];
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
        //backgroundColor: AppColors.grey,
        title: HeadingWidget(
          title: 'Total earnings',
        ),
      ),
      body: SingleChildScrollView(
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
              SizedBox(
                height: 10,
              ),
              if (earningsForToday.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: earningsForToday.length,
                  itemBuilder: (context, index) {
                    final earning = earningsForToday[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildOrderCard(
                        orderId: earning.orderid.toString(),
                        time: earning.time.toString(),
                        items: earning.item.toString(),
                        status: earning.earningstatus.toString(),
                        color: AppColors.red,
                      ),
                    );
                  },
                ),
              if (earningsForToday.isNotEmpty) ...[
                HeadingWidget(
                  title: "Yesterday Orders",
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: earningsForToday.length,
                  itemBuilder: (context, index) {
                    final earning = earningsForToday[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildOrderCard(
                        orderId: earning.orderid.toString(),
                        time: earning.time.toString(),
                        status: earning.earningstatus.toString(),
                        items: earning.item.toString(),
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
  );
}

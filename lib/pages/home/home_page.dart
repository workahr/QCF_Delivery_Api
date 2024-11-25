import 'package:flutter/material.dart';
import 'package:namdelivery/widgets/heading_widget.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/sub_heading_widget.dart';
import '../models/dashboard_order_list_model.dart';
import '../order/orderconfirm_page.dart';
import 'totalearnings.dart';
import 'totalfloatingbalance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOnDuty = true;

  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();

    getDashboardOrderlist();
  }

  List<DashboardOrderList> orderList = [];
  List<DashboardOrderList> orderListAll = [];

  bool isLoading = false;
  // double totalDiscountPrice = 0.0;

  double totalEarning = 0;
  double floatingBalance = 0;

  Future getDashboardOrderlist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getDashboardOrderlist();
      var response = dashboardOrderListModelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          orderList = response.list;
          orderListAll = orderList;
          isLoading = false;
          print(orderListAll);
          totalEarning = response.totalEarning;
          floatingBalance = response.floatingBalance;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Color(0xFFE23744),
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingWidget(
                        title: "Hi John",
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        vMargin: 1.0,
                      ),
                      //SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubHeadingWidget(
                            title: "ID - DB12345",
                            color: Colors.white,
                            fontSize: 16.0,
                            vMargin: 1.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SubHeadingWidget(
                                title: "Duty Status",
                                color: Colors.white,
                                fontSize: 17.0,
                                vMargin: 1.0,
                              ),
                              SizedBox(width: 8.0),
                              Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                  value: isOnDuty,
                                  onChanged: (value) {
                                    setState(() {
                                      isOnDuty = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                  inactiveThumbColor: Colors.grey,
                                  inactiveTrackColor: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Totalearnings(),
                        ),
                      );
                    },
                    imagePath: AppAssets.earningsIcon,
                    amount:
                        curFormatWithDecimal(value: emptyToZero(totalEarning))
                            .toString(),
                    label: "Total earnings",
                  ),
                  SizedBox(width: 12.0),
                  _buildCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Totalfloatingbalance(),
                        ),
                      );
                    },
                    imagePath: AppAssets.dollarIcon,
                    amount: curFormatWithDecimal(
                            value: emptyToZero(floatingBalance))
                        .toString(),
                    label: "Floating balance",
                  ),
                ],
              ),

              SizedBox(height: 20.0),
              // Recent Orders Heading
              Text(
                "Recent Orders",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.0),
              //Orders List
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    final order = orderList[index];
                    return Column(
                      children: [
                        _buildOrderCard(
                          orderId: order.orderId.toString(),
                          time: order.time.toString(),
                          items: order.items.toString(),
                          status: order.orderStatus.toString(),
                        ),
                        SizedBox(height: 12.0),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Earnings/Balance Card
  Widget _buildCard({
    Function()? onTap,
    required String imagePath,
    required String amount,
    required String label,
  }) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: Colors.red, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: 30.0,
              height: 30.0,
              //fit: BoxFit.contain,
            ),

            SizedBox(
              height: 5.0,
            ),

            Text(
              amount,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.red,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeadingWidget(
                  title: label,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                ),
              ],
            ),
            // Forward Arrow
          ],
        ),
      ),
    ));
  }

  // Widget for Recent Orders Card
  Widget _buildOrderCard({
    required String orderId,
    required String time,
    required String items,
    required String status,
  }) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderConfirmPage(),
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
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 13.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: HeadingWidget(
                            title: status,
                            color: Colors.white,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16.0,
              ),
            ],
          ),
        ));
  }
}

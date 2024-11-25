import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/heading_widget.dart';

import '../../constants/constants.dart';
import '../models/floatingorderdetails_model.dart';

class Floatingbalancedetailspage extends StatefulWidget {
  const Floatingbalancedetailspage({super.key});

  @override
  State<Floatingbalancedetailspage> createState() =>
      _FloatingbalancedetailspageState();
}

class _FloatingbalancedetailspageState
    extends State<Floatingbalancedetailspage> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();

    getfloatingorder();
  }

  //orderdetails
  List<FloatingOrders> floatingorder = [];
  List<FloatingOrders> floatingorderAll = [];
  bool isLoading = false;

  Future getfloatingorder() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getfloatingorder();
      var response = totalfloatingordermodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          floatingorder = response.list;
          floatingorderAll = floatingorder;
          isLoading = false;
        });
      } else {
        setState(() {
          floatingorder = [];
          floatingorderAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        floatingorder = [];
        floatingorderAll = [];
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
        backgroundColor: AppColors.lightGrey2,
        title: HeadingWidget(
          title: 'Back',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  HeadingWidget(
                    title: 'Order',
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(width: 6),
                  HeadingWidget(
                    title: '#123456789',
                    color: AppColors.red,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              //Container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: AppColors.grey, width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            HeadingWidget(
                              title: '2.5km',
                            ),
                            const SizedBox(width: 8),
                            HeadingWidget(
                              title: '10mints',
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            HeadingWidget(
                              title: 'Date',
                            ),
                            const SizedBox(width: 8),
                            HeadingWidget(
                              title: '10/12/2024',
                            ),
                          ],
                        ),
                      ],
                    ),
                    ButtonWidget(
                      title: '₹605',
                      width: 70,
                      color: AppColors.red,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              //Container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.grey, width: 0.8),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          AppAssets.location_pickup_icon,
                          height: 30,
                          width: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Dash(
                            direction: Axis.vertical,
                            length: 80,
                            dashLength: 8,
                            dashColor: Colors.grey,
                          ),
                        ),
                        Image.asset(
                          AppAssets.order_delivery_icon_red,
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.red,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              "Pickup",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Hotel Sangeetha's",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "No 37 Paranjothi Nagar Thylakoid, velour Nagar Trichy-620005",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Contact : 1234567890",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.red,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              "Delivery",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Hotel Sangeetha's",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "No 37 Paranjothi Nagar Thylakoid, velour Nagar Trichy-620005",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Contact : 1234567890",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              //Container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: AppColors.grey, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: 'Order Details',
                      color: AppColors.red,
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: floatingorder.length,
                      itemBuilder: (context, index) {
                        final e = floatingorder[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            children: [
                              HeadingWidget(
                                title: e.item.toString(),
                              ),
                              HeadingWidget(
                                title: 'X',
                              ),
                              const SizedBox(width: 8),
                              HeadingWidget(
                                title: e.dish.toString(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

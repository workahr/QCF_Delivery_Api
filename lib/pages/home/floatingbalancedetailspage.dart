import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/heading_widget.dart';

import '../../constants/constants.dart';
import '../../widgets/sub_heading_widget.dart';
import '../models/floatingorderdetails_model.dart';
import 'delivery_order_list_model.dart';

class Floatingbalancedetailspage extends StatefulWidget {
  final String orderId;
  final String time;
  final String totalPrice;
  final String CreatedDate;
  CustomerAddress customerAddress;
  StoreAddress storeAddress;
  CustomerDetails customerDetails;
  List<OrderItems> orderitems;
  Floatingbalancedetailspage(
      {super.key,
      required this.customerAddress,
      required this.customerDetails,
      required this.storeAddress,
      required this.orderitems,
      required this.orderId,
      required this.time,
      required this.CreatedDate,
      required this.totalPrice});

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
        // showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        floatingorder = [];
        floatingorderAll = [];
        isLoading = false;
      });
      // showInSnackBar(context, 'Error occurred: $e');
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
                    title: 'Order ID',
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 6),
                  HeadingWidget(
                    title: widget.orderId.toString(),
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
                        SubHeadingWidget(
                          title: '${widget.time.toString()} mins',
                          color: AppColors.black,
                          fontSize: 16.0,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            HeadingWidget(
                              title: 'Date',
                            ),
                            const SizedBox(width: 8),
                            HeadingWidget(
                              title: widget.CreatedDate.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ButtonWidget(
                      title: widget.totalPrice.toString(),
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
                    // Expanded(
                    //   child:
                    Column(
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
                          widget.storeAddress.name.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: Text(
                              //"No 37 Paranjothi Nagar Thylakoid, velour Nagar Trichy-620005",
                              "${widget.storeAddress.address.toString()}, ${widget.storeAddress.city.toString()}, ${widget.storeAddress.state.toString()}, ${widget.storeAddress.zipcode.toString()}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )),
                        const SizedBox(height: 4),
                        Text(
                          "Contact : ${widget.storeAddress.mobile}",
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
                          widget.customerDetails.fullname.toString() == "null"
                              ? ' '
                              : widget.customerDetails.fullname.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: Text(
                              "${widget.customerAddress.address.toString()}, ${widget.customerAddress.city.toString()}, ${widget.customerAddress.state.toString()}, ${widget.customerAddress.pincode.toString()}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )),
                        const SizedBox(height: 4),
                        Text(
                          "Contact : ${widget.customerDetails.mobile.toString()}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ],
                      // ),
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
                    if (widget.orderitems.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.orderitems.length,
                        itemBuilder: (context, index) {
                          final e = widget.orderitems[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              children: [
                                // HeadingWidget(
                                //   title: e.productName.toString(),
                                // ),
                                HeadingWidget(
                                  title: e.quantity.toString(),
                                ),
                                const SizedBox(width: 6),
                                HeadingWidget(
                                  title: 'X',
                                ),
                                const SizedBox(width: 6),
                                HeadingWidget(
                                  title: e.productName.toString(),
                                ),
                                // HeadingWidget(
                                //   title: e.quantity.toString(),
                                // ),
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

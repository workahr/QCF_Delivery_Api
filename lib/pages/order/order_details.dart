import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:namdelivery/constants/app_assets.dart';
import 'package:namdelivery/constants/app_colors.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:namdelivery/widgets/heading_widget.dart';

import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/custom_text_field.dart';
import '../home/delivery_order_list_model.dart';
import '../models/orderpickupdish_model.dart';
import 'order_details_confirm.dart';

class OrderDetails extends StatefulWidget {
   final String orderId;
  CustomerAddress customerAddress;
    StoreAddress storeAddress;
     List<OrderItems> orderitems;
   OrderDetails({super.key, required this.customerAddress,required this.storeAddress, required this.orderitems, required this.orderId});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final NamFoodApiService apiService = NamFoodApiService();
  List<OrderdeatilsList> orderdishdetailspage = [];
  List<OrderdeatilsList> orderdishdetailspageAll = [];
  bool isLoading = false;

  List<StepperData> stepperData = [
    StepperData(
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Color(0xFF7FB032),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Image.asset(AppAssets.shoopingbag_icon),
      ),
      title: StepperText(
        "Order Confirm",
        textStyle: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    ),
    StepperData(
        title: StepperText(
          "Order Preparing",
          textStyle: const TextStyle(color: Colors.black, fontSize: 12),
        ),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Color(0xFF7FB032),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Image.asset(AppAssets.order_preparing_icon),
        )),
    StepperData(
        title: StepperText(
          "Ready to Delivery",
          textStyle: const TextStyle(color: Colors.black, fontSize: 12),
        ),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Color(0xFF7FB032),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Image.asset(
            AppAssets.ready_todelivery_icon,
            color: Colors.white,
          ),
        )),
  ];

  @override
  void initState() {
    super.initState();
    // Call the method to fetch pickup dish list when the screen is initialized
    getpickupdishlist();
  }

  Future<void> getpickupdishlist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getpickupdishlist(); // Fetch the raw JSON
      print('API Response: $result'); // Log the API response
      var response = orderpickupdishlistmodelFromJson(
          result); // Parse JSON into your model

      // Check for the "SUCCESS" status
      if (response.status == "SUCCESS") {
        // Successfully fetched the data, update state
        setState(() {
          orderdishdetailspage = response.list;
          orderdishdetailspageAll = response.list;
          isLoading = false;
        });
        print("Fetched list: $orderdishdetailspage");
      } else {
        // Handle error if the status is not "SUCCESS"
        setState(() {
          orderdishdetailspage = [];
          orderdishdetailspageAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      // Handle any error that might occur during the API call
      setState(() {
        orderdishdetailspage = [];
        orderdishdetailspageAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }
  }

  void _showpickupconfirmDialog() {
    // Only show the dialog if there are pickup details available
    if (orderdishdetailspage.isEmpty) {
      showInSnackBar(context, "No pickup details available.");
      return;
    }

    // Show dialog with order details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(
          //   "Pickup Details",
          //   style: TextStyle(
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //     color: AppColors.red,
          //   ),
          // ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // widget.orderitems.map((e) {
                // return
                 Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Pickup ${widget.orderitems.length.toString()} items',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.red,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.green,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              "#${widget.orderId.toString()}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                     
                      ...widget.orderitems.map((e) {
                      return _buildItemDetailCard(
                        e.quantity.toString(),
                        e.productName.toString(),
                      );
                    }).toList(), //
                     
                    ],
                  ),
                )
              ]
              // }).toList(),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsConfirm(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Pickup Confirm",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// Helper function to create item detail cards
  Widget _buildItemDetailCard(String qty, String name) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        "$qty x $name",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 60,
          title: Text("Order Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(255, 217, 216, 216),
                      width: 0.8,
                    ),
                  ),
                  child: AnotherStepper(
                    stepperList: stepperData,
                    stepperDirection: Axis.horizontal,
                    iconWidth: 40,
                    iconHeight: 40,
                    activeBarColor: Color(0xFF7FB032),
                    inActiveBarColor: Colors.grey,
                    inverted: true,
                    verticalGap: 30,
                    activeIndex: 1,
                    barThickness: 4,
                  )),
              SizedBox(height: 16),
              // Pickup Details
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
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(
                                    "Order Id  ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    widget.orderId.toString(),
                                    style: TextStyle(
                                        color: AppColors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ]),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      _showpickupconfirmDialog();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: AppColors.red,
                                          width: 1.0,
                                        ),
                                        color: AppColors.red,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: Text(
                                        "Pickup",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 8),
                                Text(
                                  widget.storeAddress.name.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  // "No 37 Paranjothi Nagar Thylakoid, velour Nagar Trichy-620005",
                                   "${widget.storeAddress.address.toString()} ${widget.storeAddress.city.toString()} ${widget.storeAddress.state.toString()} ${widget.storeAddress.zipcode.toString()}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Contact : ${widget.storeAddress.mobile}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                SizedBox(height: 16),
                                HeadingWidget(
                                  title: "Order Details",
                                  color: AppColors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                                SizedBox(height: 10),
                              ...widget.orderitems.map((e) {
                                  return  HeadingWidget(
                                    title: "${e.quantity.toString()} x  ${e.productName.toString()}",
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0);}),
                                // SizedBox(height: 5),
                                // HeadingWidget(
                                //     title: "1 x  Mushroom Briyani",
                                //     color: AppColors.black,
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 16.0),
                                // SizedBox(height: 5),
                                // HeadingWidget(
                                //     title: "1 x  Mutton Briyani",
                                //     color: AppColors.black,
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 16.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(16.0),
                width: double.infinity,
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
                  child:
                   Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: 
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
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
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //SizedBox(height: 8),
                            // Text(
                            //   "Hotel Sangeetha's",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            SizedBox(height: 4),
                            Text(
                              "${widget.customerAddress.address.toString()}, ${widget.customerAddress.city.toString()}, ${widget.customerAddress.state.toString()}, ${widget.customerAddress.pincode.toString()}",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Contact : 1234567890",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            )
                          ]
                           )
                          )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: ElevatedButton(
                onPressed: () {
                  _showpickupconfirmDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Reach Pickup Location",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ))),
    );
  }
}
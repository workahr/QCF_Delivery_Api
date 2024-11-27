import 'package:flutter/material.dart';
import 'package:namdelivery/constants/app_assets.dart';
import 'package:namdelivery/constants/app_colors.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:namdelivery/widgets/heading_widget.dart';

import '../../widgets/custom_text_field.dart';

class OrderDetailsConfirm extends StatefulWidget {
  @override
  _OrderDetailsConfirmState createState() => _OrderDetailsConfirmState();
}

class _OrderDetailsConfirmState extends State<OrderDetailsConfirm> {
  String? selectedValue = 'cash_on_delivery';

  TextEditingController deliverycodeControl = TextEditingController();

  void _showcollectcashDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Text(
              "Order Id  ",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "#1234567890",
              style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )
          ]),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Collect Cash from Customer",
                    style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                SizedBox(height: 8),
                Text("₹" "300.00",
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 8),
                Text("To be collect from customer",
                    style: TextStyle(color: AppColors.black, fontSize: 14)),
                SizedBox(height: 8),
                Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(AppAssets.moneyIcon,
                                    height: 25,
                                    width: 25,
                                    color: AppColors.red),
                                SizedBox(width: 12),
                                HeadingWidget(
                                  title: 'Cash on Delivery',
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            Radio(
                              value: 'cash_on_delivery',
                              groupValue: selectedValue,
                              activeColor: AppColors.red,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  AppAssets.onlinePaymentIcon,
                                  height: 25,
                                  width: 25,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 12),
                                HeadingWidget(
                                  title: 'Online Payment',
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ],
                            ),
                            Radio(
                              value: 'Online Payment',
                              groupValue: selectedValue,
                              activeColor: AppColors.red,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                    width: double.infinity,
                    child: CustomeTextField(
                      control: deliverycodeControl,
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: AppColors.red,
                      ),
                      labelText: "Enter Delivery Code",
                      borderColor: const Color.fromARGB(255, 226, 226, 226),
                    )),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
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
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Collect Cash",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
              Row(children: [
                Text(
                  "Order Id  ",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "#1234567890",
                  style: TextStyle(
                      color: AppColors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ]),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.shade300), // Border color
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  color: Colors.white, // Background color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline,
                            color: Colors.green, size: 24),
                        SizedBox(width: 8),
                        Text(
                          "Pickup confirmed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    // Dropdown arrow
                    Icon(Icons.expand_more, color: Colors.black, size: 24),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.red,
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
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showcollectcashDialog();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: AppColors.red,
                                                width: 1.0,
                                              ),
                                              color: AppColors.red),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Text(
                                            "Delivery",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.expand_less),
                                    ]),
                                SizedBox(height: 8),
                                Text(
                                  "Krishnamoorthy",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "No 37 Paranjothi Nagar Thylakoid, velour Nagar Trichy-620005",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Contact : 1234567890",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 16),
                                HeadingWidget(
                                  title: "Order Details",
                                  color: AppColors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                                SizedBox(height: 10),
                                HeadingWidget(
                                    title: "1 x  Chicken Briyani",
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                                SizedBox(height: 5),
                                HeadingWidget(
                                    title: "1 x  Mushroom Briyani",
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                                SizedBox(height: 5),
                                HeadingWidget(
                                    title: "1 x  Mutton Briyani",
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
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
          ),
        ),
      ),
      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          child: ElevatedButton(
            onPressed: () {
              _showcollectcashDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Reach Drop Location",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          )),
    );
  }
}
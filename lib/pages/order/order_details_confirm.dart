import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namdelivery/constants/app_assets.dart';
import 'package:namdelivery/constants/app_colors.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:namdelivery/pages/maincontainer.dart';
import 'package:namdelivery/widgets/heading_widget.dart';

import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/custom_text_field.dart';
import '../home/delivery_order_list_model.dart';
import '../home/home_page.dart';
import 'map_screen.dart';
import 'orderpickup_model.dart';

class OrderDetailsConfirm extends StatefulWidget {
  final String orderId;
  final String totalPrice;
  final String code;
  CustomerAddress customerAddress;
  CustomerDetails customerDetails;
  List<OrderItems> orderitems;
  OrderDetailsConfirm(
      {super.key,
      required this.customerAddress,
      required this.code,
      required this.customerDetails,
      required this.orderitems,
      required this.orderId,
      required this.totalPrice});

  @override
  _OrderDetailsConfirmState createState() => _OrderDetailsConfirmState();
}

class _OrderDetailsConfirmState extends State<OrderDetailsConfirm> {
  final NamFoodApiService apiService = NamFoodApiService();

  TextEditingController deliverycodeControl = TextEditingController();

  // order pick up status update

  Future updateorderpickupstatus() async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "order_id": widget.orderitems[0].orderId,
      "order_status": "Order Delivered",
      "customer_code": deliverycodeControl.text,
    };
    print("updateorder $postData");
    var result = await apiService.updateorderpickupstatus(postData);

    Orderpickstatusmodel response = orderpickstatusmodelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());

      showInSnackBar(context, "Order Delivered Successfully");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainContainer(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  // void _showcollectcashDialog() {
  //   String? selectedValue = 'Cash';
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Row(children: [
  //           Text(
  //             "Order Id  ",
  //             style: TextStyle(fontSize: 18),
  //           ),
  //           Text(
  //             widget.orderId.toString(),
  //             style: TextStyle(
  //                 color: AppColors.red,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 18),
  //           )
  //         ]),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Text("Collect Cash from Customer",
  //                   style: TextStyle(
  //                       color: AppColors.red,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 16)),
  //               SizedBox(height: 8),
  //               Text("₹" "${widget.totalPrice}",
  //                   style: TextStyle(
  //                       color: AppColors.black,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 20)),
  //               SizedBox(height: 8),
  //               Text("To be collect from customer",
  //                   style: TextStyle(color: AppColors.black, fontSize: 14)),
  //               SizedBox(height: 8),
  //               // Container(
  //               //     padding: EdgeInsets.all(6.0),
  //               //     decoration: BoxDecoration(
  //               //       color: Colors.white,
  //               //       borderRadius: BorderRadius.circular(8.0),
  //               //       border: Border.all(color: Colors.grey.shade300),
  //               //     ),
  //               //     child: Column(
  //               //       crossAxisAlignment: CrossAxisAlignment.start,
  //               //       children: [
  //               //         Row(
  //               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               //           children: [
  //               //             Row(
  //               //               children: [
  //               //                 SizedBox(
  //               //                   width: 10,
  //               //                 ),
  //               //                 Image.asset(AppAssets.moneyIcon,
  //               //                     height: 25,
  //               //                     width: 25,
  //               //                     color: AppColors.red),
  //               //                 SizedBox(width: 12),
  //               //                 HeadingWidget(
  //               //                   title: 'Cash on Delivery',
  //               //                   fontSize: 15.0,
  //               //                   color: Colors.black,
  //               //                 ),
  //               //               ],
  //               //             ),
  //               //             Radio(
  //               //               value: 'cash_on_delivery',
  //               //               groupValue: selectedValue,
  //               //               activeColor: AppColors.red,
  //               //               onChanged: (value) {
  //               //                 setState(() {
  //               //                   selectedValue = value;
  //               //                 });
  //               //               },
  //               //             ),
  //               //           ],
  //               //         ),
  //               //         SizedBox(
  //               //           height: 8.0,
  //               //         ),
  //               //         Row(
  //               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               //           children: [
  //               //             Row(
  //               //               children: [
  //               //                 SizedBox(
  //               //                   width: 10,
  //               //                 ),
  //               //                 Image.asset(
  //               //                   AppAssets.onlinePaymentIcon,
  //               //                   height: 25,
  //               //                   width: 25,
  //               //                   color: Colors.black,
  //               //                 ),
  //               //                 SizedBox(width: 12),
  //               //                 HeadingWidget(
  //               //                   title: 'Online Payment',
  //               //                   color: Colors.black,
  //               //                   fontSize: 15.0,
  //               //                 ),
  //               //               ],
  //               //             ),
  //               //             Radio(
  //               //               value: 'Online Payment',
  //               //               groupValue: selectedValue,
  //               //               activeColor: AppColors.red,
  //               //               onChanged: (value) {
  //               //                 setState(() {
  //               //                   selectedValue = value;
  //               //                 });
  //               //               },
  //               //             ),
  //               //           ],
  //               //         ),
  //               //       ],
  //               //     )),

  //               Container(
  //                 padding: EdgeInsets.all(6.0),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   border: Border.all(color: Colors.grey.shade300),
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             SizedBox(width: 10),
  //                             Image.asset(AppAssets.moneyIcon,
  //                                 height: 25, width: 25, color: Colors.black),
  //                             SizedBox(width: 12),
  //                             HeadingWidget(
  //                               title: 'Cash on Delivery',
  //                               fontSize: 15.0,
  //                               color: Colors.black,
  //                             ),
  //                           ],
  //                         ),
  //                         Radio<String>(
  //                           value: 'Cash',
  //                           groupValue: selectedValue,
  //                           activeColor: AppColors.red,
  //                           onChanged: (value) {
  //                             setState(() {
  //                               selectedValue = value;
  //                               print("Payment option: $selectedValue");
  //                             });
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(height: 8.0),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             SizedBox(width: 10),
  //                             Image.asset(
  //                               AppAssets.onlinePaymentIcon,
  //                               height: 25,
  //                               width: 25,
  //                               color: Colors.black,
  //                             ),
  //                             SizedBox(width: 12),
  //                             HeadingWidget(
  //                               title: 'Online Payment',
  //                               fontSize: 15.0,
  //                               color: Colors.black,
  //                             ),
  //                           ],
  //                         ),
  //                         Radio<String>(
  //                           value: 'Online',
  //                           groupValue: selectedValue,
  //                           activeColor: AppColors.red,
  //                           onChanged: (value) {
  //                             setState(() {
  //                               selectedValue = value;
  //                               print("Payment option: $selectedValue");
  //                             });
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                   width: double.infinity,
  //                   child: CustomeTextField(
  //                     control: deliverycodeControl,
  //                     prefixIcon: Icon(
  //                       Icons.lock_rounded,
  //                       color: AppColors.red,
  //                     ),
  //                     labelText: "Enter Delivery Code",
  //                     borderColor: const Color.fromARGB(255, 226, 226, 226),
  //                   )),
  //               SizedBox(height: 20),
  //               Center(
  //                 child: SizedBox(
  //                   width: double.infinity,
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       print(widget.code);
  //                       print("payment option :$selectedValue");
  //                       print(
  //                           "type code${deliverycodeControl.text.toString()}");
  //                       if (widget.code !=
  //                           deliverycodeControl.text.toString()) {
  //                         //  updateorderpickupstatus();
  //                         showInSnackBar(
  //                             context, "Delivery Code is Not Correct");
  //                       } else if (selectedValue == "Online") {
  //                         _showQRCode();
  //                       } else {
  //                         updateorderpickupstatus();
  //                         // showInSnackBar(
  //                         //     context, "Delivery Code is Not Correct");
  //                       }
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: AppColors.red,
  //                       padding: EdgeInsets.symmetric(vertical: 10),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                     child: Text("Collect Cash",
  //                         style: TextStyle(
  //                             fontSize: 16, fontWeight: FontWeight.bold)),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showcollectcashDialog() {
    String? selectedValue = 'Cash'; // Initialize state within the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Text(
                    "Order Id  ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.orderId.toString(),
                    style: TextStyle(
                      color: AppColors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Collect Cash from Customer",
                      style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "₹${widget.totalPrice}",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "To be collected from customer",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                    ),
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
                                  SizedBox(width: 10),
                                  Image.asset(
                                    AppAssets.moneyIcon,
                                    height: 25,
                                    width: 25,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 12),
                                  HeadingWidget(
                                    title: 'Cash on Delivery',
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              Radio<String>(
                                value: 'Cash',
                                groupValue: selectedValue,
                                activeColor: AppColors.red,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                    print("Payment option: $selectedValue");
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Image.asset(
                                    AppAssets.onlinePaymentIcon,
                                    height: 25,
                                    width: 25,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 12),
                                  HeadingWidget(
                                    title: 'Online Payment',
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              Radio<String>(
                                value: 'Online',
                                groupValue: selectedValue,
                                activeColor: AppColors.red,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                    print("Payment option: $selectedValue");
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomeTextField(
                        control: deliverycodeControl,
                        type: const TextInputType.numberWithOptions(),
                        inputFormaters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^-?(\d+)?\.?\d{0,11}'))
                        ],
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: AppColors.red,
                        ),
                        labelText: "Enter Delivery Code",
                        borderColor: const Color.fromARGB(255, 226, 226, 226),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            print(widget.code);
                            print("Payment option: $selectedValue");
                            print("type code: ${deliverycodeControl.text}");
                            if (deliverycodeControl.text == "") {
                              showInSnackBar(context, "Enter a Delivery Code");
                              // _showQRCode();
                            } else if (selectedValue == "Online") {
                              _showQRCode();
                            } else {
                              updateorderpickupstatus();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Collect Cash",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showQRCode() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Text(
              "QR Code",
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
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.qrcode,
                  height: 505,
                  width: 305,
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        updateorderpickupstatus();
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
                  widget.orderId.toString(),
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
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     _showcollectcashDialog();
                                      //   },
                                      //   child:
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: AppColors.red,
                                              width: 1.0,
                                            ),
                                            color: AppColors.red),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11, vertical: 6),
                                        child: Text(
                                          "Delivery",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // ),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SimpleMapScreen(
                                                        lat: widget.customerAddress
                                                                    .latitude ==
                                                                null
                                                            ? " " //"10.3788"
                                                            : "${widget.customerAddress.latitude}",
                                                        long: widget.customerAddress
                                                                    .longitude
                                                                    .toString() ==
                                                                null
                                                            ? " " //"78.3877"
                                                            : "${widget.customerAddress.longitude.toString()}",
                                                      )),
                                            );
                                          },
                                          child: Image.asset(
                                            AppAssets.location_map_pic,
                                            height: 85,
                                            //width: 305,
                                          )),
                                      // Icon(Icons.expand_less),
                                    ]),
                                SizedBox(height: 8),
                                Text(
                                  widget.customerDetails.fullname.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      widget.customerAddress.address
                                                  .toString() ==
                                              null
                                          ? ''
                                          : "${widget.customerAddress.address.toString()},",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                      widget.customerAddress.city.toString() ==
                                              null
                                          ? ''
                                          : " ${widget.customerAddress.city.toString()},",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                      widget.customerAddress.state.toString() ==
                                              null
                                          ? ''
                                          : " ${widget.customerAddress.state.toString()},",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                      widget.customerAddress.pincode
                                                  .toString() ==
                                              null
                                          ? ''
                                          : " ${widget.customerAddress.pincode.toString()}",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Contact : ${widget.customerDetails.mobile.toString()}",
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
                                ...widget.orderitems.map((e) {
                                  return HeadingWidget(
                                      title:
                                          "${e.quantity} x  ${e.productName}",
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0);
                                }).toList(), //
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

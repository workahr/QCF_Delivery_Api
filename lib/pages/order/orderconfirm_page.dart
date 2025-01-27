import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namdelivery/constants/app_assets.dart';
import 'package:namdelivery/constants/app_colors.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:namdelivery/pages/order/order_cancel.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../home/delivery_order_list_model.dart';
import 'map_screen.dart';
import 'order_details.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderConfirmPage extends StatefulWidget {
  final String orderId;
  final String time;
  final String totalPrice;
  final String date;
  final String code;
  final String orderstatus;
  final String store_accept_date;
  CustomerAddress customerAddress;
  CustomerDetails customerDetails;
  StoreAddress storeAddress;
  List<OrderItems> orderitems;
  OrderConfirmPage(
      {super.key,
      required this.customerAddress,
      required this.customerDetails,
      required this.code,
      required this.storeAddress,
      required this.orderitems,
      required this.orderId,
      required this.time,
      required this.date,
      required this.orderstatus,
      required this.store_accept_date,
      required this.totalPrice});

  @override
  _OrderConfirmPageState createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Could not launch $telUri';
    }
  }

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
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Image.asset(
            AppAssets.ready_todelivery_icon,
            color: Colors.white,
          ),
        )),
  ];

  // double? latitude;
  // double? longitude;
  // bool isLoading = true;

  // // Destination Coordinates
  // final double destinationLatitude = 10.3788;
  // final double destinationLongitude = 78.3877;

  // Future<void> _getCurrentLocation() async {
  //   try {
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Please enable location services.")),
  //       );
  //       setState(() => isLoading = false);
  //       return;
  //     }

  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Location permissions are denied.")),
  //         );
  //         setState(() => isLoading = false);
  //         return;
  //       }
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //             content: Text("Location permissions are permanently denied.")),
  //       );
  //       setState(() => isLoading = false);
  //       return;
  //     }

  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );

  //     setState(() {
  //       latitude = position.latitude;
  //       longitude = position.longitude;
  //       isLoading = false;
  //       _navigateToDestination();
  //     });
  //   } catch (e) {
  //     setState(() => isLoading = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error fetching location: $e")),
  //     );
  //   }
  // }

  // Future<void> _navigateToDestination() async {
  //   if (latitude == null || longitude == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Current location is not available.")),
  //     );
  //     return;
  //   }

  //   final String googleMapsUrl =
  //       "https://www.google.com/maps/dir/?api=1&origin=$latitude,$longitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving";

  //   final String appleMapsUrl =
  //       "https://maps.apple.com/?saddr=$latitude,$longitude&daddr=$destinationLatitude,$destinationLongitude";

  //   if (await canLaunch(googleMapsUrl)) {
  //     await launch(googleMapsUrl);
  //   } else if (await canLaunch(appleMapsUrl)) {
  //     await launch(appleMapsUrl);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Could not launch map for navigation.")),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            toolbarHeight: 85,
            title: Text("Order Confirm",
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold))
            //  flexibleSpace: Stack(children: [

            // Positioned(
            //     bottom: 1,
            //     left: 40,
            //     child: GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => OrderCancel(),
            //             ),
            //           );
            //         },
            //         child: Container(
            //             height: 40,
            //             width: 120,
            //             margin: EdgeInsets.only(bottom: 16),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12),
            //               border: Border.all(
            //                 color: const Color.fromARGB(255, 217, 216, 216),
            //                 width: 0.8,
            //               ),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.white,
            //                 ),
            //               ],
            //             ),
            //             child: Row(children: [
            //               IconButton(
            //                 icon: Icon(Icons.close, color: AppColors.red),
            //                 onPressed: () {},
            //               ),
            //               Text("Reject",
            //                   style: TextStyle(
            //                       color: AppColors.red, fontSize: 16))
            //             ]))))
            // ])
            ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  //color: Colors.white,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Order ID : ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  widget.orderId.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // SizedBox(height: 8),
                                            // Text(
                                            //   widget.time.toString(),
                                            //   style: TextStyle(
                                            //     fontSize: 14,
                                            //     color: Colors.grey[700],
                                            //   ),
                                            // )
                                          ]),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.red,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 8),
                                        child: Text(
                                          widget.totalPrice.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                SizedBox(height: 4),
                                Row(children: [
                                  Text(
                                    "Date        : ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd-MMM-yyyy').format(
                                        DateTime.parse(widget.date.toString())),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.red,
                                    ),
                                  ),
                                ]),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      "Order Accept Time: ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      widget.store_accept_date != "null"
                                          ? DateFormat('hh:mm a').format(
                                              DateTime.parse(widget
                                                  .store_accept_date!) // Parse the string to DateTime
                                              )
                                          : "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Preparation time : ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "${widget.time.toString()}mins",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     color: AppColors.red,
                                      //     borderRadius:
                                      //         BorderRadius.circular(18),
                                      //   ),
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 18, vertical: 8),
                                      //   child: Text(
                                      //     widget.totalPrice.toString(),
                                      //     style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),
                                    ]),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      "PickUp Code : ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      widget.code.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ])),
                ),
                SizedBox(height: 16),

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
                            // Pickup Image
                            Column(
                              children: [
                                Image.asset(
                                  AppAssets.location_pickup_icon,
                                  height: 30,
                                  width: 30,
                                ),
                                // Dotted Line Between the Images
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Dash(
                                    direction: Axis.vertical,
                                    length: 100,
                                    dashLength: 8,
                                    dashColor: Colors.grey,
                                  ),
                                ),
                                // Delivery Image
                                Image.asset(
                                  AppAssets.order_delivery_icon,
                                  height: 30,
                                  width: 30,
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            // Details Section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Pickup Information
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: AppColors.red,
                                            width: 1.0,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: Text(
                                          "Pickup",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           SimpleMapScreen(
                                            //             lat: widget.customerAddress
                                            //                         .latitude ==
                                            //                     null
                                            //                 ? " " //"10.3788"
                                            //                 : "${widget.customerAddress.latitude}",
                                            //             long: widget.customerAddress
                                            //                         .longitude
                                            //                         .toString() ==
                                            //                     null
                                            //                 ? " " //"78.3877"
                                            //                 : "${widget.customerAddress.longitude.toString()}",
                                            //           )),
                                            // );
                                          },
                                          child: Image.asset(
                                            AppAssets.location_map_pic,
                                            height: 75,
                                            //width: 305,
                                          )),
                                    ],
                                  ),
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
                                    "${widget.storeAddress.address.toString()}, ${widget.storeAddress.city.toString()}, ${widget.storeAddress.state.toString()}, ${widget.storeAddress.zipcode.toString()}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Contact : ${widget.storeAddress.mobile}",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            _makePhoneCall(widget
                                                .storeAddress.mobile
                                                .toString());
                                          },
                                          child: Image.asset(
                                              AppAssets.call_iconfill,
                                              height: 35,
                                              width: 35)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Dash(
                                    direction: Axis.horizontal,
                                    length:
                                        MediaQuery.of(context).size.width / 1.5,
                                    dashLength: 8,
                                    dashColor: Colors.grey,
                                  ),

                                  SizedBox(height: 20),
                                  // Delivery Information
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                            height: 75,
                                            //width: 305,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SimpleMapScreen(
                                                      lat:
                                                          widget.customerAddress
                                                              .latitude,
                                                      long: widget
                                                          .customerAddress
                                                          .longitude)),
                                        );
                                      },
                                      child: Text(
                                        widget.customerDetails.fullname
                                                    .toString() ==
                                                "null"
                                            ? ' '
                                            : widget.customerDetails.fullname
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  SizedBox(height: 4),
                                  GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SimpleMapScreen(
                                                      lat:
                                                          widget.customerAddress
                                                              .latitude,
                                                      long: widget
                                                          .customerAddress
                                                          .longitude)),
                                        );
                                      },
                                      child: Text(
                                        "${widget.customerAddress.address.toString()}, ${widget.customerAddress.city.toString()}, ${widget.customerAddress.state.toString()}, ${widget.customerAddress.pincode.toString()}",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      )),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SimpleMapScreen(
                                                          lat: widget
                                                              .customerAddress
                                                              .latitude,
                                                          long: widget
                                                              .customerAddress
                                                              .longitude)),
                                            );
                                          },
                                          child: Text(
                                            "Contact : ${widget.customerDetails.mobile.toString()}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          )),
                                      GestureDetector(
                                          onTap: () async {
                                            _makePhoneCall(widget
                                                .customerDetails.mobile
                                                .toString());
                                          },
                                          child: Image.asset(
                                              AppAssets.call_iconfill,
                                              height: 35,
                                              width: 35)),
                                    ],
                                  )
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
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(18.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetails(
                        customerAddress: widget.customerAddress,
                        storeAddress: widget.storeAddress,
                        orderId: widget.orderId,
                        orderitems: widget.orderitems,
                        customerDetails: widget.customerDetails,
                        totalPrice: widget.totalPrice,
                        code: widget.code,
                        orderstatus: widget.orderstatus,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Confirm Order",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )),
        ));
  }
}

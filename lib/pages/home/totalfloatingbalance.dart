import 'package:flutter/material.dart';
import 'package:namdelivery/pages/models/lotalfloatingbalance_model.dart';

import 'package:namdelivery/widgets/heading_widget.dart';

import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/sub_heading_widget.dart';
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

    gettotalfloating();
  }

  //orderdetails
  List<Floatings> floatings = [];
  List<Floatings> floatingsAll = [];
  bool isLoading = false;

  Future gettotalfloating() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.gettotalfloating();
      var response = totalfloatingmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          floatings = response.list;
          floatingsAll = floatings;
          isLoading = false;
        });
      } else {
        setState(() {
          floatings = [];
          floatingsAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        floatings = [];
        floatingsAll = [];
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
          title: 'Total Floating Balance',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingWidget(
              title: "Today Balance",
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: floatings.length,
                itemBuilder: (context, index) {
                  final e = floatings[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Floatingbalancedetailspage(),
                            ),
                          );
                        },
                        child:
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border:
                            Border.all(color: AppColors.lightGrey3, width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  HeadingWidget(
                                    title: 'Order ID',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  HeadingWidget(
                                    title: e.orderid.toString(),
                                    color: AppColors.red,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  SubHeadingWidget(
                                      title: '${e.time}pm',
                                      color: AppColors.black),
                                  const SizedBox(width: 8),
                                  const Text('|'),
                                  const SizedBox(width: 8),
                                  SubHeadingWidget(
                                      title: '${e.item.toString()} items',
                                      color: AppColors.black),
                                ],
                              ),
                            ],
                          ),
                          ButtonWidget(
                            title: '₹${e.earningstatus}',
                            width: 70,
                            color: AppColors.red,
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

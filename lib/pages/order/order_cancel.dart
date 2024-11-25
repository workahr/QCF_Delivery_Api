import 'package:flutter/material.dart';
import 'package:namdelivery/constants/app_colors.dart';
import 'package:namdelivery/widgets/custom_text_field.dart';

class OrderCancel extends StatefulWidget {
  @override
  _OrderCancelState createState() => _OrderCancelState();
}

class _OrderCancelState extends State<OrderCancel> {
  String? selectedReason; // To store the selected reason
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Cancel Booking',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Please Select the Reason of Cancellation",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),

            // Reason Options
            Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: "Low Pay for Distance",
                      groupValue: selectedReason,
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value as String?;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    Text("Low Pay for Distance"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Lack of Tips",
                      groupValue: selectedReason,
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value as String?;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    Text("Lack of Tips"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Bad Weather Conditions",
                      groupValue: selectedReason,
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value as String?;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    Text("Bad Weather Conditions"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Long delivery time",
                      groupValue: selectedReason,
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value as String?;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    Text("Long delivery time"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Other",
                      groupValue: selectedReason,
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value as String?;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    Text("Other"),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            CustomeTextField(
              width: double.infinity,
              control: descriptionController,
              lines: 6,
              borderRadius: BorderRadius.circular(10),
              hint: "Description",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),

            SizedBox(height: 16),

            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.0,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print("Selected Reason: $selectedReason");
                  print("Description: ${descriptionController.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Submit Button
          ],
        ),
      ),
    );
  }
}

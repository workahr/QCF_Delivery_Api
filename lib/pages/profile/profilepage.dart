import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_colors.dart';

import '../../constants/app_assets.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/heading_widget.dart';
import '../../widgets/sub_heading_widget.dart';
import '../models/profile_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _expandedIndex = -1;
  int all_expandedIndex = -1;
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();

    getmyprofiletitle();
  }

  //myprofiletitle
  List<myprofiletitles> myprofiletitlepage = [];
  List<myprofiletitles> myprofiletitlepageAll = [];
  bool isLoading1 = false;

  Future getmyprofiletitle() async {
    setState(() {
      isLoading1 = true;
    });

    try {
      var result = await apiService.getmyprofiletitle();
      var response = myprofiletitlemodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          myprofiletitlepage = response.list;
          myprofiletitlepageAll = myprofiletitlepage;
          isLoading1 = false;
        });
      } else {
        setState(() {
          myprofiletitlepage = [];
          myprofiletitlepageAll = [];
          isLoading1 = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        myprofiletitlepage = [];
        myprofiletitlepageAll = [];
        isLoading1 = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }


  Future<void> _handleLogout() async {
    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login Page
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(140.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: AppBar(
              title: Text(
                'My Profile',
                style: TextStyle(color: AppColors.white),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.red,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage(AppAssets.profileavathar),
                              radius: 30.0,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingWidget(
                                  title: "Johan Singh",
                                  color: AppColors.white,
                                ),
                                HeadingWidget(
                                  title: "ID -DB12345",
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EditProfilepage()));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.white,
                          ),
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 18,
                            color: AppColors.red,
                          ),
                          label: Text(
                            'Edit',
                            style: TextStyle(
                              color: AppColors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount:
                      myprofiletitlepage.length, // Set the number of items
                  itemBuilder: (context, index) {
                    final e = myprofiletitlepage[index];
                    final status = e.title.toString();
                    if (status == 'Support')
                      return Container(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                                e.icon.toString(),
                                height: 24,
                                width: 24,
                              ),
                              title: HeadingWidget(
                                title: e.title.toString(),
                                color: AppColors.black,
                              ),
                              trailing: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             Addresspage()));
                                    });
                                  }),
                              onTap: () {
                                // setState(() {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => Addresspage()));
                                // });
                              },
                            ),
                          ],
                        ),
                      );
                    else if (status == 'Change password')
                      return Container(
                        height: 50,
                        child: ListTile(
                          leading: Image.asset(
                            e.icon.toString(),
                            height: 24,
                            width: 24,
                          ),
                          title: HeadingWidget(
                            title: e.title.toString(),
                            color: AppColors.black,
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onPressed: () {
                                // setState(() {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => FeedbackPage(),
                                //     ),
                                //   );
                                // });
                              }),
                          onTap: () {
                            // setState(() {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => FeedbackPage(),
                            //     ),
                            //   );
                            // });
                          },
                        ),
                      );
                    else if (status == 'Log out')
                      return 
                      Container(
                        height: 50,
                        child: ListTile(
                          leading: Image.asset(
                            e.icon.toString(),
                            height: 24,
                            width: 24,
                          ),
                          title: HeadingWidget(
                            title: e.title.toString(),
                            color: AppColors.black,
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onPressed: () {

                               
                              
                              }),
                          onTap: () {
                           _handleLogout();
                          },
                        ),
                      );
                    Divider(
                      color: AppColors.grey1,
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

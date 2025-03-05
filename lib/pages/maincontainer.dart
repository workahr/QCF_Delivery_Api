import 'package:flutter/material.dart';
import 'package:namdelivery/pages/home/home_page.dart';
import 'package:namdelivery/pages/orderlist/order_list_page.dart';
import 'package:namdelivery/pages/profile/profilepage.dart';
import 'package:namdelivery/pages/trips/trips_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_assets.dart';

class MainContainer extends StatefulWidget {
  MainContainer({super.key, this.childWidget});

  final Widget? childWidget;

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool navBack = false;

  final List pageId = [1, 5, 8, 12, 15];
  static List<Widget> pageOptions = <Widget>[
    HomePage(),
    OrderListPage(),
    TripsListPage(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) async {
    // if (index == 2) {
    //   // Handle logout
    //   await _handleLogout();
    // } else {
    setState(() {
      _selectedIndex = index;
    });
    //}
  }

  @override
  initState() {
    super.initState();
  }

  @protected
  void didUpdateWidget(oldWidget) {
    print('oldWidget');
    print(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _onPop() async {
    if (_selectedIndex == 0) {
      // Exit the app if already on the home page.
      return;
    } else {
      // Otherwise, navigate back to the first tab (home page).
      setState(() {
        _selectedIndex = 0;
      });
    }
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
    return PopScope(
      onPopInvoked: (popDisposition) async {
        await _onPop();
      },
      child: Scaffold(
        // appBar: CustomAppBar(title: '', leading: SizedBox(), showSearch: true,showCart: false, backgroundColor: [0,2].contains(_selectedIndex) ? AppColors.light: null ,),
        // onPressed: widget.onThemeToggle),
        // drawer: SideMenu(),
        body: pageOptions[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          // onTap: onTabTapped,
          // currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 0
                    ? AppAssets.homeIconSelected // Selected icon
                    : AppAssets.home_icon,
                height: 25,
                width: 25,
              ),
              label: 'Home',

              //   backgroundColor: Color(0xFFE23744)
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 1
                    ? AppAssets.orderIconSelected
                    : AppAssets.orderImg,
                height: 25,
                width: 25,
              ),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 2
                    ? AppAssets.tripIconSelected
                    : AppAssets.tripImg,
                height: 25,
                width: 25,
              ),
              label: 'Trip',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 3
                    ? AppAssets.profileIconSelected
                    : AppAssets.profileImg,
                height: 25,
                width: 25,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,

          showUnselectedLabels: true,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFE23744),
        ),
      ),
    );
  }
}

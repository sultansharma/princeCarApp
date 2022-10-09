import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/auth/login.dart';
import 'package:newhandy/dashboard/booking.dart';
import 'package:newhandy/dashboard/chat.dart';
import 'package:newhandy/dashboard/profile.dart';
import 'package:provider/provider.dart';

import 'api_service/provider/mainprovider.dart';
import 'dashboard/home.dart';

class Main_Dashboard extends StatefulWidget {
  @override
  _Main_DashboardState createState() => _Main_DashboardState();
}

class _Main_DashboardState extends State<Main_Dashboard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;
  String _message = '';

  bool new_notification = false;

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Consumer<MainProvider>(
            builder: (_, data, __) => Scaffold(
                  backgroundColor: Colors.white,
                  body: SizedBox.expand(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentIndex = index);
                      },
                      children: <Widget>[
                        HomPage(),
                        BookingPage(),
                        Chat(),
                        ProfilePage()
                      ],
                    ),
                  ),
                  bottomNavigationBar: BottomNavyBar(
                    showElevation: false,
                    selectedIndex: _currentIndex,
                    onItemSelected: (index) {
                      setState(() => _currentIndex = index);
                      _pageController.jumpToPage(index);
                    },
                    items: <BottomNavyBarItem>[
                      btbar("Home", "assets/eye.svg"),
                      btbar("Booking", "assets/calendar.svg"),
                      btbar("Notification", "assets/chat.svg"),
                      btbar("Profile", "assets/user.svg"),
                    ],
                  ),
                )));
  }

  btbar(String title, String svg) {
    return BottomNavyBarItem(
        activeColor: Colors.red,
        textAlign: TextAlign.center,
        title: Text(
          title,
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        icon: SvgPicture.asset(
          svg,
          color: Colors.black,
        ));
  }

  // @override
  // int _selectedPage = 0;
  // List<Widget> pageList = List<Widget>();
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // @override
  // void initState() {
  //   _firebaseMessaging
  //       .subscribeToTopic('users')
  //       .then((value) => print("subscribed"));

  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //     },
  //   );

  //   print("object");
  //   pageList.add(HomPage());
  //   pageList.add(BookingPage());
  //   pageList.add(Chat());
  //   super.initState();
  // }

  // final iconList = <IconData>[
  //   Icons.dashboard,
  //   Icons.assistant_photo,
  //   Icons.account_circle,
  // ];

  // int _currentIndex = 0;
  // void onTabTapped(int index) {
  //   setState(() {
  //     _selectedPage = index;
  //   });
  //   // if (index == 1) {
  //   //   Provider.of<MainProvider>(context, listen: false).fetch_my_matches();
  //   // }
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //       onWillPop: _onWillPop,
  //       child: Scaffold(
  //         body: IndexedStack(
  //           index: _selectedPage,
  //           children: pageList,
  //         ),
  //         bottomNavigationBar: Container(
  //           color: Colors.white,
  //           child: AnimatedBottomNavigationBar(
  //             icons: iconList,
  //             backgroundColor: Colors.white,
  //             activeIndex: _currentIndex,
  //             iconSize: 30,
  //             activeColor: Colors.red,
  //             splashColor: Theme.of(context).accentColor,
  //             inactiveColor: Colors.white,
  //             notchAndCornersAnimation: animation,
  //             splashSpeedInMilliseconds: 500,
  //             onTap: (index) => onTabTapped(index),
  //           ),
  //         ),
  //       ));
  // }

  // void _onItemTapped(int index) {
  //   // Provider.of<ProductsProvider>(context).choose_list_products();
  //   setState(() {
  //     _selectedPage = index;
  //   });
  // }
}

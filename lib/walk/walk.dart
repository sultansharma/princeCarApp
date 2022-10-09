import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/auth/login.dart';
import 'package:newhandy/dashboard.dart';
import 'package:newhandy/dashboard/select_car.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/main.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    //  SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            // decoration: back(),
            child: Center(
              child: Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String userInfo = null;

  startTime() async {
    var d =
        await Provider.of<MainProvider>(context, listen: false).getAppData();
    var _duration = Duration(seconds: 2);
    setState(() {
      userInfo = d;
    });
    return Timer(_duration, navigationPage);
  }

  navigationPage() {
    if (userInfo == "new_user") {
      Get.to(SpalshScreenPages());
    } else if (userInfo == "logged") {
      print("Logged");
      Get.to(Main_Dashboard());
    } else {
      print("Car selected");
      Get.to(Main_Dashboard());
    }
  }

  Widget _buildImage(String assetName) {
    return Container(
      //color: Colors.red,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Stack(
        children: [
          Align(
            child: Image.asset(
              assetName,
              height: 150,
            ),
            alignment: Alignment.bottomCenter,
          ),
          // Align(
          //   child: SvgPicture.asset(assetName),
          //   alignment: Alignment.bottomCenter,
          // )
        ],
      ),
    );
  }
}

class SpalshScreenPages extends StatefulWidget {
  @override
  _SpalshScreenPagesState createState() => _SpalshScreenPagesState();
}

class _SpalshScreenPagesState extends State<SpalshScreenPages> {
  @override
  void initState() {
    super.initState();
    slider();
  }

  void slider() async {
    // await Provider.of<MainProvider>(context, listen: false).homePageSlider();
  }

  final introKey = GlobalKey<IntroductionScreenState>();
  final controller = PageController(viewportFraction: 0.8);

  Widget _buildImage(String assetName) {
    return Container(
      //color: Colors.red,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Stack(
        children: [
          Align(
            child: Image.asset(
              assetName,
              height: 150,
            ),
            alignment: Alignment.bottomCenter,
          ),
          // Align(
          //   child: SvgPicture.asset(assetName),
          //   alignment: Alignment.bottomCenter,
          // )
        ],
      ),
    );
  }

  CustomAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Are you sure want to Exit?",
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () async {
                    exit(0);
                  },
                  child: Text("Yes",
                      style: GoogleFonts.montserrat(color: Colors.red))),
              MaterialButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "No",
                  style: GoogleFonts.montserrat(color: Colors.black),
                ),
              )
            ],
          );
        });
  }

  bool _enabled = true;
  Future<bool> _onBackPressed() {
    CustomAlertDialog(context);
  }

  _onIntroEnd(context) {
    Get.to(Main_Dashboard());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: IntroductionScreen(
        key: introKey,
        pages: [
          // PageViewModel(
          //     titleWidget: Text(
          //       "",
          //     ),
          //     bodyWidget: Text(""),
          //     image: _buildImage(
          //       'assets/BG.svg',
          //     ),
          //     footer: foot(
          //         "Solutions near to you",
          //         "Ensure the most accurate repairs , solutions of problems etc. near to you",
          //         false)),
          PageViewModel(
              titleWidget: Text(""),
              bodyWidget: Text(""),
              image: _buildImage('assets/logo.png'),
              footer: foot(
                  "Book Online",
                  "Easy and convenient online booking for getting rid from problems.",
                  true)),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        animationDuration: 300,
        skip: const Text(''),
        next: const Text(''),
        done: const Text(''),
        dotsDecorator: const DotsDecorator(
          activeColor: Colors.black,
          size: Size(10.0, 10.0),
          color: Colors.grey,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }

  Widget foot(String title, String des, bool button) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => Container(
              width: 500,
              //height: 400,
              //color: Colors.white,
              // height: MediaQuery.of(context).size.height * 0.20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        des,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 17, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  button
                      ? Container(
                          width: 400,
                          //height: 50,
                          child: Column(
                            children: [
                              // InkWell(
                              //   onTap: () {
                              //     Get.to(SelectCity());
                              //   },
                              //   child: Container(
                              //     padding: EdgeInsets.all(8),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Icon(
                              //           Icons.location_on_outlined,
                              //           size: 16,
                              //         ),
                              //         SizedBox(
                              //           width: 5,
                              //         ),
                              //         data.mycity == null
                              //             ? ntext("Select City",
                              //                 clr: Colors.black
                              //                     .withOpacity(0.60))
                              //             : ntext(data.mycity,
                              //                 clr: Colors.black
                              //                     .withOpacity(0.60))
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),

                              SizedBox(
                                height: 30,
                              ),

                              InkWell(
                                onTap: () {
                                  Get.to(SelectCar());
                                },
                                child: mainButton(context, "Select Your Car"),
                              ),
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ));
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/cart/cart.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';

TextEditingController _info = TextEditingController();

class ConfirmBooking extends StatefulWidget {
  final String selectedDate;
  final String selectedTime;
  final String providerName;
  final String rate;
  final String providerImg;
  final String task;

  const ConfirmBooking(
      {Key key,
      this.selectedDate,
      this.selectedTime,
      this.providerName,
      this.rate,
      this.providerImg,
      this.task})
      : super(key: key);

  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: _height,
                child: Stack(
                  children: [
                    Container(
                      height: _height * 0.30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/bg.jpg",
                              ),
                              fit: BoxFit.cover)),
                    ),
                    new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        height: _height * 0.32,
                        color: mainRed,
                      ),
                    ),
                    Container(
                      height: _height * 0.32,
                      color: mainRed,
                    ),
                    Positioned(
                      top: 50,
                      left: 10,
                      right: 10,
                      child: Container(
                        width: _width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.arrow_back)),
                              ],
                            ),
                            SizedBox(
                              height: 55,
                            ),
                            Center(
                              child: titletext(
                                "Service Request",
                                size: 25,
                                clr: Colors.black.withOpacity(0.80),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: _height * 0.26,
                      ),
                      padding: EdgeInsets.all(15),
                      height: _height * 0.72,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0)),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ntext("Task",
                          //     size: 18,
                          //     clr: Colors.black.withOpacity(0.30),
                          //     w: FontWeight.bold),
                          // ntext(
                          //   "Home Clean",
                          //   size: 19,
                          //   clr: Colors.black,
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // ntext("Address",
                          //     size: 18,
                          //     clr: Colors.black.withOpacity(0.30),
                          //     w: FontWeight.bold),
                          // ntext(
                          //   "Home",
                          //   size: 19,
                          //   clr: Colors.black,
                          // ),
                          // ntext(
                          //   "B 121 , Prem Nagar Dhanula road Barnala",
                          //   size: 18,
                          //   clr: Colors.black54,
                          // ),

                          SizedBox(
                            height: 20,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(15.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           ntext(
                          //             "Selected Date",
                          //             size: 18,
                          //             clr: Colors.black.withOpacity(0.30),
                          //           ),
                          //           ntext(
                          //             "22 JUN 2021",
                          //             size: 22,
                          //             clr: Colors.black,
                          //           ),
                          //         ],
                          //       ),
                          //       Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           ntext(
                          //             "Time",
                          //             size: 18,
                          //             clr: Colors.black.withOpacity(0.30),
                          //           ),
                          //           ntext(
                          //             "10:00",
                          //             size: 22,
                          //             clr: Colors.black,
                          //           ),
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Divider(),

                          Padding(
                            padding: EdgeInsets.all(0),
                            child: ntext(
                                "Describe what problem you are facing by uploading some photos and writing some about it",
                                clr: Colors.black87,
                                size: 17),
                          ),
                          // Row(
                          //   children: [
                          //     InkWell(
                          //       onTap: () {
                          //         my_toast("Function is off", "error");
                          //       },
                          //       child: Container(
                          //         margin: EdgeInsets.all(10),
                          //         height: 100,
                          //         width: 100,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(10),
                          //           color: mainColor.withOpacity(0.20),
                          //         ),
                          //         child: Center(
                          //           child: Icon(
                          //             Icons.camera_alt,
                          //             size: 70,
                          //             color: Colors.black.withOpacity(0.10),
                          //           ),
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),

                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: ntext("Write short description",
                                clr: Colors.black, size: 16),
                          ),
                          textFiled("Describe (optional)", _info)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: InkWell(
          onTap: () async {
            Get.to(CartPage());
            Provider.of<MainProvider>(context, listen: false)
                .setInfo(_info.text);
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: mainButton(context, "CONTINUE"),
          ),
        ));
  }
}

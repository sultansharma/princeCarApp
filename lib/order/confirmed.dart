import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/dashboard.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OrderConfirmed extends StatefulWidget {
  final String date;
  final String time;
  final String des;
  final String address;
  const OrderConfirmed({Key key, this.date, this.time, this.des, this.address})
      : super(key: key);
  @override
  _OrderConfirmedState createState() => _OrderConfirmedState();
}

class _OrderConfirmedState extends State<OrderConfirmed> {
  double _height = 0;
  bool _sending = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 1), () async {
      final res = await Provider.of<MainProvider>(context, listen: false)
          .placeOrder(widget.date, widget.time, widget.address);
      print(res.toString());
      if (res == "done") {
        setState(() {
          _sending = false;
          _height = 200;
        });
      } else {
        my_toast("Technical error !", "error");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => Scaffold(
              backgroundColor: Colors.red[50],
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.handyman_sharp,
                              size: 100,
                              color: Colors.red.withOpacity(0.70),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            // _height == 0
                            //     ?
                            _sending
                                ? Shimmer.fromColors(
                                    baseColor: Colors.redAccent,
                                    highlightColor: Colors.white,
                                    child: Text(
                                      "Sending your request",
                                      style:
                                          GoogleFonts.montserrat(fontSize: 18),
                                    ))
                                : Container(),
                            // :
                            AnimatedContainer(
                              padding: EdgeInsets.all(12),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white.withOpacity(0.50),
                              duration: Duration(seconds: 2),
                              curve: Curves.bounceOut,
                              height: _height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ntext("Thanks !",
                                      clr: Colors.green,
                                      size: 20,
                                      w: FontWeight.bold),
                                  ntext("We Recived your request !",
                                      clr: Colors.green, size: 18),
                                  InkWell(
                                    onTap: () {
                                      Get.to(Main_Dashboard());
                                    },
                                    child: Container(
                                        child: mainButton(
                                            context, "Back To Home")),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}

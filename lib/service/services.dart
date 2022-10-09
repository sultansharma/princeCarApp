import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/cart/cart.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/helper/models/categories.dart';
import 'package:newhandy/hire_request/confirm_booking.dart';
import 'package:newhandy/service/service_request.dart';
import 'package:provider/provider.dart';

class Services extends StatefulWidget {
  final String image;
  final String id;
  final String name;

  const Services({Key key, this.image, this.id, this.name}) : super(key: key);
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Consumer<MainProvider>(
        builder: (_, data, __) => Scaffold(
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
                          Container(
                            height: _height * 0.32,
                            color: mainRed,
                          ),
                          Positioned(
                            right: 0,
                            bottom: _height * 0.62,
                            child: Container(
                                //height: _height * 0.22,
                                child: Image.network(
                              widget.image,
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              fit: BoxFit.cover,
                            )),
                          ),
                          new BackdropFilter(
                            filter: new ImageFilter.blur(
                                sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              height: _height * 0.32,
                              color: mainRed,
                            ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      widget.name,
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
                              top: _height * 0.25,
                            ),
                            height: _height * 0.70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0)),
                                color: Colors.grey[200]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: data.service_data == null
                                  ? Container(
                                      height: 300,
                                      child: Center(
                                          child: ntext("Loading",
                                              clr: Colors.black
                                                  .withOpacity(0.70))),
                                    )
                                  : data.service_data.serviceData.length == 0
                                      ? Container(
                                          height: 300,
                                          child: Center(
                                              child: ntext("No Services",
                                                  clr: Colors.black
                                                      .withOpacity(0.70))),
                                        )
                                      : AnimationLimiter(
                                          child: ListView.builder(
                                            itemBuilder: (context, i) {
                                              var d = data
                                                  .service_data.serviceData[i];
                                              return AnimationConfiguration
                                                  .staggeredList(
                                                position: i,
                                                duration: const Duration(
                                                    milliseconds: 375),
                                                child: SlideAnimation(
                                                  verticalOffset: 50.0,
                                                  child: FadeInAnimation(
                                                    child: InkWell(
                                                        onTap: () {
                                                          // Get.to(
                                                          //     ServiceRequestPage());
                                                        },
                                                        child: cartItem(
                                                            context,
                                                            "image",
                                                            d.title,
                                                            d.price,
                                                            d.id,
                                                            "list",
                                                            d.description)),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: data.service_data
                                                .serviceData.length,
                                          ),
                                        ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: data.cart_data != null &&
                      data.cart_data.cartData.items.length != 0
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          //Get.to(CartPage());
                          Get.to(ConfirmBooking());
                        },
                        child: mainButton(
                            context,
                            "₹ " +
                                data.cart_data.cartData.subtotal +
                                " Proceed To Book"),
                      ),
                    )
                  : Container(
                      height: 1,
                    ),
            ));
  }
}

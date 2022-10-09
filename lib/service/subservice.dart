import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/cart/cart.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/helper/models/categories.dart';
import 'package:newhandy/service/service_request.dart';
import 'package:newhandy/service/services.dart';
import 'package:provider/provider.dart';

class SubServicePage extends StatefulWidget {
  final String image;
  final String id;
  final String name;
  final List<Sub> subcats;

  const SubServicePage({Key key, this.image, this.id, this.name, this.subcats})
      : super(key: key);
  @override
  _SubServicePageState createState() => _SubServicePageState();
}

class _SubServicePageState extends State<SubServicePage> {
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
                          ),
                          Positioned(
                            right: 0,
                            bottom: _height * 0.62,
                            child: Container(
                              //height: _height * 0.22,
                              child: Image.network(
                                widget.image,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                              ),
                            ),
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.arrow_back),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
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
                              top: _height * 0.30,
                            ),
                            height: _height * 0.70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0)),
                                color: Colors.grey[200]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: widget.subcats.length == 0
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
                                          var d = widget.subcats[i];
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
                                                      Provider.of<MainProvider>(
                                                              context,
                                                              listen: false)
                                                          .getServices(d.id);
                                                      Get.to(Services(
                                                        name: d.name,
                                                        image: widget.image,
                                                      ));
                                                    },
                                                    child: subServiceItme(
                                                        "image",
                                                        d.name,
                                                        d.startingPrice
                                                            .toString())),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: widget.subcats.length,
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
                          Get.to(CartPage());
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

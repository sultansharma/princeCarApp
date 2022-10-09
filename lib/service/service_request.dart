import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/serviceproviders/provider_list.dart';

class ServiceRequestPage extends StatefulWidget {
  @override
  _ServiceRequestPageState createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  TextEditingController _info = TextEditingController();

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
                      height: _height * 0.27,
                      decoration: BoxDecoration(
                          // image: DecorationImage(
                          //     image: AssetImage(
                          //       "assets/bg.jpg",
                          //     ),
                          //     fit: BoxFit.cover)
                          ),
                    ),
                    Container(
                      height: _height * 0.27,
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
                                Icon(Icons.arrow_back),
                              ],
                            ),
                            SizedBox(
                              height: 55,
                            ),
                            Center(
                              child: ntext(
                                "Service Request",
                                size: 25,
                                clr: Colors.black.withOpacity(0.80),
                              ),
                            ),
                            ntext(
                              "Let us know the problem",
                              size: 15,
                              clr: Colors.black.withOpacity(0.30),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: _height * 0.25,
                      ),
                      padding: EdgeInsets.all(15),
                      height: _height * 0.75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: ntext(
                                "Describe what problem you are facing by uploading some photos and writing some about it",
                                clr: Colors.black87,
                                size: 15),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: mainColor.withOpacity(0.20),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Colors.black.withOpacity(0.10),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: ntext("Write short description",
                                clr: Colors.black, size: 16),
                          ),
                          textFiled("Describe", _info)
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
          onTap: () {
            Get.to(ProvidersPage());
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: mainButton(context, "FIND PROVIDER"),
          ),
        ));
  }
}

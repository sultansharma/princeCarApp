import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/service/service_request.dart';
import 'package:newhandy/serviceproviders/proiderprofile.dart';

class ProvidersPage extends StatefulWidget {
  @override
  _ProvidersPageState createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
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
                    height: _height * 0.17,
                    decoration: BoxDecoration(color: Colors.white),
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
                            height: 15,
                          ),
                          ntext(
                            "Carpet Sahmpooing",
                            size: 25,
                            clr: Colors.black.withOpacity(0.80),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: _height * 0.17,
                    ),
                    height: _height * 0.85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: bgblue),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemBuilder: (context, i) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: AnimationConfiguration.staggeredList(
                                position: i,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: InkWell(
                                        onTap: () {
                                          Get.to(ProviderProfile());
                                        },
                                        child: provider(
                                            "Emili Andrson",
                                            "Cleaner",
                                            "187",
                                            "12",
                                            "4.5",
                                            "img")),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: 5,
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
    );
  }
}

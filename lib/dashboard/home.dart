import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/dashboard/profile.dart';
import 'package:newhandy/dashboard/search.dart';
import 'package:newhandy/dashboard/select_car.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/main.dart';
import 'package:newhandy/service/subservice.dart';
import 'package:provider/provider.dart';

class HomPage extends StatefulWidget {
  @override
  _HomPageState createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Consumer<MainProvider>(
        builder: (_, data, __) => Scaffold(
              backgroundColor: Colors.white,
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: _height - 60,
                      child: Stack(
                        children: [
                          // Container(
                          //     width: _width,
                          //     height: _height * 0.28,
                          //     child: Center(
                          //       child: Container(
                          //           width: 60,
                          //           height: 60,
                          //           decoration: BoxDecoration(
                          //               image: DecorationImage(
                          //                   image: AssetImage(
                          //                     "assets/logo.jpeg",
                          //                   ),
                          //                   fit: BoxFit.cover))),
                          //     )),

                          Container(
                            height: _height * 0.34,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                // stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/logo.png',
                                            width: 100,
                                            //height: 100,
                                          )
                                          // Text(
                                          //   "Prince Cars",
                                          //   style: GoogleFonts.poppins(
                                          //       color: Colors.redAccent,
                                          //       fontSize: 22,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(SelectCar());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        margin: EdgeInsets.only(right: 10),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              data.car_logo,
                                              height: 60,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 25),
                                  padding: EdgeInsets.only(left: 20),
                                  child: ntext(
                                      "What Service you are looking for ?",
                                      clr: Colors.black,
                                      size: 19,
                                      w: FontWeight.w500),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(SearchPage(
                                        name: "Search",
                                      ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: _width * 0.90,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[300]),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.search_outlined,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                                height: 50,
                                                width: 200,
                                                child: TextField(
                                                  onSubmitted: (val) {
                                                    Provider.of<MainProvider>(
                                                            context,
                                                            listen: false)
                                                        .searchServices(val);
                                                    Get.to(SearchPage(
                                                        name:
                                                            "Search - ${val}"));
                                                  },
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Search Service'),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                              top: _height * 0.30,
                            ),
                            height: _height * 0.70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.white),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 10),
                            margin: EdgeInsets.only(
                              top: _height * 0.30,
                            ),
                            height: _height * 0.62,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.grey[200]),
                            child: gridlist(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget gridlist() {
    return Consumer<MainProvider>(
        builder: (_, data, __) => Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: data.cat_data == null
                    ? Container(
                        height: 300,
                        child: Center(child: Text("Loading..")),
                      )
                    : Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        runSpacing: 15,
                        spacing: 5,
                        children: List.generate(
                            data.cat_data.categoriesData.length, (i) {
                          var d = data.cat_data.categoriesData[i];
                          return InkWell(
                              onTap: () {
                                Get.to(SubServicePage(
                                  id: d.id,
                                  image: d.image,
                                  name: d.name,
                                  subcats: d.sub,
                                ));
                              },
                              child: service(d.name, d.image, d.id));
                        })),
              ),
            ));
  }

  Widget service(
    String name,
    String image,
    String id,
  ) {
    var w = (MediaQuery.of(context).size.width - 3 * (3 - 1)) / 3;
    return Stack(
      children: [
        Container(
          width: w - 20,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          //height: MediaQuery.of(context).size.width * 0.33,
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: image,
                child: Container(
                  key: Key(image),
                  height: 50,
                  margin: EdgeInsets.only(top: 8, bottom: 0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.contain),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 10, color: Colors.black),
              )
            ],
          ),
        ),

        // Container(
        //   width: w - 20,
        //   padding: EdgeInsets.all(8),
        //   height: MediaQuery.of(context).size.width * 0.30,
        //   decoration: BoxDecoration(
        //       //  borderRadius: BorderRadius.circular(10),
        //       // boxShadow: [
        //       //   BoxShadow(
        //       //       color: Colors.lightBlue[50], blurRadius: 8, spreadRadius: 3)
        //       // ],
        //       // border: Border.all(color: Colors.lightBlue[50]),
        //       color: Colors.white),
        //   child: Stack(
        //     //crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [

        //     ],
        //   ),
        // )
      ],
    );
  }
}

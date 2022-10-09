import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/hire_request/confirm_booking.dart';
import 'package:intl/intl.dart';

class ProviderProfile extends StatefulWidget {
  @override
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  String selected_date = null;
  String selected_time = null;
  Color selected_color = Colors.blue[100].withOpacity(0.70);

  ScrollController _controller;
  bool silverCollapsed = false;
  String myTitle = "";
  Color appbarColor = Colors.blue[100];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();

    _controller.addListener(() {
      if (_controller.offset > 180 && !_controller.position.outOfRange) {
        if (!silverCollapsed) {
          // do what ever you want when silver is collapsing !

          myTitle = "Emili Anderson";
          silverCollapsed = true;
          appbarColor = Colors.white;
          setState(() {});
        }
      }
      if (_controller.offset <= 180 && !_controller.position.outOfRange) {
        if (silverCollapsed) {
          // do what ever you want when silver is expanding !

          myTitle = "";
          silverCollapsed = false;
          appbarColor = Colors.blue[100];
          setState(() {});
        }
      }
    });
  }

  void _editBottomSheet(context, String myob) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                color: Colors.white,
                height: 300,
                // height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: ntext("Select Date & Time",
                          clr: Colors.grey, size: 17),
                    ),
                    Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          var currDt = DateTime.now();
                          var d =
                              currDt.add(Duration(days: i + 1)).day.toString();
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selected_color = Colors.green;
                                selected_date = d;
                                print(selected_date);
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),

                              curve: Curves.bounceOut,
                              margin: EdgeInsets.only(left: 10),
                              // padding: EdgeInsets.all(10),
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selected_date == d
                                      ? selected_color
                                      : Colors.blue[100].withOpacity(0.60)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ntext(
                                        currDt
                                            .add(Duration(days: i + 1))
                                            .day
                                            .toString(),
                                        clr: selected_date == d
                                            ? Colors.white
                                            : Colors.black,
                                        size: 20),
                                    ntext(
                                        DateFormat.E()
                                            .format(currDt
                                                .add(Duration(days: i + 1)))
                                            .toString(),
                                        clr: selected_date == d
                                            ? Colors.white
                                            : Colors.black,
                                        size: 13)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 7,
                      ),
                    ),
                    Container(
                      height: 55,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          var time = 09;
                          var ii = 1;
                          var d = (time + i).toString() + ".00";
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selected_color = Colors.green;
                                selected_time = d;
                                print(selected_time);
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.only(left: 10),
                              duration: Duration(seconds: 1),

                              curve: Curves.bounceOut,
                              // padding: EdgeInsets.all(10),
                              width: 120,
                              decoration: BoxDecoration(
                                color: selected_time == d
                                    ? selected_color
                                    : Colors.blue[100].withOpacity(0.70),
                                borderRadius: BorderRadius.circular(8),
                                // color: Colors.blue[100].withOpacity(0.60)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ntext((time + i).toString() + ".00",
                                        clr: selected_time == d
                                            ? Colors.white
                                            : Colors.black,
                                        size: 18),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 9,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(ConfirmBooking());
                      },
                      child: mainButton(context, "CONTINUE"),
                    )
                  ],
                ),
              ));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        backgroundColor: Colors.blue[100],
        body: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverAppBar(
              pinned: true,
              leading: Icon(Icons.arrow_back),
              collapsedHeight: 60,
              expandedHeight: 200,
              title: Text(
                myTitle,
                style: GoogleFonts.montserrat(
                    color: Colors.black.withOpacity(0.80)),
              ),
              backgroundColor: appbarColor,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ntext("Emili Anderson",
                          clr: Colors.black, size: 22, w: FontWeight.bold),
                      ntext("Cleaner", clr: Colors.grey),
                      Divider(),
                      ntext(
                          "AM very hard worker , We are Professionals , We clean your house ",
                          clr: Colors.black87),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            column("Jobs", "187"),
                            column("Rate", "12.55 / hr"),
                            column("Rating", "4.5")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ntext('Work Protfolio',
                        clr: Colors.grey, size: 18, w: FontWeight.bold),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 120,
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return Container(
                            width: 200,
                            height: 100,
                            margin: EdgeInsets.only(left: 10),
                            color: Colors.grey[100],
                          );
                        },
                        itemCount: 5,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: review("Peter", "12-01-21", "imag", 12,
                  "I Am very satisfied from his work , He is very hard worker , I will recomend you"),
            ),
            SliverToBoxAdapter(
              child: review("Andrson", "12-01-21", "imag", 12,
                  "I love his work , I will hire him again, I Am very satisfied from his work , He is very hard worker , I will recomend you"),
            ),
            SliverToBoxAdapter(
              child: review("Peter", "12-01-21", "imag", 12,
                  "I Am very satisfied from his work , He is very hard worker , I will recomend you"),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () {
            _editBottomSheet(context, "myob");
            // Get.to(ProvidersPage());
          },
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(0),
            child: mainButton(context, "HIRE REQUEST"),
          ),
        ),
      ),
    );
  }

  Widget review(String name, String date, String imag, int star, String cmt) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: mainColor.withOpacity(0.30),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ntext(name, clr: Colors.black, size: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ntext(date, clr: Colors.grey),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ntext(cmt, clr: Colors.black),
          )
        ],
      ),
    );
  }
}

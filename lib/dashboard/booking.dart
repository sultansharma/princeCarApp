import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/auth/login.dart';
import 'package:newhandy/booking/booking_details.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String selectedTab = "Upcoming";
  double _bwidth = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => RefreshIndicator(
              onRefresh: () async {
                final res =
                    await Provider.of<MainProvider>(context, listen: false)
                        .getBookings();
                return res;
              },
              child: Scaffold(
                backgroundColor: Colors.red[50].withOpacity(0.20),
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      centerTitle: false,
                      title: ntext(
                        "Booking",
                        size: 18,
                        w: FontWeight.w500,
                        clr: Colors.black.withOpacity(0.80),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              tabbar("Upcoming", true),
                              tabbar("Completed", false),
                              tabbar("Cancelled", false)
                            ],
                          )),
                    ),
                    // SliverToBoxAdapter(
                    //   child: Expanded(
                    //     child: ListView.builder(
                    //       itemBuilder: (context, i) {
                    //         return Container(color: Colors.red, height: 150.0);
                    //       },
                    //       itemCount: 5,
                    //     ),
                    //   ),
                    // )
                    data.booking_data == null
                        ? SliverToBoxAdapter(
                            child: InkWell(
                              onTap: () {
                                Get.to(Login());
                              },
                              child: Container(
                                  height: 300,
                                  child: Center(
                                    child: ntext("Login To Get Data",
                                        clr: Colors.black.withOpacity(0.70)),
                                  )),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate((context, i) {
                            var d = selectedTab == "Completed"
                                ? data.booking_data.allBookings.comBookings[i]
                                : selectedTab == "Cancelled"
                                    ? data
                                        .booking_data.allBookings.canBookings[i]
                                    : data.booking_data.allBookings
                                        .penBookings[i];
                            return InkWell(
                              onTap: () async {
                                Get.to(BookingData(
                                  id: d.id.toString(),
                                ));
                                Provider.of<MainProvider>(context,
                                        listen: false)
                                    .getBooking(d.id);
                              },
                              child: booking(
                                  d.provider == null
                                      ? "Not Assigned"
                                      : d.provider.name,
                                  d.service,
                                  d.date.toString(),
                                  d.status,
                                  "img"),
                            );
                          },
                                childCount: selectedTab == "Completed"
                                    ? data.booking_data.allBookings.comBookings
                                        .length
                                    : selectedTab == "Cancelled"
                                        ? data.booking_data.allBookings
                                            .canBookings.length
                                        : data.booking_data.allBookings
                                            .penBookings.length)),
                  ],
                ),
              ),
            ));
  }

  Widget tabbar(String title, bool active) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = title;
          _bwidth = 2.0;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 3),
        margin: EdgeInsets.only(left: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 2.0,
                  color: selectedTab == title ? Colors.red : Colors.white)),
        ),
        child: ntext(title,
            clr: selectedTab == title
                ? mainColor
                : Colors.black.withOpacity(0.70),
            size: 15,
            w: FontWeight.w500),
      ),
    );
  }
}

// class PresistentHeader extends SliverPersistentHeaderDelegate {
//   final Widget widget;

//   PresistentHeader(this.widget);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

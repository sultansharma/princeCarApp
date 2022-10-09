import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/booking/payment_page.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BookingData extends StatefulWidget {
  final String id;

  const BookingData({Key key, this.id}) : super(key: key);
  @override
  _BookingDataState createState() => _BookingDataState();
}

class _BookingDataState extends State<BookingData> {
  Future<void> getData() async {
    Provider.of<MainProvider>(context, listen: false).getBooking(widget.id);
    return "data";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => RefreshIndicator(
              onRefresh: getData,
              child: Scaffold(
                backgroundColor: Colors.grey[50],
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: true,
                      iconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: Colors.white,
                      centerTitle: false,
                      title: ntext(
                        "Booking data - #" + widget.id,
                        size: 18,
                        w: FontWeight.w500,
                        clr: Colors.black.withOpacity(0.80),
                      ),
                    ),
                    data.b_data == null
                        ? SliverList(
                            delegate: SliverChildListDelegate([
                            l_request_tile(true),
                            l_provider_tile(false),
                            l_estimate_tile(false),

                            // work_canceled(true)
                          ]))
                        : SliverList(
                            delegate: SliverChildListDelegate([
                            request_tile(true),
                            provider_tile(
                                data.b_data.bookingData.providerName == "no"
                                    ? false
                                    : true),
                            estimate_tile(
                                data.b_data.bookingData.estimatedCost == "0"
                                    ? false
                                    : true),
                            final_tile(
                                data.b_data.bookingData.estimatedCost == "0"
                                    ? false
                                    : true),
                            work_completed(
                                data.b_data.bookingData.status == "COMPLETED"
                                    ? true
                                    : false,
                                data.b_data.bookingData.completedOn)
                            // work_canceled(true)
                          ])),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 150,
                      ),
                    )
                  ],
                ),
                bottomSheet: data.b_data == null
                    ? Container(
                        height: 3,
                      )
                    : SolidBottomSheet(
                        maxHeight: 200,
                        headerBar: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Container(
                                    width: 100,
                                    color: Colors.grey[300],
                                    height: 5,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: mainColor.withOpacity(0.60),
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ntext(data.b_data.bookingData.service,
                                          clr: Colors.black.withOpacity(0.70),
                                          size: 17),
                                      Container(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/calendar.svg',
                                            color: mainColor,
                                            height: 17,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ntext(
                                              data.b_data.bookingData.bookingOn
                                                  .toString(),
                                              clr: Colors.black
                                                  .withOpacity(0.70)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        body: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ntext("Address",
                                    size: 16,
                                    clr: Colors.grey.withOpacity(0.50),
                                    w: FontWeight.bold),
                                ntext(
                                  data.b_data.bookingData.address +
                                      "\n" +
                                      data.u_data.data.city +
                                      " , " +
                                      data.u_data.data.country,
                                  size: 16,
                                  clr: Colors.black.withOpacity(0.60),
                                ),
                                Divider(),
                                ntext("Remark",
                                    size: 16,
                                    clr: Colors.grey.withOpacity(0.50),
                                    w: FontWeight.bold),
                                ntext(
                                  data.b_data.bookingData.remark.toString(),
                                  size: 16,
                                  clr: Colors.black.withOpacity(0.60),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                bottomNavigationBar: data.b_data == null
                    ? Container(
                        height: 2,
                      )
                    : InkWell(
                        onTap: () {
                          if (data.b_data.bookingData.finalCost == "0") {
                            my_toast(
                                "Let Him to complete whole work !", "wait");
                          } else {
                            Get.to(PaymentPage());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 60,
                          color: data.b_data.bookingData.status == "COMPLETED"
                              ? Colors.green
                              : Colors.red,
                          child: Center(
                            child: ntext(data.b_data.bookingData.finalCost ==
                                    "0"
                                ? "Under Working"
                                : data.b_data.bookingData.status == "COMPLETED"
                                    ? "Completed"
                                    : "Proceed to pay"),
                          ),
                        ),
                      ),
              ),
            ));
  }

  Widget request_tile(bool done) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => TimelineTile(
              axis: TimelineAxis.vertical,
              hasIndicator: true,
              isFirst: true,
              alignment: TimelineAlign.start,
              endChild: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    color: Colors.white),
                //  height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ntext("Booking request sent",
                        clr: Colors.black.withOpacity(0.80),
                        w: FontWeight.w500),
                    SizedBox(
                      height: 5,
                    ),
                    ntext("Requested on : " + data.b_data.bookingData.bookingOn,
                        clr: Colors.grey),
                    SizedBox(
                      height: 5,
                    ),
                    ntext("Requested for : " + data.b_data.bookingData.date,
                        clr: Colors.grey),
                    SizedBox(
                      height: 5,
                    ),
                    ntext(
                        "Remark : " + data.b_data.bookingData.remark.toString(),
                        clr: Colors.grey)
                  ],
                ),
              ),
              beforeLineStyle: LineStyle(thickness: 6),
              afterLineStyle: LineStyle(color: Colors.red),
              indicatorStyle: IndicatorStyle(
                  color: Colors.red, width: 20, padding: EdgeInsets.all(10)),
            ));
  }

  Widget l_request_tile(bool done) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.red[50],
      child: TimelineTile(
        axis: TimelineAxis.vertical,
        hasIndicator: true,
        isFirst: true,
        alignment: TimelineAlign.start,
        endChild: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          decoration: BoxDecoration(boxShadow: [
            // BoxShadow(
            //     blurRadius: 2, color: Colors.black12, spreadRadius: 2)
          ], color: Colors.white),
          //  height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ntext("Booking request sent",
                  clr: Colors.black.withOpacity(0.80), w: FontWeight.w500),
              SizedBox(
                height: 5,
              ),
              ntext("requested on 21-Feb-2021", clr: Colors.grey)
            ],
          ),
        ),
        beforeLineStyle: LineStyle(thickness: 6),
        afterLineStyle: LineStyle(color: Colors.green),
        indicatorStyle: IndicatorStyle(
            color: Colors.green, width: 20, padding: EdgeInsets.all(10)),
      ),
    );
  }

  Widget l_provider_tile(bool done) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.red[50],
      child: TimelineTile(
        axis: TimelineAxis.vertical,
        hasIndicator: true,
        isFirst: false,
        alignment: TimelineAlign.start,
        endChild: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.black12, spreadRadius: 2)
          ], color: Colors.white),
          //  height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ntext(done ? "Provider Assigned" : "No Provider assigned yet",
                  clr: done ? Colors.green : Colors.black.withOpacity(0.80),
                  w: FontWeight.w500),
              SizedBox(
                height: 5,
              ),
              done
                  ? ntext("On 21-Feb-2021", clr: Colors.grey)
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 15,
                      color: Colors.grey[100],
                    ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              done
                  ? assigned_provider(
                      context,
                      "name",
                      "service",
                      "jobs",
                      "rate",
                      "rating",
                      "phone",
                      "center_lat",
                      "center_log",
                      "img",
                      "userid")
                  : providerLoading()
            ],
          ),
        ),
        beforeLineStyle: LineStyle(thickness: 4),
        afterLineStyle: LineStyle(color: done ? Colors.green : Colors.grey),
        indicatorStyle: IndicatorStyle(
            color: done ? Colors.green : Colors.grey,
            width: 20,
            padding: EdgeInsets.all(10)),
      ),
    );
  }

  Widget l_estimate_tile(bool done) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.red[50],
      child: TimelineTile(
        axis: TimelineAxis.vertical,
        hasIndicator: true,
        isFirst: false,
        alignment: TimelineAlign.start,
        endChild: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.black12, spreadRadius: 2)
          ], color: Colors.white),
          //  height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ntext(
                      done ? "Cost Estimated by mechanic" : "Not yet estimated",
                      clr: done ? Colors.green : Colors.black.withOpacity(0.80),
                      w: FontWeight.w500),
                  ntext(done ? "₹ " + "1232" : "", clr: Colors.green, size: 17)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              done
                  ? ntext("On 21-Feb-2021", clr: Colors.grey)
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 15,
                      color: Colors.grey[100],
                    ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(5),
                child: done
                    ? ntext(
                        "There are some other issues , Which makes its total approx cost to 1232",
                        clr: Colors.grey[400])
                    : Container(
                        margin: EdgeInsets.symmetric(vertical: 1),
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: 35,
                        color: Colors.grey[100],
                      ),
              )
            ],
          ),
        ),
        beforeLineStyle: LineStyle(thickness: 4),
        afterLineStyle: LineStyle(color: done ? Colors.green : Colors.grey),
        indicatorStyle: IndicatorStyle(
            color: done ? Colors.green : Colors.grey,
            width: 20,
            padding: EdgeInsets.all(10)),
      ),
    );
  }

  Widget provider_tile(bool done) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => TimelineTile(
              axis: TimelineAxis.vertical,
              hasIndicator: true,
              isFirst: false,
              alignment: TimelineAlign.start,
              endChild: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    color: Colors.white),
                //  height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ntext(
                        done ? "Location Assigned" : "No Location assigned yet",
                        clr: done
                            ? Colors.green
                            : Colors.black.withOpacity(0.80),
                        w: FontWeight.w500),
                    SizedBox(
                      height: 5,
                    ),
                    done
                        ? ntext(data.b_data.bookingData.providerOn,
                            clr: Colors.grey)
                        : Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 15,
                            color: Colors.grey[100],
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    done
                        ? assigned_provider(
                            context,
                            data.b_data.bookingData.providerName,
                            data.b_data.bookingData.service,
                            "jobs",
                            "rate",
                            "rating",
                            data.b_data.bookingData.providerPhone,
                            "img",
                            data.b_data.bookingData.spId,
                            data.b_data.bookingData.providerLat,
                            data.b_data.bookingData.providerLong)
                        : providerLoading()
                  ],
                ),
              ),
              beforeLineStyle: LineStyle(
                  thickness: 4, color: done ? Colors.red : Colors.grey),
              afterLineStyle: LineStyle(color: done ? Colors.red : Colors.grey),
              indicatorStyle: IndicatorStyle(
                  color: done ? Colors.red : Colors.grey,
                  width: 20,
                  padding: EdgeInsets.all(10)),
            ));
  }

  Widget estimate_tile(bool done) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => TimelineTile(
              axis: TimelineAxis.vertical,
              hasIndicator: true,
              isFirst: false,
              alignment: TimelineAlign.start,
              endChild: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    color: Colors.white),
                //  height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ntext(
                            done
                                ? "Cost Estimated by mechanic"
                                : "Not yet estimated",
                            clr: done
                                ? Colors.black.withOpacity(0.80)
                                : Colors.black.withOpacity(0.80),
                            w: FontWeight.w500),
                        ntext(
                            done
                                ? "₹ " + data.b_data.bookingData.estimatedCost
                                : "",
                            clr: Colors.green,
                            size: 17)
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    done
                        ? ntext(data.b_data.bookingData.eDate, clr: Colors.grey)
                        : Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 15,
                            color: Colors.grey[100],
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: done
                          ? ntext(
                              "There are some other issues , Which makes its total approx cost to " +
                                  data.b_data.bookingData.estimatedCost,
                              clr: Colors.grey[400])
                          : Container(
                              margin: EdgeInsets.symmetric(vertical: 1),
                              width: MediaQuery.of(context).size.width * 0.70,
                              height: 35,
                              color: Colors.grey[100],
                            ),
                    )
                  ],
                ),
              ),
              beforeLineStyle: LineStyle(
                  thickness: 4, color: done ? Colors.red : Colors.grey),
              afterLineStyle: LineStyle(color: done ? Colors.red : Colors.grey),
              indicatorStyle: IndicatorStyle(
                  color: done ? Colors.red : Colors.grey,
                  width: 20,
                  padding: EdgeInsets.all(10)),
            ));
  }

  Widget final_tile(bool done) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => TimelineTile(
              axis: TimelineAxis.vertical,
              hasIndicator: true,
              isFirst: false,
              alignment: TimelineAlign.start,
              endChild: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    color: Colors.white),
                //  height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ntext(done ? "Final Cost" : "Not yet",
                            clr: done
                                ? Colors.black.withOpacity(0.80)
                                : Colors.black.withOpacity(0.80),
                            w: FontWeight.w500),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ntext(
                                done
                                    ? "₹ " + data.b_data.bookingData.finalCost
                                    : "",
                                clr: Colors.green,
                                size: 17),
                            SizedBox(
                              width: 5,
                            ),
                            // InkWell(
                            //     onTap: () {
                            //       // if (data.b_data.bookingData.isFinalEdited ==
                            //       //     "1") {
                            //       //   my_toast(
                            //       //       "Now Edit is not possible !", "wait");
                            //       // } else {
                            //       //   Get.to(SubmitFin());
                            //       // }
                            //     },
                            //     child: Icon(Icons.edit, size: 18))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    done
                        ? ntext(data.b_data.bookingData.eDate, clr: Colors.grey)
                        : Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 15,
                            color: Colors.grey[100],
                          ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              beforeLineStyle: LineStyle(
                  thickness: 4, color: done ? Colors.red : Colors.grey),
              afterLineStyle: LineStyle(color: done ? Colors.red : Colors.grey),
              indicatorStyle: IndicatorStyle(
                  color: done ? Colors.red : Colors.grey,
                  width: 20,
                  padding: EdgeInsets.all(10)),
            ));
  }

  Widget work_started() {}

  Widget work_completed(bool done, String date) {
    return TimelineTile(
      axis: TimelineAxis.vertical,
      hasIndicator: true,
      isFirst: false,
      isLast: true,
      alignment: TimelineAlign.start,
      endChild: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black12, spreadRadius: 2)
        ], color: Colors.white),
        //  height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ntext(done ? "Completed" : "In progress",
                clr: Colors.black.withOpacity(0.80), w: FontWeight.w500),
            SizedBox(
              height: 5,
            ),
            done
                ? ntext("On " + date.toString(), clr: Colors.grey)
                : Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 15,
                    color: Colors.grey[100],
                  ),
          ],
        ),
      ),
      beforeLineStyle:
          LineStyle(thickness: 4, color: done ? Colors.green : Colors.grey),
      afterLineStyle: LineStyle(color: Colors.green),
      indicatorStyle: IndicatorStyle(
          color: done ? Colors.green : Colors.grey,
          width: 20,
          padding: EdgeInsets.all(10)),
    );
  }

  Widget work_canceled(bool done, String date) {
    return TimelineTile(
      axis: TimelineAxis.vertical,
      hasIndicator: true,
      isFirst: false,
      isLast: true,
      alignment: TimelineAlign.start,
      endChild: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black12, spreadRadius: 2)
        ], color: Colors.white),
        //  height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ntext("Cancelled", clr: Colors.redAccent, w: FontWeight.w500),
            SizedBox(
              height: 5,
            ),
            ntext("On " + date.toString(), clr: Colors.grey)
          ],
        ),
      ),
      beforeLineStyle:
          LineStyle(thickness: 4, color: done ? Colors.green : Colors.grey),
      afterLineStyle: LineStyle(color: Colors.green),
      indicatorStyle: IndicatorStyle(
          color: done ? Colors.green : Colors.grey,
          width: 20,
          padding: EdgeInsets.all(10)),
    );
  }
}

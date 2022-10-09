import 'package:flutter/material.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => Scaffold(
              backgroundColor: Colors.grey[50],
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    // automaticallyImplyLeading: true,
                    iconTheme: IconThemeData(color: Colors.black, size: 12),
                    backgroundColor: Colors.white,
                    centerTitle: false,
                    leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 20,
                      ),
                    ),
                    title: ntext(
                      "Payment Data",
                      size: 18,
                      w: FontWeight.w500,
                      clr: Colors.black.withOpacity(0.80),
                    ),
                  ),
                  data.b_data == null
                      ? SliverToBoxAdapter(
                          child: Center(
                              child: Container(
                                  height: 300, child: Text("Loading.."))))
                      : payData(),
                  data.b_data == null
                      ? SliverToBoxAdapter(child: Text(""))
                      : payStatus()
                ],
              ),
              bottomNavigationBar: data.b_data == null
                  ? Container(
                      height: 20,
                    )
                  : data.b_data.bookingData.finalPayType == "no"
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 60,
                          color:
                              _paymethod == null ? Colors.red[100] : Colors.red,
                          child: InkWell(
                            onTap: () async {
                              if (_loading) {
                              } else {
                                if (_paymethod == "Cash") {
                                  setState(() {
                                    _loading = true;
                                  });
                                  final res = await Provider.of<MainProvider>(
                                          context,
                                          listen: false)
                                      .submitPayment(
                                          data.b_data.bookingData.id.toString(),
                                          (int.parse(data.b_data.bookingData
                                                      .finalCost) -
                                                  int.parse(data.b_data
                                                      .bookingData.intpaid))
                                              .toString(),
                                          "unpaid",
                                          "cash");
                                  if (res == "done") {
                                    setState(() {
                                      _loading = false;
                                    });
                                  } else {
                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                } else {
                                  my_toast("Paying Online", "success");
                                }
                              }
                            },
                            child: Container(
                              child: Center(
                                  child: ntext(
                                      _loading ? "Loading.." : "Pay Now",
                                      clr: Colors.white)),
                            ),
                          ),
                        )
                      : Container(
                          height: 20,
                          child: Text(""),
                        ),
            ));
  }

  bool _loading = false;
  Widget payData() {
    return Consumer<MainProvider>(
        builder: (_, data, __) => SliverToBoxAdapter(
              child: Container(
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
                    ntext("Service Payment Data",
                        clr: Colors.black.withOpacity(0.80),
                        w: FontWeight.w500),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    _row("Booking ID",
                        data.b_data == null ? "-" : data.b_data.bookingData.id,
                        type: "text"),
                    SizedBox(
                      height: 5,
                    ),
                    _row(
                        "Estimated Cost",
                        data.b_data == null
                            ? "-"
                            : data.b_data.bookingData.estimatedCost.toString()),
                    SizedBox(
                      height: 5,
                    ),
                    _row(
                        "Final Cost",
                        data.b_data == null
                            ? "-"
                            : data.b_data.bookingData.finalCost.toString()),
                    SizedBox(
                      height: 5,
                    ),
                    _row(
                        "Initial Paid",
                        data.b_data == null
                            ? "-"
                            : data.b_data.bookingData.intpaid.toString()),
                    SizedBox(
                      height: 5,
                    ),
                    _row(
                        "Payable Amount",
                        (int.parse(data.b_data.bookingData.finalCost) -
                                int.parse(data.b_data.bookingData.intpaid))
                            .toString(),
                        clr: Colors.green),
                  ],
                ),
              ),
            ));
  }

  String _paymethod = null;

  Widget payStatus() {
    return Consumer<MainProvider>(
        builder: (_, data, __) => SliverToBoxAdapter(
              child: Container(
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
                        ntext("Choose Payment method",
                            clr: Colors.black.withOpacity(0.80),
                            w: FontWeight.w500),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    data.b_data.bookingData.finalPayType == "no"
                        ? Center(
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _button("Cash"),

                              // _button("Online")
                            ],
                          ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _row("Payment method",
                                  data.b_data.bookingData.finalPayType,
                                  type: "text"),
                              SizedBox(
                                height: 5,
                              ),
                              _row(
                                "Amount",
                                (int.parse(data.b_data.bookingData.finalCost) -
                                        int.parse(
                                            data.b_data.bookingData.intpaid))
                                    .toString(),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              _row(
                                  "Status",
                                  data.b_data.bookingData.isPaid == "0"
                                      ? "Unpaid"
                                      : "Paid",
                                  type: "text"),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ));
  }

  Widget _button(String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _paymethod = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _paymethod == title ? Colors.red : Colors.white,
            border: Border.all(
                color: _paymethod == title ? Colors.red : Colors.black)),
        child: Center(
          child: ntext(title,
              clr: _paymethod == title ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _row(String title, String data, {Color clr, String type}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ntext(title, clr: Colors.black),
        ntext(type == "text" ? "" + data : "₹ " + data, clr: clr ?? Colors.grey)
      ],
    );
  }
}

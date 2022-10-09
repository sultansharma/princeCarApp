import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/order/confirmed.dart';
import 'package:newhandy/payment/stripe.dart';
import 'package:newhandy/profile/manage.dart';
import 'package:provider/provider.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String selected_date = null;
  String selected_time = null;
  String full_date = null;
  Color selected_color = Colors.blue[100].withOpacity(0.70);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                height: 280,
                // height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: ntext("Select Date & Time",
                          clr: Colors.grey, size: 16),
                    ),
                    Container(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          var currDt = DateTime.now();
                          var d = currDt.add(Duration(days: i + 1));
                          ;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selected_color = Colors.redAccent;
                                selected_date = d.day.toString();
                                full_date = '${d.day}-${d.month}-${d.year}';
                                print(full_date);
                                print(selected_date);
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),

                              curve: Curves.bounceOut,
                              margin: EdgeInsets.only(left: 10),
                              // padding: EdgeInsets.all(10),
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selected_date == d.day.toString()
                                      ? selected_color
                                      : Colors.grey[100].withOpacity(0.60)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ntext(
                                        currDt
                                            .add(Duration(days: i + 1))
                                            .day
                                            .toString(),
                                        clr: selected_date == d.day.toString()
                                            ? Colors.white
                                            : Colors.black,
                                        size: 17),
                                    ntext(
                                        DateFormat.E()
                                            .format(currDt
                                                .add(Duration(days: i + 1)))
                                            .toString(),
                                        clr: selected_date == d.day.toString()
                                            ? Colors.white
                                            : Colors.black,
                                        size: 11)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 10,
                      ),
                    ),
                    Container(
                      height: 50,
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
                                selected_color = Colors.redAccent;
                                selected_time = d;
                                print(selected_time);
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.only(left: 10),
                              duration: Duration(seconds: 1),

                              curve: Curves.bounceOut,
                              // padding: EdgeInsets.all(10),
                              width: 100,
                              decoration: BoxDecoration(
                                color: selected_time == d
                                    ? selected_color
                                    : Colors.grey[100].withOpacity(0.70),
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
                                        size: 15),
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
                        Get.to(OrderConfirmed(
                          date: full_date,
                          time: selected_time,
                        ));
                      },
                      child: mainButton(context, "CONTINUE"),
                    ),
                  ],
                ),
              ));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => Scaffold(
              backgroundColor: Colors.grey[200],
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    centerTitle: false,
                    title: ntext(
                      "Cart",
                      size: 18,
                      w: FontWeight.w500,
                      clr: Colors.black.withOpacity(0.80),
                    ),
                  ),
                  data.cart_data.cartData.items.length != 0
                      ? SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.50))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ntext("Address",
                                          size: 16,
                                          clr: Colors.black.withOpacity(0.90),
                                          w: FontWeight.w500),
                                      InkWell(
                                        onTap: () {
                                          Get.to(ManageAccount());
                                        },
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit_location_outlined,
                                                color: Colors.redAccent,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              ntext("EDIT",
                                                  clr: Colors.black
                                                      .withOpacity(0.70),
                                                  size: 13)
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ntext(
                                    data.u_data.data.address +
                                        "\n" +
                                        data.u_data.data.city.toString() +
                                        " , " +
                                        data.u_data.data.country.toString(),
                                    size: 16,
                                    clr: Colors.black.withOpacity(0.50),
                                  ),
                                  // Divider(
                                  //   color: Colors.lightBlue,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     ntext("Date & Time",
                                  //         size: 16,
                                  //         clr: Colors.black.withOpacity(0.70),
                                  //         w: FontWeight.w500),
                                  //     InkWell(
                                  //       onTap: () {
                                  //         _editBottomSheet(context, "myob");
                                  //       },
                                  //       child: Container(
                                  //         child: Row(
                                  //           children: [
                                  //             Icon(
                                  //               Icons.timer,
                                  //               color: Colors.lightBlue,
                                  //               size: 16,
                                  //             ),
                                  //             SizedBox(
                                  //               width: 5,
                                  //             ),
                                  //             ntext("EDIT",
                                  //                 clr: Colors.black
                                  //                     .withOpacity(0.70),
                                  //                 size: 13)
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SliverToBoxAdapter(),
                  data.cart_data.cartData.items.length == 0
                      ? SliverToBoxAdapter(child: Container())
                      : SliverToBoxAdapter(
                          child: _describe(),
                        ),
                  data.cart_data == null
                      ? SliverToBoxAdapter(
                          child: Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.engineering_rounded,
                                    size: 100,
                                    color: Colors.lightBlue.withOpacity(0.50),
                                  ),
                                  ntext("Refresh now",
                                      clr: Colors.black.withOpacity(0.70))
                                ],
                              ),
                            ),
                          ),
                        )
                      : data.cart_data.cartData.items.length == 0
                          ? SliverToBoxAdapter(
                              child: Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.child_care_outlined,
                                        size: 100,
                                        color:
                                            Colors.lightBlue.withOpacity(0.50),
                                      ),
                                      ntext("No Items",
                                          clr: Colors.black.withOpacity(0.70))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : _cartItems(),
                ],
              ),
              bottomSheet: SolidBottomSheet(
                maxHeight: 200,
                headerBar: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ntext("Total Amount :",
                              clr: Colors.black.withOpacity(0.90),
                              w: FontWeight.w600),
                          ntext(
                              "₹ " +
                                  data.cart_data.cartData.subtotal.toString(),
                              clr: Colors.black.withOpacity(0.90),
                              w: FontWeight.w600)
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
                        rowText("Visit Charges ",
                            data.cart_data.cartData.visit.toString()),
                        Divider(),
                        rowText("Initial Charges ",
                            data.cart_data.cartData.initialPay),
                        Divider(),
                        rowText("Tax ", data.cart_data.cartData.tax.toString()),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: ntext(
                                "* Total Amount is a rough estimation, Actual amount will be deside after the visit of service provider",
                                clr: Colors.black.withOpacity(0.60)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: data.cart_data.cartData.items.length != 0
                  ? InkWell(
                      onTap: () {
                        //Get.to(Stripe());
                        // if (full_date == null || selected_time == null) {
                        _editBottomSheet(context, "myob");
                        //my_toast("Please Select date and time !", "error");
                        // } else {
                        // Get.to(OrderConfirmed(
                        //   date: full_date,
                        //   time: selected_time,
                        //   des: _info.text.toString(),
                        // ));
                        // }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 60,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ntext("Proceed to book"),
                            ntext("₹ " + data.cart_data.cartData.initialPay)
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
            ));
  }

  Widget _cartItems() {
    return Consumer<MainProvider>(
        builder: (_, data, __) => SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
              var d = data.cart_data.cartData.items[i];
              return cartItem(
                  context,
                  "image",
                  d.serviceName + " - " + d.providerType,
                  d.amount,
                  d.id,
                  "cart",
                  d.description);
            }, childCount: data.cart_data.cartData.items.length)));
  }

  Widget rowText(String title, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ntext(
          title,
          clr: Colors.black.withOpacity(0.70),
        ),
        ntext(
          "₹ " + val,
          clr: Colors.black.withOpacity(0.70),
        )
      ],
    );
  }

  Widget _describe() {
    return Consumer<MainProvider>(
        builder: (_, data, __) => Container(
              margin: EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: ntext("Remarks",
                        size: 16,
                        clr: Colors.black.withOpacity(0.70),
                        w: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: ntext(data.des.toString(), clr: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ));
  }
}

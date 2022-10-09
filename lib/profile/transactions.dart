import 'package:flutter/material.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
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
                      "Transactions",
                      size: 22,
                      w: FontWeight.bold,
                      clr: Colors.black.withOpacity(0.80),
                    ),
                  ),
                  data.trans_data == null
                      ? SliverToBoxAdapter(
                          child: Container(
                            height: 100,
                            child: Center(
                              child: Text("Loading"),
                            ),
                          ),
                        )
                      : data.trans_data.transactions.length == 0
                          ? SliverToBoxAdapter(
                              child: Container(
                                height: 100,
                                child: Center(
                                  child: Text("No Transactions Yet"),
                                ),
                              ),
                            )
                          : SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, i) {
                              var d = data.trans_data.transactions[i];
                              return tran(d.amount, d.transactionFor,
                                  d.createdAt, d.serviceId, "type");
                            }, childCount: data.trans_data.transactions.length))
                ],
              ),
            ));
  }

  Widget tran(
      String amount, String paidfor, String date, String payfor, String type) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ntext(paidfor,
                  clr: Colors.black.withOpacity(0.70), w: FontWeight.w500),
              SizedBox(
                height: 8,
              ),
              ntext(payfor, clr: Colors.grey.withOpacity(0.70)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ntext("₹ " + amount,
                  clr: type == "add"
                      ? Colors.green.withOpacity(0.70)
                      : Colors.red.withOpacity(0.70),
                  w: FontWeight.w500),
              SizedBox(
                height: 8,
              ),
              ntext(
                date,
                size: 13,
                clr: Colors.grey.withOpacity(0.60),
              ),
            ],
          )
        ],
      ),
    );
  }
}

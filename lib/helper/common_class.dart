import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatefulWidget {
  final String id;

  const AddToCart({Key key, this.id}) : super(key: key);

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => loading
            ? Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 1.0,
                ),
              )
            : data.cart_data != null &&
                    data.cart_data.cartData.items
                        .map((e) => e.serviceId)
                        .contains(widget.id)
                ? InkWell(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      final res = await Provider.of<MainProvider>(context,
                              listen: false)
                          .removeFromCart(data.cart_data.cartData.items
                              .toList()
                              .firstWhere(
                                  (element) => element.serviceId == widget.id)
                              .id);
                      if (res == "done") {
                        setState(() {
                          loading = false;
                        });
                      } else {
                        my_toast("Technical error", "error");
                        loading = false;
                      }
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  )
                : data.cart_data == null
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.deepOrange,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  blurRadius: 4.0,
                                  spreadRadius: 4)
                            ]),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            final res = await Provider.of<MainProvider>(context,
                                    listen: false)
                                .addToCart(widget.id);
                            if (res == "done") {
                              setState(() {
                                loading = false;
                              });
                            } else {
                              my_toast("Technical error in adding !", "error");
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text("ADD",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white)),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(Icons.add, size: 15, color: Colors.white)
                            ],
                          ),
                        ),
                      ));
  }
}

class CartListItem extends StatefulWidget {
  final String id;

  const CartListItem({Key key, this.id}) : super(key: key);

  @override
  _CartListItemState createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => loading
            ? Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 1.0,
                ),
              )
            : InkWell(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final res =
                      await Provider.of<MainProvider>(context, listen: false)
                          .removeFromCart(widget.id);
                  if (res == "done") {
                    setState(() {
                      loading = false;
                    });
                  } else {
                    my_toast("Technical error", "error");
                    loading = false;
                  }
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ));
  }
}

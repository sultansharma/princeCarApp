import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/auth/login.dart';
import 'package:newhandy/chat/chat_screen.dart';
import 'package:newhandy/helper/common_class.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Widget appBar() {
  return AppBar();
}

ntext(String text, {Color clr, double size, FontWeight w}) {
  return Text(text,
      style: GoogleFonts.montserrat(
          fontSize: size ?? 15,
          color: clr ?? Colors.white,
          fontWeight: w ?? FontWeight.normal));
}

titletext(String text, {Color clr, double size, FontWeight w}) {
  return Text(text,
      style: GoogleFonts.montserrat(
          fontSize: size ?? 15,
          color: clr ?? Colors.white,
          fontWeight: w ?? FontWeight.bold));
}

mainSliverButton(BuildContext ctx, String text, {Function fct, Color clr}) {
  return SliverToBoxAdapter(
    child: Container(
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(20)),
      height: 50,
      child: Center(
        child: ntext("CONTINUE"),
      ),
    ),
  );
}

mainButton(BuildContext ctx, String text, {Function fct, Color clr}) {
  return Container(
    margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
    decoration: BoxDecoration(
        color: Colors.redAccent, borderRadius: BorderRadius.circular(30)),
    height: 50,
    child: Center(
      child: ntext(
        text,
        w: FontWeight.w300,
      ),
    ),
  );
}

textFiled(String lable, TextEditingController cont, {bool s}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: TextField(
        controller: cont,
        obscureText: s ?? false,
        style: GoogleFonts.montserrat(
          fontSize: 15,
          color: Colors.black.withOpacity(0.70),
        ),
        decoration: InputDecoration(
          hintText: lable,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 15,
            color: Colors.grey,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey,
          )),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        )),
  );
}

textFiledSignup(String lable, String key, {bool s}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: TextField(
        obscureText: s ?? false,
        style: GoogleFonts.montserrat(
          fontSize: 15,
          color: Colors.black.withOpacity(0.70),
        ),
        onChanged: (val) {
          key = val;
          print("Val" + key);
        },
        decoration: InputDecoration(
          hintText: lable,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 15,
            color: Colors.grey,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey,
          )),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        )),
  );
}

class MyVerticalText extends StatelessWidget {
  final String text;

  const MyVerticalText(this.text);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //runSpacing: 30,
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      children: text
          .split("")
          .map((string) =>
              Text(string, style: TextStyle(fontSize: 22, letterSpacing: 20)))
          .toList(),
    );
  }
}
////////////////////////CART/////////////////////////////

Widget cartItem(BuildContext ctx, String image, String name, String price,
    String id, String type, String about) {
  return Consumer<MainProvider>(
      builder: (_, data, __) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ntext(name,
                                  clr: Colors.black.withOpacity(0.80),
                                  w: FontWeight.w500),
                              type == "list"
                                  ? data.u_data == null
                                      ? _button()
                                      : AddToCart(
                                          id: id,
                                        )
                                  : CartListItem(
                                      id: id,
                                    )
                              //addToCart(ctx, id)
                            ],
                          ),
                          Text(" ₹ " + price,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w300)),
                          Divider(),
                          ntext(about, clr: Colors.black.withOpacity(0.90)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ));
}

Widget _button() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey[200], blurRadius: 4.0, spreadRadius: 4)
        ]),
    child: InkWell(
      onTap: () async {
        my_toast("Please Login First !", "error");
        Get.to(Login());
      },
      child: Row(
        children: [
          Text("ADD"),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.add,
            size: 15,
          )
        ],
      ),
    ),
  );
}

Widget addToCart(BuildContext context, String id) {
  return Consumer<MainProvider>(
      builder: (_, data, __) => data.adding == id
          ? Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 4.0,
                        spreadRadius: 4)
                  ]),
              child: data.cart_data == null
                  ? Text("")
                  : data.cart_data.cartData.items
                          .map((e) => e.serviceId)
                          .contains(id)
                      ? Text("added")
                      : InkWell(
                          onTap: () {
                            Provider.of<MainProvider>(context, listen: false)
                                .setToCart(id);
                          },
                          child: Row(
                            children: [
                              Text("ADD"),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.add,
                                size: 15,
                              )
                            ],
                          ),
                        ),
            ));
}

Widget subServiceItme(String image, String name, String price) {
  return Container(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    decoration: BoxDecoration(
        color: Colors.white, border: Border.all(color: Colors.grey[300])),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Container(
                //   margin: EdgeInsets.only(right: 15),
                //   child: CircleAvatar(
                //     radius: 27,
                //     backgroundColor: mainRed.withOpacity(0.20),
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ntext(name, size: 17, clr: Colors.black.withOpacity(0.90)),
                    SizedBox(
                      height: 5,
                    ),
                    ntext("₹ " + price + " Onwards",
                        clr: Colors.black, size: 14, w: FontWeight.w300)
                  ],
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 18,
            )
          ],
        ),
      ],
    ),
  );
}

Widget provider(String name, String service, String jobs, String rate,
    String rating, String img) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ntext(name, clr: Colors.black, size: 18),
              ntext(service, clr: Colors.grey),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
        Container(
          height: 70,
          width: 70,
          color: Colors.grey[200],
          child: Center(child: Text("image")),
        )
      ],
    ),
  );
}

Widget booking(
    String name, String service, String date, String status, String img) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.grey[200], blurRadius: 8, spreadRadius: 3)
      ],
      border: Border.all(color: Colors.black.withOpacity(0.30)),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ntext(name, clr: Colors.black, size: 16),
              ntext(service, clr: Colors.grey),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/calendar.svg',
                      color: mainColor,
                    ),
                    ntext(date, clr: Colors.black.withOpacity(0.70)),
                    ntext(status, clr: Colors.lightBlue)
                  ],
                ),
              )
            ],
          ),
        ),
        // Container(
        //   height: 70,
        //   width: 70,
        //   color: Colors.grey[200],
        //   child: Center(child: Text("image")),
        // )
      ],
    ),
  );
}

Widget column(String name, String value) {
  return Column(
    children: [ntext(name, clr: Colors.grey), ntext(value, clr: Colors.black)],
  );
}

Widget assigned_provider(
    BuildContext context,
    String name,
    String service,
    String jobs,
    String rate,
    String rating,
    String phone,
    String center_lat,
    String caenter_log,
    String img,
    String userid) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    padding: EdgeInsets.all(0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ntext(name, clr: Colors.black, size: 15),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 18,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              launch(
                                "https://www.google.com/maps?saddr=My+Location&daddr=$caenter_log,$center_lat",
                                forceSafariVC: false,
                                forceWebView: false,
                                headers: <String, String>{
                                  'my_header_key': 'my_header_value'
                                },
                              );

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (_) => ChatScreen(
                              //           name: name,
                              //           rid: userid,
                              //         )));
                              // Provider.of<MainProvider>(context, listen: false)
                              //     .findChat(userid);
                            },
                            child: Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.deepOrange,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.green, size: 15),
                        SizedBox(
                          width: 5,
                        ),
                        ntext(phone.toString(), clr: Colors.green, size: 13)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // Container(
        //   height: 50,
        //   width: 50,
        //   margin: EdgeInsets.only(left: 10),
        //   color: Colors.grey[100],
        //   child: Center(child: Text("")),
        // )
      ],
    ),
  );
}

Widget providerLoading() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 100,
                height: 15,
                color: Colors.grey[100],
              ),
              Divider(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 200,
                height: 15,
                color: Colors.green[100],
              )
            ],
          ),
          Container(
            height: 50,
            width: 50,
            color: Colors.grey[50],
          )
        ],
      )
    ],
  );
}

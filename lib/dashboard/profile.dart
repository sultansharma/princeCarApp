import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/auth/login.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/profile/changepassword.dart';
import 'package:newhandy/profile/manage.dart';
import 'package:newhandy/profile/transactions.dart';
import 'package:newhandy/serviceproviders/proiderprofile.dart';
import 'package:newhandy/walk/walk.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ScrollController _controller;
  bool silverCollapsed = false;
  String myTitle = "";
  Color appbarColor = Colors.red[100];
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
          setState(() {
            myTitle = "Emili Anderson";
            silverCollapsed = true;
            appbarColor = Colors.white;
          });
        }
      }
      if (_controller.offset <= 180 && !_controller.position.outOfRange) {
        if (silverCollapsed) {
          // do what ever you want when silver is expanding !

          myTitle = "";
          silverCollapsed = false;
          appbarColor = Colors.red[100];
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Consumer<MainProvider>(
      builder: (_, data, __) => CustomScrollView(
        slivers: [
          data.u_data == null
              ? SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  centerTitle: false,
                  title: ntext(
                    "Profile",
                    size: 18,
                    w: FontWeight.w500,
                    clr: Colors.black.withOpacity(0.80),
                  ),
                )
              : SliverToBoxAdapter(),
          data.u_data == null
              ? SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () {
                      Get.to(Login());
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height - 160,
                      child: Center(
                        child: mainButton(context, "Login"),
                      ),
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Container(
                    height: _height,
                    child: Stack(
                      children: [
                        Container(
                          height: _height * 0.30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/bg.jpg",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          height: _height * 0.32,
                          color: Colors.red[100].withOpacity(0.90),
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
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     InkWell(
                                //         onTap: () {
                                //           Navigator.pop(context);
                                //         },
                                //         child: Icon(Icons.arrow_back)),
                                //   ],
                                // ),
                                SizedBox(
                                  height: 45,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          titletext(
                                            data.u_data.data.name,
                                            size: 22,
                                            w: FontWeight.w500,
                                            clr: Colors.black.withOpacity(0.80),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          titletext(
                                            "+91 " +
                                                data.u_data.data.phone
                                                    .toString(),
                                            size: 18,
                                            clr: Colors.black.withOpacity(0.40),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          my_toast(
                                              "Change image feature not working in test mode",
                                              "error");
                                        },
                                        child: Container(
                                          child: CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Colors.red,
                                            child: CircleAvatar(
                                              radius: 33,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                "https://images.unsplash.com/photo-1497551060073-4c5ab6435f12?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=734&q=80",
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                              top: _height * 0.30,
                            ),
                            height: _height * 0.12,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.redAccent),
                            child: InkWell(
                              onTap: () {
                                data.getTransactions();
                                Get.to(TransactionsPage());
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: _height * 0.02),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                height: _height * 0.10,
                                // color: Colors.red,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.wallet_giftcard,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ntext("Wallet",
                                                size: 17, w: FontWeight.w300),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ntext(
                                                "₹ " +
                                                    data.u_data.data.balance
                                                        .toString(),
                                                size: 18,
                                                w: FontWeight.w500),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.only(
                            top: _height * 0.40,
                          ),
                          height: _height * 0.62,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: ListView(
                            children: [
                              _links("Manage Account", "Manage your data",
                                  Icons.account_circle,
                                  fn: ManageAccount()),
                              _links("Change Password", "Change your password",
                                  Icons.lock,
                                  fn: ChangePassword()),
                              _links("Contact us", "Send your quries",
                                  Icons.email),
                              // _links("Privacy Policy", "Know our policy",
                              //     Icons.notes_rounded),
                              InkWell(
                                onTap: () async {
                                  await data.logout();
                                  Get.to(SplashScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        size: 30,
                                        color: Colors.redAccent,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ntext("Logout",
                                              clr: Colors.black
                                                  .withOpacity(0.70)),
                                          ntext("Switch account",
                                              clr:
                                                  Colors.grey.withOpacity(0.70))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    ));
  }

  Widget _links(String title, String subtitle, dynamic icon, {Widget fn}) {
    return InkWell(
      onTap: () {
        Get.to(fn);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.redAccent,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ntext(title, clr: Colors.black.withOpacity(0.70)),
                ntext(subtitle, clr: Colors.grey.withOpacity(0.70))
              ],
            )
          ],
        ),
      ),
    );
  }
}

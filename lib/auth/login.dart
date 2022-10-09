import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/auth/signup.dart';
import 'package:newhandy/dashboard.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double _awidth = 0;
  bool loading = false;
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    void getTo() {
      print("object");
      Get.to(Main_Dashboard());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<MainProvider>(
        builder: (_, data, __) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: _height,
                child: Stack(
                  children: [
                    // Container(
                    //   height: _height * 0.43,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: AssetImage(
                    //             "assets/mainbg.jpg",
                    //           ),
                    //           fit: BoxFit.cover)),
                    // ),
                    Container(
                      height: _height * 0.43,
                      color: Colors.grey[100],
                    ),
                    Container(
                      width: _width,
                      height: _height * 0.43,
                      // height: _width * 0.20,
                      child: Center(
                        child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/logo.png",
                                    ),
                                    fit: BoxFit.cover))),
                      ),
                    ),
                    Positioned(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: _height * 0.41),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: ntext("Sign in now",
                                  clr: Colors.black, size: _width * 0.05),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Padding(
                          //     padding: EdgeInsets.all(10),
                          //     child: ntext(
                          //       "Phone Number",
                          //       clr: Colors.black.withOpacity(0.80),
                          //       size: _width * 0.05,
                          //     )),

                          textFiled("Enter Phone Number", phonenumber),
                          textFiled("Password", password, s: true)
                        ],
                      ),
                    )),
                    Positioned(
                        bottom: _height * 0.18,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            final res = await Provider.of<MainProvider>(context,
                                    listen: false)
                                .login(phonenumber.text, password.text);
                            if (res != "error") {
                              setState(() {
                                loading = false;
                              });
                              Get.to(Main_Dashboard());
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                            //  Get.to(Main_Dashboard());
                          },
                          child: Container(
                            width: _width,
                            child: Center(
                              child: Container(
                                  child: mainButton(context,
                                      loading ? "LOADING.." : "CONTINUE")),
                            ),
                          ),
                        )),
                    Positioned(
                        bottom: _height * 0.13,
                        child: InkWell(
                          onTap: () {
                            Get.to(Signup());
                          },
                          child: Container(
                            width: _width,
                            child: Center(
                                child:
                                    ntext("Sign Up", clr: mainColor, size: 16)),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: _height * 0.07,
      //   decoration: BoxDecoration(
      //       color: mainColor,
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       ntext("Facebook"),
      //       Container(
      //         margin: EdgeInsets.symmetric(vertical: 25),
      //         width: 0.5,
      //         color: Colors.white,
      //       ),
      //       ntext("Google")
      //     ],
      //   ),
      // ),
    );
  }
}

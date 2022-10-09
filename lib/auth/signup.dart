import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/dashboard.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  double _awidth = 0;
  bool loading = false;
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    void getTo() {
      print("object");
      Get.to(Main_Dashboard());
    }

    return Consumer<MainProvider>(
        builder: (_, data, __) => Scaffold(
              backgroundColor: Colors.white,
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: _height,
                      child: Stack(
                        children: [
                          Container(
                            height: _height * 0.30,
                            color: Colors.grey[100],
                          ),
                          Container(
                            width: _width,
                            height: _height * 0.30,
                            // height: _width * 0.20,
                            child: Center(
                              child: Container(
                                  width: 90,
                                  height: 90,
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
                            margin: EdgeInsets.only(top: _height * 0.25),
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
                                    child: ntext("Sign up now",
                                        clr: mainColor, size: _width * 0.05),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // Padding(
                                //     padding: EdgeInsets.all(10),
                                //     child: ntext(
                                //       "Phone Number",
                                //       clr: Colors.black.withOpacity(0.80),
                                //       size: _width * 0.05,
                                //     )),
                                textFiled("Enter Phone Number", phonenumber),
                                textFiled("Email Id", email),
                                textFiled("Name", name),
                                textFiled("Password", password),
                                textFiled("Confirm Password", cpassword,
                                    s: true),
                              ],
                            ),
                          )),
                          Positioned(
                              bottom: 50,
                              child: InkWell(
                                onTap: () async {
                                  // setState(() {
                                  //   _awidth = _awidth == 0 ? 170 : 0;
                                  // });
                                  setState(() {
                                    loading = true;
                                  });
                                  //Get.to(Main_Dashboard());
                                  final res = await data.signup(
                                      phonenumber.text,
                                      password.text,
                                      name.text,
                                      city.text,
                                      email.text);
                                  setState(() {
                                    loading = false;
                                  });
                                  if (res == "done") {
                                    print("done");
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  width: _width,
                                  child: Center(
                                    child: AnimatedContainer(
                                        duration: Duration(seconds: 1),
                                        width: _awidth == 0 ? _width : _awidth,
                                        child: mainButton(
                                          context,
                                          loading ? "PLEASE WAIT." : "CONTINUE",
                                        )),
                                  ),
                                ),
                              )),
                          Positioned(
                              top: 50,
                              left: 20,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}

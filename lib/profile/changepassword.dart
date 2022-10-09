import 'package:flutter/material.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController old = TextEditingController();
    TextEditingController newp = TextEditingController();
    TextEditingController conp = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: false,
            title: ntext(
              "Change Password",
              size: 18,
              w: FontWeight.w500,
              clr: Colors.black.withOpacity(0.80),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Column(
                children: [
                  textFiled("Old Password", old),
                  textFiled("New Password", newp),
                  textFiled("Confirm Password", conp, s: true),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 60,
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              if (newp.text != conp.text) {
                my_toast("Passwords are missmatched !", "error");
              } else {
                setState(() {
                  _loading = true;
                });
                final res =
                    await Provider.of<MainProvider>(context, listen: false)
                        .updatePassword(old.text, newp.text);

                if (res != "error") {
                  setState(() {
                    _loading = false;
                  });
                  my_toast("Password has been changed", "done");
                } else {
                  setState(() {
                    _loading = false;
                  });
                  my_toast("Old password is wrong !", "error");
                }
              }

              //  Get.to(Main_Dashboard());
            },
            child: Container(
              child: Center(
                child: Container(
                    child: mainButton(
                        context, _loading ? "LOADING.." : "CHANGE PASSWORD")),
              ),
            ),
          )),
    );
  }
}

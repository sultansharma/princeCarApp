import 'package:flutter/material.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:provider/provider.dart';

class ManageAccount extends StatefulWidget {
  @override
  _ManageAccountState createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    var u = Provider.of<MainProvider>(context).u_data;
    TextEditingController name = TextEditingController(text: u.data.name);
    TextEditingController phone = TextEditingController(text: u.data.phone);
    TextEditingController address = TextEditingController(text: u.data.address);
    TextEditingController city = TextEditingController(text: u.data.city);
    TextEditingController country = TextEditingController(text: u.data.country);
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
              "Manage Profile",
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
                  textFiled("Your Name", name),
                  textFiled("Your Phonenumber", phone),
                  textFiled("Full Address", address),
                  textFiled("City", city),
                  textFiled("Country", country),
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
              setState(() {
                _loading = true;
              });
              final res =
                  await Provider.of<MainProvider>(context, listen: false)
                      .updateProfile(
                          name.text, address.text, city.text, country.text);

              if (res != "error") {
                setState(() {
                  _loading = false;
                });
                my_toast("Profile Updated", "done");
              } else {
                setState(() {
                  _loading = false;
                });
              }
              //  Get.to(Main_Dashboard());
            },
            child: Container(
              child: Center(
                child: Container(
                    child: mainButton(
                        context, _loading ? "LOADING.." : "CONTINUE")),
              ),
            ),
          )),
    );
  }
}

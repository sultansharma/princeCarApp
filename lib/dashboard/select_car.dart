import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhandy/api_service/provider/mainprovider.dart';
import 'package:newhandy/dashboard.dart';
import 'package:newhandy/helper/common_widgets.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/helper/models/cars.dart';
import 'package:provider/provider.dart';

class SelectCar extends StatefulWidget {
  @override
  _SelectCarState createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  String _selected = null;

  void _editBottomSheet(context, List<Cars> allcars) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: mainColor,
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
                  height: MediaQuery.of(context).size.height / 5,
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Center(
                          child: ntext("Select Car",
                              w: FontWeight.bold, clr: Colors.black),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                var d = allcars[i];
                                return InkWell(
                                  onTap: () {
                                    print(i.toString());

                                    Navigator.pop(context);
                                    _editVariantSheet(context);
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .setCarName(
                                            d.name, d.id, d.logo, d.brandId);
                                  },
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      margin: EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey[400])),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            d.logo,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Positioned(
                                              bottom: 1,
                                              child: Container(
                                                width: 80,
                                                child: Center(
                                                  child: ntext(d.name,
                                                      size: 10,
                                                      clr: Colors.black),
                                                ),
                                              ))
                                        ],
                                      )),
                                );
                              },
                              itemCount: allcars.length,
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 20,
                          color: Colors.transparent)
                    ],
                  )));
        });
      },
    );
  }

  void _editVariantSheet(context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: mainColor,
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
                  height: MediaQuery.of(context).size.height / 4,
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Center(
                          child: ntext("Select Car Variant",
                              w: FontWeight.bold, clr: Colors.black),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _variant("Petrol"),
                                _variant("Diesel"),
                                _variant("CNG")
                              ],
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 20,
                          color: Colors.transparent)
                    ],
                  )));
        });
      },
    );
  }

  Widget _variant(String name) {
    return InkWell(
      onTap: () {
        Get.to(Main_Dashboard());
        Provider.of<MainProvider>(context, listen: false).setCarVariant(name);
      },
      child: Container(
          height: 100,
          width: 100,
          margin: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.grey[400])),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            width: 80,
            child: Center(
              child:
                  ntext(name, size: 15, clr: Colors.black, w: FontWeight.bold),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Consumer<MainProvider>(
        builder: (_, data, __) => Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    centerTitle: false,
                    title: ntext(
                      "Select Car",
                      size: 18,
                      w: FontWeight.w500,
                      clr: Colors.black.withOpacity(0.80),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(10),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var d = data.cars_data.brandData[index];
                          return InkWell(
                            onTap: () {
                              _editBottomSheet(context, d.cars);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey[400])),
                              // padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.25,
                              // height: MediaQuery.of(context).size.width * 0.25,
                              child: Center(
                                child: Image.network(
                                  d.logo,
                                  key: Key(d.logo),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: data.cars_data.brandData.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _city(String name, String id) {
    return Consumer<MainProvider>(
        builder: (_, data, __) => InkWell(
              onTap: () async {
                Provider.of<MainProvider>(context, listen: false)
                    .setCity(name, id);
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 2),
                color: Colors.white,
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ntext(name,
                        clr: data.mycity == name
                            ? Colors.green
                            : Colors.black.withOpacity(0.60)),
                    data.mycity == name
                        ? Icon(
                            Icons.location_on,
                            size: 18,
                            color: Colors.green,
                          )
                        : Text("")
                  ],
                ),
              ),
            ));
  }
}

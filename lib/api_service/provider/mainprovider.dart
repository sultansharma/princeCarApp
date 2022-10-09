import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:newhandy/helper/constant.dart';
import 'package:newhandy/helper/models/booking/allbookings.dart';
import 'package:newhandy/helper/models/booking/booking_details.dart';
import 'package:newhandy/helper/models/cars.dart';
import 'package:newhandy/helper/models/cart/cart.dart';
import 'package:newhandy/helper/models/categories.dart';
import 'package:newhandy/helper/models/chatDataModel.dart';
import 'package:newhandy/helper/models/cites.dart';
import 'package:newhandy/helper/models/conversationModel.dart';
import 'package:newhandy/helper/models/servicebysubcat.dart';
import 'package:newhandy/helper/models/transactions.dart';
import 'package:newhandy/helper/models/userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class MainProvider with ChangeNotifier {
  MainProvider() {
    getAppData();
  }

  deviceToken() {
    _firebaseMessaging.getToken().then((value) {
      print("Token:---" + value);
      updateToken(value);
    });
  }

  updateToken(String token) async {
    var body = {
      "id": u_data.data.id.toString(),
      "device_token": token,
    };
    final res = await postRequest("user/updateToken", body);
    if (res != "error") {
      print("Saved");
    } else {
      my_toast("Technical error !", "error");
    }
  }

  Cites city_data = null;

  getCites() async {
    print("getting cites");
    final res = await getRequest("city");
    if (res != "error") {
      dynamic data = Cites.fromJson(res);
      city_data = data;
      notifyListeners();
    } else {
      my_toast("Technical error in getting cities", "error");
    }
  }

  int version_code;

  getAppData() async {
    //If version is good then Auto Login
    final _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString("userId") != null) {
      //User Logged
      await login(
          _prefs.getString("userPhone"), _prefs.getString("userPassword"));
      car_id = _prefs.getString("selectedCarId");
      car_brand_id = _prefs.getString("selectedCarBrandId");
      car_logo = _prefs.getString("selectedCarLogo");
      car_variant = _prefs.getString("selectedCarVariant");
      notifyListeners();
      print(_prefs.getString("selectedCarName"));
      getCars();
      return "logged";
    } else {
      //Not Logged
      //check car selected or not
      if (_prefs.getString("selectedCarVariant") != null) {
        // Car selected -- Load Categories
        car_name = await _prefs.getString("selectedCarName");
        car_id = _prefs.getString("selectedCarId");
        car_brand_id = _prefs.getString("selectedCarBrandId");
        car_logo = _prefs.getString("selectedCarLogo");
        car_variant = _prefs.getString("selectedCarVariant");
        notifyListeners();
        print(_prefs.getString("selectedCarName"));
        getCars();

        return "car_selected_no_logged";
      } else {
        getCars();
        return "new_user";
      }
    }
    //get Selected Cars
    //getMyCity();
  }

  CarsData cars_data = null;
  getCars() async {
    print("getting cites");
    final res = await getRequest("car/brands/");
    if (res != "error") {
      dynamic data = CarsData.fromJson(res);
      cars_data = data;
      notifyListeners();
      getCategories("3");
    } else {
      my_toast("Technical error in getting cars data", "error");
    }
  }

  String car_id = null;
  String car_name = null;
  String car_logo = null;
  String car_brand = null;
  String car_variant = null;
  String car_brand_id = null;

  setCarName(String name, String id, String logo, String brandId) async {
    print("setting car data");
    car_name = name;
    car_id = id;
    car_logo = logo;
    car_brand_id = brandId;
    notifyListeners();
    print("CAR BRAND ID" + brandId);
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString("selectedCarName", name);
    _prefs.setString("selectedCarId", id);
    _prefs.setString("selectedCarLogo", logo);
    _prefs.setString("selectedCarBrandId", brandId);
  }

  setCarVariant(String varint) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString("selectedCarVariant", varint);
    car_variant = varint;
    notifyListeners();
  }

  String mycity = null;
  String city_id = null;
  getMyCity() async {
    final _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString("selectedCity") != null) {
      mycity = _prefs.getString("selectedCity");
      city_id = _prefs.getString("selectedCityId");
      notifyListeners();
      getCategories(city_id);
      return mycity;
    } else {
      return "no";
    }
  }

  setCity(String city, String id) async {
    mycity = city;
    city_id = id;
    notifyListeners();
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString("selectedCity", city);
    _prefs.setString("selectedCityId", id);
    getCategories(city_id);
  }

  String des = null;
  setInfo(String info) async {
    des = info;
    notifyListeners();
  }

  //Transactions

  TransactionsModel trans_data = null;

  getTransactions() async {
    trans_data = null;
    notifyListeners();
    print("getting categories");
    final res = await getRequest("transactions?user_id=" + u_data.data.id);
    if (res != "error") {
      dynamic data = TransactionsModel.fromJson(res);
      trans_data = data;
      notifyListeners();
    } else {
      my_toast("Technical error in getting transaction data", "error");
    }
  }

  ////////////////////////AUTH/////////////////////////
  UserData u_data = null;
  login(String username, String password) async {
    final _prefs = await SharedPreferences.getInstance();
    var body = {"phone": username, "password": password};
    final res = await postRequest("login", body);
    if (res['status'] != "fail") {
      dynamic data = UserData.fromJson(res);

      u_data = data;

      notifyListeners();
      _prefs.setString("userId", u_data.data.id);
      _prefs.setString("userPhone", username);
      _prefs.setString("userPassword", password);
      await getcart();
      await getBookings();
      await deviceToken();
      return "done";
    } else {
      my_toast(res['data'], "error");
      print(res);
      return "error";
    }
  }

  signup(String username, String password, String name, String city,
      String email) async {
    var body = {
      "phone": username,
      "password": password,
      "email": email,
      "city": "no",
      "utype": "customer",
      "name": name
    };
    print(body.toString());
    final res = await postRequest("signup", body);
    print(res.toString());
    if (res['status'] != "fail") {
      my_toast("Signup Done !, Please login", "done");
      return "done";
    } else {
      my_toast("Error -" + res['data'], "error");
    }
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    return true;
  }

  updateProfile(
      String name, String address, String city, String country) async {
    var body = {
      "id": u_data.data.id.toString(),
      "name": name,
      "address": address,
      "city": city,
      "country": country
    };
    final res = await postRequest("update", body);
    if (res != "error") {
      if (res['status'] != "fail") {
        dynamic data = UserData.fromJson(res);
        u_data = data;
        notifyListeners();
        return "done";
      } else {
        my_toast("Error in updating data", "error");
        return "error";
      }
    } else {
      my_toast("Technical error !", "error");
    }
  }

  updatePassword(String password, String newpassword) async {
    var body = {
      "id": u_data.data.id.toString(),
      "password": password,
      "new_password": newpassword,
    };
    final res = await postRequest("password/create", body);
    if (res != "error") {
      if (res['status'] != "fail") {
        return "done";
      } else {
        return "error";
      }
    } else {
      my_toast("Technical error !", "error");
    }
  }

  ////////////////////////CATEGORIES///////////////////
  CatData cat_data = null;

  getCategories(String city_id) async {
    print("getting categories");
    final res = await getRequest("category/all/bycity?city_id=$city_id");
    if (res != "error") {
      dynamic data = CatData.fromJson(res);
      cat_data = data;
      notifyListeners();
    } else {
      my_toast("Technical error in getting agent data", "error");
    }
  }

  ServicesBySubCat service_data = null;

  getServices(String id) async {
    service_data = null;
    notifyListeners();
    print(car_brand_id);
    final res =
        await getRequest("category/service/byid?id=$id&brand_id=$car_brand_id");
    if (res != "error") {
      dynamic data = ServicesBySubCat.fromJson(res);
      service_data = data;
      notifyListeners();
    } else {
      my_toast("Technical error in getting agent data", "error");
    }
  }

  ServicesBySubCat search_service_data = null;

  searchServices(String search) async {
    search_service_data = null;
    notifyListeners();
    final res = await getRequest("search/services?keyword=${search}");
    if (res != "error") {
      dynamic data = ServicesBySubCat.fromJson(res);
      search_service_data = data;
      notifyListeners();
    } else {
      my_toast("Technical error in getting search data", "error");
    }
  }

  ///////////CART///////////////
  String adding = "0";
  setToCart(String id) {
    adding = id;
    notifyListeners();
    addToCart(id);
  }

  MyCart cart_data = null;

  getcart() async {
    final res = await getRequest("cart/?user_id=" + u_data.data.id.toString());
    if (res != "error") {
      dynamic data = MyCart.fromJson(res);
      cart_data = data;
      notifyListeners();

      adding = "0";
      notifyListeners();
    } else {
      my_toast("Technical error in getting cart data", "error");
    }
  }

  addToCart(String id) async {
    print("ADDING TO CART" + id);
    var body = {"service_id": id, "user_id": u_data.data.id.toString()};
    final res = await postRequest("cart_add", body);
    if (res['status'] != "error") {
      print("Added To Cart");
      await getcart();
      return "done";
    } else {
      my_toast("Technical error !", "error");
    }
  }

  removeFromCart(String id) async {
    final res = await getRequest("cart_remove/?id=$id");
    if (res != "error") {
      print("Removed from Cart");
      await getcart();
      return "done";
    } else {
      my_toast("Technical error !", "error");
    }
  }

  placeOrder(String date, String time, String address) async {
    var d = des.toString();
    var body = {
      "address": u_data.data.address,
      "date": date,
      "time": time,
      "remark": "remark " + d.toString(),
      "user_id": u_data.data.id.toString()
    };
    print(body.toString());
    final res = await postRequest("place_order", body);
    print(res.toString());
    if (res != "error") {
      print("Placed Order");
      await getcart();
      getBookings();
      return "done";
    } else {
      my_toast("Technical error !", "error");
    }
  }

  Bookings booking_data = null;
  getBookings() async {
    final res = await getRequest("orders?user_id=" + u_data.data.id.toString());
    if (res != "error") {
      dynamic data = Bookings.fromJson(res);
      booking_data = data;
      notifyListeners();
    } else {
      my_toast("Technical error in getting bookings data", "error");
    }
  }

  BookingDetail b_data = null;
  getBooking(String id) async {
    b_data = null;
    notifyListeners();
    final res = await getRequest("booking?id=" + id);
    if (res != "error") {
      dynamic data = BookingDetail.fromJson(res);
      b_data = data;
      notifyListeners();
    } else {
      my_toast("Technical error in getting booking data", "error");
    }
  }

  submitPayment(String bid, String amount, String status, String method) async {
    var body = {
      "id": bid,
      "user_id": u_data.data.id,
      "amount": amount,
      "status": status,
      "payment_method": method,
    };

    final res = await postRequest("submit_payment", body);
    if (res != "error") {
      await getBooking(bid);
      print(bid);
      return "done";
    } else {
      my_toast("Technical Error !", "error");
      return "error";
    }
  }

  ConversationModel chatsData = null;

  getChats() async {
    final res = await getRequest("my_chats?uid=${u_data.data.id}");
    if (res != "error") {
      chatsData = ConversationModel.fromJson(res);
      notifyListeners();
    } else {
      my_toast("Technical error", "error");
    }
  }

  ChatDataModel chatData = null;
  getChat(String id) async {
    print("getting chat============" + id);
    final res = await getRequest("chat_data?id=${id}");
    if (res != "error") {
      chatData = ChatDataModel.fromJson(res);
      notifyListeners();
      print(chatData.toString());
    } else {
      my_toast("Technical error", "error");
    }
  }

  findChat(String id) async {
    chatData = null;
    notifyListeners();
    print("getting chat============ from reciver user id" +
        id +
        "uid" +
        u_data.data.id);
    final res = await getRequest("find_chat?uid=${u_data.data.id}&rid=$id");
    print("==========" + res.toString());

    if (res != "error") {
      chatData = ChatDataModel.fromJson(res);
      notifyListeners();
      print(chatData.toString());
    } else {
      my_toast("Technical error", "error");
    }
  }

  sendMsg(String ruid, String msg) async {
    var body = {"s_u_id": u_data.data.id, "r_u_id": ruid, "msg": msg};
    final res = await postRequest("send_msg", body);
    if (res != "error") {
      await getChats();
      getChat(res['c_id']);
    } else {
      my_toast("Technical error", "error");
    }
  }
}

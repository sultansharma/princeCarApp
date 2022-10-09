class UserData {
  String status;
  Data data;

  UserData({this.status, this.data});

  UserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  String name;
  String email;
  String phone;
  String address;
  String city;
  String country;
  String avatar;
  String about;
  String title;
  String utype;
  String catId;
  String fcmToken;
  String accessToken;
  String random;
  String lat;
  String lng;
  String paypalId;
  String payeeName;
  String accountNo;
  String bankName;
  String ifsc;
  String swiftCode;
  String created;
  String status;
  String isVerify;
  String balance;
  String currency;

  Data(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.country,
      this.avatar,
      this.about,
      this.title,
      this.utype,
      this.catId,
      this.fcmToken,
      this.accessToken,
      this.random,
      this.lat,
      this.lng,
      this.paypalId,
      this.payeeName,
      this.accountNo,
      this.bankName,
      this.ifsc,
      this.swiftCode,
      this.created,
      this.status,
      this.isVerify,
      this.balance,
      this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    avatar = json['avatar'];
    about = json['about'];
    title = json['title'];
    utype = json['utype'];
    catId = json['cat_id'];
    fcmToken = json['fcm_token'];
    accessToken = json['access_token'];
    random = json['random'];
    lat = json['lat'];
    lng = json['lng'];
    paypalId = json['paypal_id'];
    payeeName = json['payee_name'];
    accountNo = json['account_no'];
    bankName = json['bank_name'];
    ifsc = json['ifsc'];
    swiftCode = json['swift_code'];
    created = json['created'];
    status = json['status'];
    isVerify = json['is_verify'];
    balance = json['balance'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['avatar'] = this.avatar;
    data['about'] = this.about;
    data['title'] = this.title;
    data['utype'] = this.utype;
    data['cat_id'] = this.catId;
    data['fcm_token'] = this.fcmToken;
    data['access_token'] = this.accessToken;
    data['random'] = this.random;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['paypal_id'] = this.paypalId;
    data['payee_name'] = this.payeeName;
    data['account_no'] = this.accountNo;
    data['bank_name'] = this.bankName;
    data['ifsc'] = this.ifsc;
    data['swift_code'] = this.swiftCode;
    data['created'] = this.created;
    data['status'] = this.status;
    data['is_verify'] = this.isVerify;
    data['balance'] = this.balance;
    data['currency'] = this.currency;
    return data;
  }
}

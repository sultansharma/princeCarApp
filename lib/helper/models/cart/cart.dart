class MyCart {
  CartData cartData;

  MyCart({this.cartData});

  MyCart.fromJson(Map<String, dynamic> json) {
    cartData = json['cart_data'] != null
        ? new CartData.fromJson(json['cart_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartData != null) {
      data['cart_data'] = this.cartData.toJson();
    }
    return data;
  }
}

class CartData {
  dynamic subtotal;
  dynamic visit;
  dynamic tax;
  dynamic initialPay;
  List<Items> items;

  CartData({this.subtotal, this.visit, this.tax, this.initialPay, this.items});

  CartData.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    visit = json['visit'];
    tax = json['tax'];
    initialPay = json['initial_pay'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['visit'] = this.visit;
    data['tax'] = this.tax;
    data['initial_pay'] = this.initialPay;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String id;
  String catId;
  String providerType;
  String userId;
  String serviceId;
  String serviceName;
  String quantity;
  String amount;
  String updatedAt;
  String createdAt;
  String description;

  Items(
      {this.id,
      this.catId,
      this.providerType,
      this.userId,
      this.serviceId,
      this.serviceName,
      this.quantity,
      this.amount,
      this.updatedAt,
      this.createdAt,
      this.description});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    providerType = json['provider_type'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    quantity = json['quantity'];
    amount = json['amount'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['provider_type'] = this.providerType;
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    return data;
  }
}

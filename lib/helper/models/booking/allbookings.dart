class Bookings {
  AllBookings allBookings;

  Bookings({this.allBookings});

  Bookings.fromJson(Map<String, dynamic> json) {
    allBookings = json['all_bookings'] != null
        ? new AllBookings.fromJson(json['all_bookings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allBookings != null) {
      data['all_bookings'] = this.allBookings.toJson();
    }
    return data;
  }
}

class AllBookings {
  List<PenBookings> comBookings;
  List<PenBookings> canBookings;
  List<PenBookings> penBookings;

  AllBookings({this.comBookings, this.canBookings, this.penBookings});

  AllBookings.fromJson(Map<String, dynamic> json) {
    if (json['com_bookings'] != null) {
      comBookings = new List<PenBookings>();
      json['com_bookings'].forEach((v) {
        comBookings.add(new PenBookings.fromJson(v));
      });
    }
    if (json['can_bookings'] != null) {
      canBookings = new List<PenBookings>();
      json['can_bookings'].forEach((v) {
        canBookings.add(new PenBookings.fromJson(v));
      });
    }
    if (json['pen_bookings'] != null) {
      penBookings = new List<PenBookings>();
      json['pen_bookings'].forEach((v) {
        penBookings.add(new PenBookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comBookings != null) {
      data['com_bookings'] = this.comBookings.map((v) => v.toJson()).toList();
    }
    if (this.canBookings != null) {
      data['can_bookings'] = this.canBookings.map((v) => v.toJson()).toList();
    }
    if (this.penBookings != null) {
      data['pen_bookings'] = this.penBookings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PenBookings {
  String id;
  String userId;
  String name;
  String status;
  String cost;
  String estimatedCost;
  String date;
  String time;
  String finalCost;
  String address;
  String remark;
  String serviceId;
  String service;
  List<Items> items;
  Provider provider;

  PenBookings(
      {this.id,
      this.userId,
      this.name,
      this.status,
      this.cost,
      this.estimatedCost,
      this.date,
      this.time,
      this.finalCost,
      this.address,
      this.remark,
      this.serviceId,
      this.service,
      this.items,
      this.provider});

  PenBookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    status = json['status'];
    cost = json['cost'];
    estimatedCost = json['estimated_cost'];
    date = json['date'];
    time = json['time'];
    finalCost = json['final_cost'];
    address = json['address'];
    remark = json['remark'];
    serviceId = json['service_id'];
    service = json['service'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['cost'] = this.cost;
    data['estimated_cost'] = this.estimatedCost;
    data['date'] = this.date;
    data['time'] = this.time;
    data['final_cost'] = this.finalCost;
    data['address'] = this.address;
    data['remark'] = this.remark;
    data['service_id'] = this.serviceId;
    data['service'] = this.service;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.provider != null) {
      data['provider'] = this.provider.toJson();
    }
    return data;
  }
}

class Items {
  String id;
  String orderId;
  String addedBy;
  String serviceId;
  String catId;
  String amount;
  String quantity;
  String changedQuantity;
  String remark;
  String createdAt;
  String updatedAt;

  Items(
      {this.id,
      this.orderId,
      this.addedBy,
      this.serviceId,
      this.catId,
      this.amount,
      this.quantity,
      this.changedQuantity,
      this.remark,
      this.createdAt,
      this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    addedBy = json['added_by'];
    serviceId = json['service_id'];
    catId = json['cat_id'];
    amount = json['amount'];
    quantity = json['quantity'];
    changedQuantity = json['changed_quantity'];
    remark = json['remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['added_by'] = this.addedBy;
    data['service_id'] = this.serviceId;
    data['cat_id'] = this.catId;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['changed_quantity'] = this.changedQuantity;
    data['remark'] = this.remark;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Provider {
  String id;
  String name;
  String phone;
  String avatar;
  String rating;

  Provider({this.id, this.name, this.phone, this.avatar, this.rating});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    avatar = json['avatar'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['rating'] = this.rating;
    return data;
  }
}

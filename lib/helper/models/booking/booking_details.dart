class BookingDetail {
  BookingData bookingData;

  BookingDetail({this.bookingData});

  BookingDetail.fromJson(Map<String, dynamic> json) {
    bookingData = json['booking_data'] != null
        ? new BookingData.fromJson(json['booking_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingData != null) {
      data['booking_data'] = this.bookingData.toJson();
    }
    return data;
  }
}

class BookingData {
  String id;
  String userId;
  String name;
  String status;
  String cost;
  String estimatedCost;
  String eDate;
  String eData;
  String date;
  String time;
  String finalCost;
  String completedOn;
  String address;
  String remark;
  String serviceId;
  String service;
  String spId;
  String providerName;
  String providerPhone;
  String providerOn;
  String providerLat;
  String providerLong;
  dynamic intpaid;
  dynamic isFinalEdited;
  dynamic isEstimateEdited;
  dynamic finalPayType;
  dynamic isPaid;
  String bookingOn;

  BookingData(
      {this.id,
      this.userId,
      this.name,
      this.status,
      this.cost,
      this.estimatedCost,
      this.eDate,
      this.eData,
      this.date,
      this.time,
      this.finalCost,
      this.completedOn,
      this.address,
      this.remark,
      this.serviceId,
      this.service,
      this.spId,
      this.providerName,
      this.providerPhone,
      this.providerOn,
      this.providerLat,
      this.providerLong,
      this.intpaid,
      this.isFinalEdited,
      this.isEstimateEdited,
      this.finalPayType,
      this.isPaid,
      this.bookingOn});

  BookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    status = json['status'];
    cost = json['cost'];
    estimatedCost = json['estimated_cost'];
    eDate = json['e_date'];
    eData = json['e_data'];
    date = json['date'];
    time = json['time'];
    finalCost = json['final_cost'];
    completedOn = json['completed_on'];
    address = json['address'];
    remark = json['remark'];
    serviceId = json['service_id'];
    service = json['service'];
    spId = json['sp_id'];
    providerName = json['provider_name'];
    providerPhone = json['provider_phone'];
    providerOn = json['provider_on'];
    providerLat = json['provider_lat'];
    providerLong = json['provider_long'];
    intpaid = json['int_paid'];
    isFinalEdited = json['is_final_edited'];
    isEstimateEdited = json['is_estimate_edited'];
    finalPayType = json['final_pay_type'];
    isPaid = json['is_paid'];
    bookingOn = json['booking_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['cost'] = this.cost;
    data['estimated_cost'] = this.estimatedCost;
    data['e_date'] = this.eDate;
    data['e_data'] = this.eData;
    data['date'] = this.date;
    data['time'] = this.time;
    data['final_cost'] = this.finalCost;
    data['completed_on'] = this.completedOn;
    data['address'] = this.address;
    data['remark'] = this.remark;
    data['service_id'] = this.serviceId;
    data['service'] = this.service;
    data['sp_id'] = this.spId;
    data['provider_name'] = this.providerName;
    data['provider_phone'] = this.providerPhone;
    data['provider_on'] = this.providerOn;
    data['provider_lat'] = this.providerLat;
    data['provider_long'] = this.providerLong;
    data['int_paid'] = this.intpaid;
    data['is_final_edited'] = this.isFinalEdited;
    data['is_estimate_edited'] = this.isEstimateEdited;
    data['final_pay_type'] = this.finalPayType;
    data['is_paid'] = this.isPaid;
    data['booking_on'] = this.bookingOn;
    return data;
  }
}

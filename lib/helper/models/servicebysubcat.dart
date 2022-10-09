class ServicesBySubCat {
  String status;
  List<ServiceData> serviceData;

  ServicesBySubCat({this.status, this.serviceData});

  ServicesBySubCat.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['service_data'] != null) {
      serviceData = new List<ServiceData>();
      json['service_data'].forEach((v) {
        serviceData.add(new ServiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.serviceData != null) {
      data['service_data'] = this.serviceData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceData {
  String id;
  String catId;
  String title;
  String price;
  String icon;
  String description;
  String created;
  String image;

  ServiceData(
      {this.id,
      this.catId,
      this.title,
      this.price,
      this.icon,
      this.description,
      this.created,
      this.image});

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    title = json['title'];
    price = json['price'];
    icon = json['icon'];
    description = json['description'];
    created = json['created'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['created'] = this.created;
    data['image'] = this.image;
    return data;
  }
}

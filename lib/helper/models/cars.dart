class CarsData {
  String status;
  List<BrandData> brandData;

  CarsData({this.status, this.brandData});

  CarsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['brand_data'] != null) {
      brandData = <BrandData>[];
      json['brand_data'].forEach((v) {
        brandData.add(new BrandData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.brandData != null) {
      data['brand_data'] = this.brandData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandData {
  String id;
  String logo;
  String name;
  List<Cars> cars;

  BrandData({this.id, this.logo, this.name, this.cars});

  BrandData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    name = json['name'];
    if (json['cars'] != null) {
      cars = <Cars>[];
      json['cars'].forEach((v) {
        cars.add(new Cars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['name'] = this.name;
    if (this.cars != null) {
      data['cars'] = this.cars.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cars {
  String id;
  String logo;
  String brandId;
  String name;

  Cars({this.id, this.logo, this.brandId, this.name});

  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    brandId = json['brand_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['brand_id'] = this.brandId;
    data['name'] = this.name;
    return data;
  }
}

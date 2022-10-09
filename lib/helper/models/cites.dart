class Cites {
  List<AllCites> allCites;

  Cites({this.allCites});

  Cites.fromJson(Map<String, dynamic> json) {
    if (json['all_cites'] != null) {
      allCites = new List<AllCites>();
      json['all_cites'].forEach((v) {
        allCites.add(new AllCites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allCites != null) {
      data['all_cites'] = this.allCites.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCites {
  String id;
  String name;
  String status;
  String createdAt;
  String updatedAt;

  AllCites({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  AllCites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

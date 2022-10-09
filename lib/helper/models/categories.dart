class CatData {
  String status;
  List<CategoriesData> categoriesData;

  CatData({this.status, this.categoriesData});

  CatData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories_data'] != null) {
      categoriesData = new List<CategoriesData>();
      json['categories_data'].forEach((v) {
        categoriesData.add(new CategoriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.categoriesData != null) {
      data['categories_data'] =
          this.categoriesData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesData {
  String id;
  String image;
  String name;
  List<Sub> sub;

  CategoriesData({this.id, this.image, this.name, this.sub});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];

    name = json['name'];
    if (json['sub'] != null) {
      sub = new List<Sub>();
      json['sub'].forEach((v) {
        sub.add(new Sub.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;

    data['name'] = this.name;
    if (this.sub != null) {
      data['sub'] = this.sub.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sub {
  String id;
  String image;
  dynamic startingPrice;
  String name;

  Sub({this.id, this.image, this.startingPrice, this.name});

  Sub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    startingPrice = json['starting_price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['starting_price'] = this.startingPrice;
    data['name'] = this.name;
    return data;
  }
}

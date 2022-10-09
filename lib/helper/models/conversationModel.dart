class ConversationModel {
  List<ConversationsData> conversationsData;

  ConversationModel({this.conversationsData});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    if (json['conversations_data'] != null) {
      conversationsData = new List<ConversationsData>();
      json['conversations_data'].forEach((v) {
        conversationsData.add(new ConversationsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conversationsData != null) {
      data['conversations_data'] =
          this.conversationsData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversationsData {
  String id;
  User user;
  int notRead;
  List<Messages> messages;

  ConversationsData({this.id, this.user, this.notRead, this.messages});

  ConversationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    notRead = json['not_read'];
    if (json['messages'] != null) {
      messages = new List<Messages>();
      json['messages'].forEach((v) {
        messages.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['not_read'] = this.notRead;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String userId;
  String name;
  String image;
  String service;
  String phonePrivate;
  String phone;

  User(
      {this.userId,
      this.name,
      this.image,
      this.service,
      this.phonePrivate,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    image = json['image'];
    service = json['service'];
    phonePrivate = json['phone_private'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['service'] = this.service;
    data['phone_private'] = this.phonePrivate;
    data['phone'] = this.phone;
    return data;
  }
}

class Messages {
  String id;
  String userId;
  String conversationId;
  String isRead;
  String body;
  String image;
  String updatedAt;
  String createdAt;

  Messages(
      {this.id,
      this.userId,
      this.conversationId,
      this.isRead,
      this.body,
      this.image,
      this.updatedAt,
      this.createdAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    conversationId = json['conversation_id'];
    isRead = json['is_read'];
    body = json['body'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['conversation_id'] = this.conversationId;
    data['is_read'] = this.isRead;
    data['body'] = this.body;
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

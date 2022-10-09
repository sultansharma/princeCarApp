class ChatDataModel {
  List<ChatData> chatData;

  ChatDataModel({this.chatData});

  ChatDataModel.fromJson(Map<String, dynamic> json) {
    if (json['chat_data'] != null) {
      chatData = new List<ChatData>();
      json['chat_data'].forEach((v) {
        chatData.add(new ChatData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chatData != null) {
      data['chat_data'] = this.chatData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatData {
  String id;
  String userId;
  dynamic conversationId;
  String isRead;
  String body;
  String image;
  String updatedAt;
  String createdAt;

  ChatData(
      {this.id,
      this.userId,
      this.conversationId,
      this.isRead,
      this.body,
      this.image,
      this.updatedAt,
      this.createdAt});

  ChatData.fromJson(Map<String, dynamic> json) {
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

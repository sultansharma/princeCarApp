class TransactionsModel {
  List<Transactions> transactions;

  TransactionsModel({this.transactions});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String id;
  String userId;
  String type;
  String serviceId;
  String transactionId;
  String paymentMethod;
  String status;
  String transactionBy;
  String transactionFor;
  String amount;
  String datetime;
  String createdAt;

  Transactions(
      {this.id,
      this.userId,
      this.type,
      this.serviceId,
      this.transactionId,
      this.paymentMethod,
      this.status,
      this.transactionBy,
      this.transactionFor,
      this.amount,
      this.datetime,
      this.createdAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    serviceId = json['service_id'];
    transactionId = json['transaction_id'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    transactionBy = json['transaction_by'];
    transactionFor = json['transaction_for'];
    amount = json['amount'];
    datetime = json['datetime'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['service_id'] = this.serviceId;
    data['transaction_id'] = this.transactionId;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['transaction_by'] = this.transactionBy;
    data['transaction_for'] = this.transactionFor;
    data['amount'] = this.amount;
    data['datetime'] = this.datetime;
    data['created_at'] = this.createdAt;
    return data;
  }
}

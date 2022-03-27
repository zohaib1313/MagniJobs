import 'package:magnijobs_rnr/dio_network/decodable.dart';

class MySubScriptionModel implements Decodable {
  List<Subscriptions>? subscriptions;

  MySubScriptionModel({this.subscriptions});

  MySubScriptionModel.fromJson(Map<String, dynamic> json) {
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(new Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriptions != null) {
      data['subscriptions'] =
          this.subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(new Subscriptions.fromJson(v));
      });
    }
    return this;
  }
}

class Subscriptions {
  int? id;
  String? employerId;
  String? employer;
  String? packageId;
  String? expiresOn;
  String? amount;
  String? notes;
  String? payMethod;
  String? paymentReference;
  String? createdAt;
  String? updatedAt;

  Subscriptions(
      {this.id,
      this.employerId,
      this.employer,
      this.packageId,
      this.expiresOn,
      this.amount,
      this.notes,
      this.payMethod,
      this.paymentReference,
      this.createdAt,
      this.updatedAt});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employerId = json['employer_id'];
    employer = json['employer'];
    packageId = json['package_id'];
    expiresOn = json['expires_on'];
    amount = json['amount'];
    notes = json['notes'];
    payMethod = json['pay_method'];
    paymentReference = json['payment_reference'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employer_id'] = this.employerId;
    data['employer'] = this.employer;
    data['package_id'] = this.packageId;
    data['expires_on'] = this.expiresOn;
    data['amount'] = this.amount;
    data['notes'] = this.notes;
    data['pay_method'] = this.payMethod;
    data['payment_reference'] = this.paymentReference;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

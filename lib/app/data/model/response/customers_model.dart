class CustomersModel {
  List<Data>? data;

  CustomersModel({this.data});

  CustomersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? username;
  String? email;
  int? branchId;
  String? phone;
  int? status;
  String? image;
  String? countryCode;
  int? messages;

  Data(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.branchId,
      this.phone,
      this.status,
      this.image,
      this.countryCode,
      this.messages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    branchId = json['branch_id'];
    phone = json['phone'];
    status = json['status'];
    image = json['image'];
    countryCode = json['country_code'];
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['branch_id'] = this.branchId;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['image'] = this.image;
    data['country_code'] = this.countryCode;
    data['messages'] = this.messages;
    return data;
  }
}

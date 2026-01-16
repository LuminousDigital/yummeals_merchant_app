class SalesReportModel {
  List<Data>? data;
  Links? links;
  Meta? meta;

  SalesReportModel({this.data, this.links, this.meta});

  SalesReportModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? orderSerialNo;
  String? orderDatetime;
  String? totalAmountPrice;
  String? discountAmountPrice;
  String? deliveryChargeAmountPrice;
  int? paymentMethod;
  int? paymentStatus;
  String? transaction;
  int? orderType;
  int? posPaymentMethod;
  int? status;
  String? customerName;

  Data(
      {this.id,
      this.orderSerialNo,
      this.orderDatetime,
      this.totalAmountPrice,
      this.discountAmountPrice,
      this.deliveryChargeAmountPrice,
      this.paymentMethod,
      this.paymentStatus,
      this.transaction,
      this.orderType,
      this.posPaymentMethod,
      this.status,
      this.customerName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderSerialNo = json['order_serial_no'];
    orderDatetime = json['order_datetime'];
    totalAmountPrice = json['total_amount_price'];
    discountAmountPrice = json['discount_amount_price'];
    deliveryChargeAmountPrice = json['delivery_charge_amount_price'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    transaction = json['transaction'];
    orderType = json['order_type'];
    posPaymentMethod = json['pos_payment_method'];
    status = json['status'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_serial_no'] = this.orderSerialNo;
    data['order_datetime'] = this.orderDatetime;
    data['total_amount_price'] = this.totalAmountPrice;
    data['discount_amount_price'] = this.discountAmountPrice;
    data['delivery_charge_amount_price'] = this.deliveryChargeAmountPrice;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['transaction'] = this.transaction;
    data['order_type'] = this.orderType;
    data['pos_payment_method'] = this.posPaymentMethod;
    data['status'] = this.status;
    data['customer_name'] = this.customerName;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
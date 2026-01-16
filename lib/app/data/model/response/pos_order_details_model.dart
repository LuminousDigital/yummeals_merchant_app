class POSOrderDetailsModel {
  Data? data;

  POSOrderDetailsModel({this.data});

  POSOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? orderSerialNo;
  String? token;
  String? subtotalCurrencyPrice;
  String? subtotalWithoutTaxCurrencyPrice;
  String? discountCurrencyPrice;
  String? deliveryChargeCurrencyPrice;
  String? totalCurrencyPrice;
  String? totalTaxCurrencyPrice;
  int? orderType;
  String? orderDatetime;
  String? orderDate;
  String? orderTime;
  String? deliveryDate;
  String? deliveryTime;
  int? paymentMethod;
  int? paymentStatus;
  int? isAdvanceOrder;
  int? preparationTime;
  int? status;
  String? statusName;
  String? reason;
  User? user;
  dynamic orderAddress;
  Branch? branch;
  DeliveryBoy? deliveryBoy;
  dynamic coupon;
  String? transaction;
  List<OrderItems>? orderItems;
  int? posPaymentMethod;
  String? posPaymentNote;
  String? posReceivedCurrencyAmount;
  String? cashBackCurrencyAmount;

  Data({
    this.id,
    this.orderSerialNo,
    this.token,
    this.subtotalCurrencyPrice,
    this.subtotalWithoutTaxCurrencyPrice,
    this.discountCurrencyPrice,
    this.deliveryChargeCurrencyPrice,
    this.totalCurrencyPrice,
    this.totalTaxCurrencyPrice,
    this.orderType,
    this.orderDatetime,
    this.orderDate,
    this.orderTime,
    this.deliveryDate,
    this.deliveryTime,
    this.paymentMethod,
    this.paymentStatus,
    this.isAdvanceOrder,
    this.preparationTime,
    this.status,
    this.statusName,
    this.reason,
    this.user,
    this.orderAddress,
    this.branch,
    this.deliveryBoy,
    this.coupon,
    this.transaction,
    this.orderItems,
    this.posPaymentMethod,
    this.posPaymentNote,
    this.posReceivedCurrencyAmount,
    this.cashBackCurrencyAmount,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderSerialNo = json['order_serial_no'];
    token = json['token'];
    subtotalCurrencyPrice = json['subtotal_currency_price'];
    subtotalWithoutTaxCurrencyPrice =
        json['subtotal_without_tax_currency_price'];
    discountCurrencyPrice = json['discount_currency_price'];
    deliveryChargeCurrencyPrice = json['delivery_charge_currency_price'];
    totalCurrencyPrice = json['total_currency_price'];
    totalTaxCurrencyPrice = json['total_tax_currency_price'];
    orderType = json['order_type'];
    orderDatetime = json['order_datetime'];
    orderDate = json['order_date'];
    orderTime = json['order_time'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    isAdvanceOrder = json['is_advance_order'];
    preparationTime = json['preparation_time'];
    status = json['status'];
    statusName = json['status_name'];
    reason = json['reason'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    orderAddress = json['order_address'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    deliveryBoy = json['delivery_boy'] != null
        ? new DeliveryBoy.fromJson(json['delivery_boy'])
        : null;
    coupon = json['coupon'];
    transaction = json['transaction'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    posPaymentMethod = json['pos_payment_method'];
    posPaymentNote = json['pos_payment_note'];
    posReceivedCurrencyAmount = json['pos_received_currency_amount'];
    cashBackCurrencyAmount = json['cash_back_currency_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_serial_no'] = this.orderSerialNo;
    data['token'] = this.token;
    data['subtotal_currency_price'] = this.subtotalCurrencyPrice;
    data['subtotal_without_tax_currency_price'] =
        this.subtotalWithoutTaxCurrencyPrice;
    data['discount_currency_price'] = this.discountCurrencyPrice;
    data['delivery_charge_currency_price'] = this.deliveryChargeCurrencyPrice;
    data['total_currency_price'] = this.totalCurrencyPrice;
    data['total_tax_currency_price'] = this.totalTaxCurrencyPrice;
    data['order_type'] = this.orderType;
    data['order_datetime'] = this.orderDatetime;
    data['order_date'] = this.orderDate;
    data['order_time'] = this.orderTime;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_time'] = this.deliveryTime;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['is_advance_order'] = this.isAdvanceOrder;
    data['preparation_time'] = this.preparationTime;
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    data['reason'] = this.reason;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['order_address'] = this.orderAddress;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.deliveryBoy != null) {
      data['delivery_boy'] = this.deliveryBoy!.toJson();
    }
    data['coupon'] = this.coupon;
    data['transaction'] = this.transaction;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['pos_payment_method'] = this.posPaymentMethod;
    data['pos_payment_note'] = this.posPaymentNote;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? username;
  String? balance;
  String? currencyBalance;
  String? image;
  int? roleId;
  String? countryCode;
  int? order;
  String? createDate;
  String? updateDate;

  User(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.username,
      this.balance,
      this.currencyBalance,
      this.image,
      this.roleId,
      this.countryCode,
      this.order,
      this.createDate,
      this.updateDate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    username = json['username'];
    balance = json['balance'];
    currencyBalance = json['currency_balance'];
    image = json['image'];
    roleId = json['role_id'];
    countryCode = json['country_code'];
    order = json['order'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['username'] = this.username;
    data['balance'] = this.balance;
    data['currency_balance'] = this.currencyBalance;
    data['image'] = this.image;
    data['role_id'] = this.roleId;
    data['country_code'] = this.countryCode;
    data['order'] = this.order;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? latitude;
  String? longitude;
  String? city;
  String? state;
  String? zipCode;
  String? address;
  int? status;

  Branch(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.latitude,
      this.longitude,
      this.city,
      this.state,
      this.zipCode,
      this.address,
      this.status});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    address = json['address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['address'] = this.address;
    data['status'] = this.status;
    return data;
  }
}

class OrderItems {
  int? id;
  int? orderId;
  int? branchId;
  int? itemId;
  String? itemName;
  String? itemImage;
  int? quantity;
  String? discount;
  String? price;
  List<ItemVariations>? itemVariations;
  List<ItemExtras>? itemExtras;
  String? itemVariationCurrencyTotal;
  String? itemExtraCurrencyTotal;
  String? totalConvertPrice;
  String? totalCurrencyPrice;
  String? instruction;
  String? taxType;
  String? taxRate;
  String? taxCurrencyRate;
  String? taxName;
  String? taxCurrencyAmount;
  String? totalWithoutTaxCurrencyPrice;

  OrderItems(
      {this.id,
      this.orderId,
      this.branchId,
      this.itemId,
      this.itemName,
      this.itemImage,
      this.quantity,
      this.discount,
      this.price,
      this.itemVariations,
      this.itemExtras,
      this.itemVariationCurrencyTotal,
      this.itemExtraCurrencyTotal,
      this.totalConvertPrice,
      this.totalCurrencyPrice,
      this.instruction,
      this.taxType,
      this.taxRate,
      this.taxCurrencyRate,
      this.taxName,
      this.taxCurrencyAmount,
      this.totalWithoutTaxCurrencyPrice});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    branchId = json['branch_id'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemImage = json['item_image'];
    quantity = json['quantity'];
    discount = json['discount'];
    price = json['price'];
    if (json['item_variations'] != null) {
      itemVariations = <ItemVariations>[];
      json['item_variations'].forEach((v) {
        itemVariations!.add(new ItemVariations.fromJson(v));
      });
    }
    if (json['item_extras'] != null) {
      itemExtras = <ItemExtras>[];
      json['item_extras'].forEach((v) {
        itemExtras!.add(new ItemExtras.fromJson(v));
      });
    }
    itemVariationCurrencyTotal = json['item_variation_currency_total'];
    itemExtraCurrencyTotal = json['item_extra_currency_total'];
    totalConvertPrice = json['total_convert_price'].toString();
    totalCurrencyPrice = json['total_currency_price'];
    instruction = json['instruction'];
    taxType = json['tax_type'];
    taxRate = json['tax_rate'];
    taxCurrencyRate = json['tax_currency_rate'];
    taxName = json['tax_name'];
    taxCurrencyAmount = json['tax_currency_amount'];
    totalWithoutTaxCurrencyPrice = json['total_without_tax_currency_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['branch_id'] = this.branchId;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['item_image'] = this.itemImage;
    data['quantity'] = this.quantity;
    data['discount'] = this.discount;
    data['price'] = this.price;
    if (this.itemVariations != null) {
      data['item_variations'] =
          this.itemVariations!.map((v) => v.toJson()).toList();
    }
    if (this.itemExtras != null) {
      data['item_extras'] = this.itemExtras!.map((v) => v.toJson()).toList();
    }
    data['item_variation_currency_total'] = this.itemVariationCurrencyTotal;
    data['item_extra_currency_total'] = this.itemExtraCurrencyTotal;
    data['total_convert_price'] = this.totalConvertPrice;
    data['total_currency_price'] = this.totalCurrencyPrice;
    data['instruction'] = this.instruction;
    data['tax_type'] = this.taxType;
    data['tax_rate'] = this.taxRate;
    data['tax_currency_rate'] = this.taxCurrencyRate;
    data['tax_name'] = this.taxName;
    data['tax_currency_amount'] = this.taxCurrencyAmount;
    data['total_without_tax_currency_price'] =
        this.totalWithoutTaxCurrencyPrice;
    return data;
  }
}

class DeliveryBoy {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? username;
  String? balance;
  String? currencyBalance;
  String? image;
  int? roleId;
  String? countryCode;
  int? order;
  String? createDate;
  String? updateDate;

  DeliveryBoy(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.username,
      this.balance,
      this.currencyBalance,
      this.image,
      this.roleId,
      this.countryCode,
      this.order,
      this.createDate,
      this.updateDate});

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    username = json['username'];
    balance = json['balance'];
    currencyBalance = json['currency_balance'];
    image = json['image'];
    roleId = json['role_id'];
    countryCode = json['country_code'];
    order = json['order'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['username'] = this.username;
    data['balance'] = this.balance;
    data['currency_balance'] = this.currencyBalance;
    data['image'] = this.image;
    data['role_id'] = this.roleId;
    data['country_code'] = this.countryCode;
    data['order'] = this.order;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    return data;
  }
}

class ItemVariations {
  int? id;
  dynamic itemId;
  dynamic itemAttributeId;
  String? variationName;
  String? name;

  ItemVariations(
      {this.id,
      this.itemId,
      this.itemAttributeId,
      this.variationName,
      this.name});

  ItemVariations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    itemAttributeId = json['item_attribute_id'];
    variationName = json['variation_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['item_attribute_id'] = this.itemAttributeId;
    data['variation_name'] = this.variationName;
    data['name'] = this.name;
    return data;
  }
}

class ItemExtras {
  int? id;
  int? itemId;
  String? name;

  ItemExtras({this.id, this.itemId, this.name});

  ItemExtras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    return data;
  }
}

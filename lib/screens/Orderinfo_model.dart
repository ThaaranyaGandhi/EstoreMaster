import 'dart:convert';


Orderinfo_model Orderinfo_modelModelFromJson(String str) => Orderinfo_model.fromJson(json.decode(str));

String Orderinfo_modelModelToJson(Orderinfo_model data) => json.encode(data.toJson());

class Orderinfo_model {
  List<Productinfo>? productinfo;
  double? subTotal;
  String? orderid;
  String? counponDiscount;
  String? address;
  String? addressType;
  String? customerName;
  String? totalAmt;
  Null? riderMobile;
  Null? riderName;
  String? pMethod;
  String? status;
  String? orderDate;
  String? timesloat;
  String? israted;
  String? dCharge;
  String? tax;
  String? responseCode;
  String? result;
  String? responseMsg;

  Orderinfo_model(
      {this.productinfo,
        this.subTotal,
        this.orderid,
        this.counponDiscount,
        this.address,
        this.addressType,
        this.customerName,
        this.totalAmt,
        this.riderMobile,
        this.riderName,
        this.pMethod,
        this.status,
        this.orderDate,
        this.timesloat,
        this.israted,
        this.dCharge,
        this.tax,
        this.responseCode,
        this.result,
        this.responseMsg});

  Orderinfo_model.fromJson(Map<String, dynamic> json) {
    if (json['productinfo'] != null) {
      productinfo = <Productinfo>[];
      json['productinfo'].forEach((v) {
        productinfo!.add(new Productinfo.fromJson(v));
      });
    }
    subTotal = json['Sub_total'];
    orderid = json['orderid'];
    counponDiscount = json['counpon_discount'];
    address = json['address'];
    addressType = json['address_type'];
    customerName = json['customer_name'];
    totalAmt = json['total_amt'];
    riderMobile = json['rider_mobile'];
    riderName = json['rider_name'];
    pMethod = json['p_method'];
    status = json['status'];
    orderDate = json['order_date'];
    timesloat = json['timesloat'];
    israted = json['Israted'];
    dCharge = json['d_charge'];
    tax = json['tax'];
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productinfo != null) {
      data['productinfo'] = this.productinfo!.map((v) => v.toJson()).toList();
    }
    data['Sub_total'] = this.subTotal;
    data['orderid'] = this.orderid;
    data['counpon_discount'] = this.counponDiscount;
    data['address'] = this.address;
    data['address_type'] = this.addressType;
    data['customer_name'] = this.customerName;
    data['total_amt'] = this.totalAmt;
    data['rider_mobile'] = this.riderMobile;
    data['rider_name'] = this.riderName;
    data['p_method'] = this.pMethod;
    data['status'] = this.status;
    data['order_date'] = this.orderDate;
    data['timesloat'] = this.timesloat;
    data['Israted'] = this.israted;
    data['d_charge'] = this.dCharge;
    data['tax'] = this.tax;
    data['ResponseCode'] = this.responseCode;
    data['Result'] = this.result;
    data['ResponseMsg'] = this.responseMsg;
    return data;
  }
}

class Productinfo {
  String? productName;
  String? productPrice;
  String? productWeight;
  String? productQty;
  String? productImage;
  String? discount;

  Productinfo(
      {this.productName,
        this.productPrice,
        this.productWeight,
        this.productQty,
        this.productImage,
        this.discount});

  Productinfo.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productPrice = json['product_price'];
    productWeight = json['product_weight'];
    productQty = json['product_qty'];
    productImage = json['product_image'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_weight'] = this.productWeight;
    data['product_qty'] = this.productQty;
    data['product_image'] = this.productImage;
    data['discount'] = this.discount;
    return data;
  }
}




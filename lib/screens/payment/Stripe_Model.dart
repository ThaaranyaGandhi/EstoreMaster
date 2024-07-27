import 'dart:convert';

Stripe_Model Stripe_ModelModelFromJson(String str) => Stripe_Model.fromJson(json.decode(str));

String Stripe_ModelModelToJson(Stripe_Model data) => json.encode(data.toJson());

class Stripe_Model {
  String? paymentIntent;
  String? ephemeralKey;
  String? customer;
  String? publishableKey;

  Stripe_Model(
      {this.paymentIntent,
        this.ephemeralKey,
        this.customer,
        this.publishableKey});

  Stripe_Model.fromJson(Map<String, dynamic> json) {
    paymentIntent = json['paymentIntent'];
    ephemeralKey = json['ephemeralKey'];
    customer = json['customer'];
    publishableKey = json['publishableKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentIntent'] = this.paymentIntent;
    data['ephemeralKey'] = this.ephemeralKey;
    data['customer'] = this.customer;
    data['publishableKey'] = this.publishableKey;
    return data;
  }
}


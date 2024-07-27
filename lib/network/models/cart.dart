import 'dart:convert';

import 'package:fresh_store_ui/network/models/product.dart';

class Cart {

  final Product product;
  final double amount;
  final double noOfItems;
  final String productType;

  Cart({
    required this.product,
    required this.amount,
    required this.noOfItems,
    required this.productType,
  });

  Cart copyWith({
    Product? product,
    double? amount,
    double? noOfItems,
    String? productType,
  }) {
    return Cart(
      product: product ?? this.product,
      amount: amount ?? this.amount,
      noOfItems: noOfItems ?? this.noOfItems,
      productType: productType ?? this.productType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'amount': amount,
      'noOfItems': noOfItems,
      'productType': productType,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      product: Product.fromMap(map['product'] as Map<String,dynamic>),
      amount: map['amount'] as double,
      noOfItems: map['noOfItems'] as double,
      productType: map['productType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(product: $product, amount: $amount, noOfItems: $noOfItems, productType: $productType)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;
  
    return 
      other.product == product &&
      other.amount == amount &&
      other.noOfItems == noOfItems &&
      other.productType == productType;
  }

  @override
  int get hashCode {
    return product.hashCode ^
      amount.hashCode ^
      noOfItems.hashCode ^
      productType.hashCode;
  }
}

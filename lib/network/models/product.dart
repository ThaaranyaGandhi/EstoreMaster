// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../constants/urls_const.dart';


class Product {

  final String id;
  final String productName;
  final String productImage;
  final String productRelatedImage;
  final String sellerName;
  final String shortDesc;
  final List<Price> price;
  final String stock;
  final String discount;
  
  Product({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.productRelatedImage,
    required this.sellerName,
    required this.shortDesc,
    required this.price,
    required this.stock,
    required this.discount,
  });


  Product copyWith({
    String? id,
    String? productName,
    String? productImage,
    String? productRelatedImage,
    String? sellerName,
    String? shortDesc,
    List<Price>? price,
    String? stock,
    String? discount,
  }) {
    return Product(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productRelatedImage: productRelatedImage ?? this.productRelatedImage,
      sellerName: sellerName ?? this.sellerName,
      shortDesc: shortDesc ?? this.shortDesc,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productImage': productImage,
      'productRelatedImage': productRelatedImage,
      'sellerName': sellerName,
      'shortDesc': shortDesc,
      'price': price.map((x) => x.toMap()).toList(),
      'stock': stock,
      'discount': discount,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      productName: map['product_name'] as String,
      productImage: "${UrlsConst.siteHost}${map['product_image'] as String}",
      productRelatedImage: map['product_related_image'] as String,
      sellerName: map['seller_name'] as String,
      shortDesc: map['short_desc'] as String,
      price: List<Price>.from((map['price'] as List).map<Price>((x) => Price.fromMap(x as Map),),),
      stock: map['stock'] as String,
      discount: map['discount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, productName: $productName, productImage: $productImage, productRelatedImage: $productRelatedImage, sellerName: $sellerName, shortDesc: $shortDesc, price: $price, stock: $stock, discount: $discount)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.productName == productName &&
      other.productImage == productImage &&
      other.productRelatedImage == productRelatedImage &&
      other.sellerName == sellerName &&
      other.shortDesc == shortDesc &&
      listEquals(other.price, price) &&
      other.stock == stock &&
      other.discount == discount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      productName.hashCode ^
      productImage.hashCode ^
      productRelatedImage.hashCode ^
      sellerName.hashCode ^
      shortDesc.hashCode ^
      price.hashCode ^
      stock.hashCode ^
      discount.hashCode;
  }
}

class Price {

  final String productType;
  final String productPrice;
  Price({
    required this.productType,
    required this.productPrice,
  });

  Price copyWith({
    String? productType,
    String? productPrice,
  }) {
    return Price(
      productType: productType ?? this.productType,
      productPrice: productPrice ?? this.productPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productType': productType,
      'productPrice': productPrice,
    };
  }

  factory Price.fromMap(map) {
    return Price(
      productType: map['product_type'] as String,
      productPrice: map['product_price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) => Price.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Price(productType: $productType, productPrice: $productPrice)';

  @override
  bool operator ==(covariant Price other) {
    if (identical(this, other)) return true;
  
    return 
      other.productType == productType &&
      other.productPrice == productPrice;
  }

  @override
  int get hashCode => productType.hashCode ^ productPrice.hashCode;
}

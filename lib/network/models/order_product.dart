// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderProduct {

  final String id;
  final String pid;
  final String image;
  final String title;
  final String weight;
  final String cost;
  final String qty;

  OrderProduct({
    required this.id,
    required this.pid,
    required this.image,
    required this.title,
    required this.weight,
    required this.cost,
    required this.qty,
  });


  OrderProduct copyWith({
    String? id,
    String? pid,
    String? image,
    String? title,
    String? weight,
    String? cost,
    String? qty,
  }) {
    return OrderProduct(
      id: id ?? this.id,
      pid: pid ?? this.pid,
      image: image ?? this.image,
      title: title ?? this.title,
      weight: weight ?? this.weight,
      cost: cost ?? this.cost,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pid': pid,
      'image': image,
      'title': title,
      'weight': weight,
      'cost': cost,
      'qty': qty,
    };
  }

  factory OrderProduct.fromMap(map) {
    return OrderProduct(
      id: map['id'] as String,
      pid: map['pid'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
      weight: map['weight'] as String,
      cost: map['cost'] as String,
      qty: map['qty'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProduct.fromJson(String source) => OrderProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderProduct(id: $id, pid: $pid, image: $image, title: $title, weight: $weight, cost: $cost, qty: $qty)';
  }

  @override
  bool operator ==(covariant OrderProduct other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.pid == pid &&
      other.image == image &&
      other.title == title &&
      other.weight == weight &&
      other.cost == cost &&
      other.qty == qty;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      pid.hashCode ^
      image.hashCode ^
      title.hashCode ^
      weight.hashCode ^
      cost.hashCode ^
      qty.hashCode;
  }
}

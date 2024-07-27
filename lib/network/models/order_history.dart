// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderHistoryModel {

  final String id;
  final String oid;
  final String status;
  final String orderDate;
  final String total;
  final String riderStatus;
  final String? riderName;
  final String? riderMobile;
  
  OrderHistoryModel({
    required this.id,
    required this.oid,
    required this.status,
    required this.orderDate,
    required this.total,
    required this.riderStatus,
    required this.riderName,
    required this.riderMobile,
  });


  OrderHistoryModel copyWith({
    String? id,
    String? oid,
    String? status,
    String? orderDate,
    String? total,
    String? riderStatus,
    String? riderName,
    String? riderMobile,
  }) {
    return OrderHistoryModel(
      id: id ?? this.id,
      oid: oid ?? this.oid,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
      total: total ?? this.total,
      riderStatus: riderStatus ?? this.riderStatus,
      riderName: riderName ?? this.riderName,
      riderMobile: riderMobile ?? this.riderMobile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'oid': oid,
      'status': status,
      'orderDate': orderDate,
      'total': total,
      'riderStatus': riderStatus,
      'riderName': riderName,
      'riderMobile': riderMobile,
    };
  }

  factory OrderHistoryModel.fromMap( map) {
    return OrderHistoryModel(
      id: map['id'] as String,
      oid: map['oid'] as String,
      status: map['status'] as String,
      orderDate: map['order_date'] as String,
      total: map['total'] as String,
      riderStatus: map['rider_status'] as String,
      riderName: map['rider_name'],
      riderMobile: map['rider_mobile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryModel.fromJson(String source) => OrderHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderHistoryModel(id: $id, oid: $oid, status: $status, orderDate: $orderDate, total: $total, riderStatus: $riderStatus, riderName: $riderName, riderMobile: $riderMobile)';
  }

  @override
  bool operator ==(covariant OrderHistoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.oid == oid &&
      other.status == status &&
      other.orderDate == orderDate &&
      other.total == total &&
      other.riderStatus == riderStatus &&
      other.riderName == riderName &&
      other.riderMobile == riderMobile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      oid.hashCode ^
      status.hashCode ^
      orderDate.hashCode ^
      total.hashCode ^
      riderStatus.hashCode ^
      riderName.hashCode ^
      riderMobile.hashCode;
  }
}

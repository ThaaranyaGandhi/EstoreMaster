// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Order {

  final String uid;
  final String ddate;
  final String timesloat;
  final String pname;
  final String pMethod;
  final String addressId;
  final String tax;
  final String couponId;
  final String couAmt;
  final String usedwal;
  final String tid;
  final String total;

  final String pid;
  final String weight;
  final String cost;
  final String qty;
  
  Order({
    required this.uid,
    required this.ddate,
    required this.timesloat,
    required this.pname,
    required this.pMethod,
    required this.addressId,
    required this.tax,
    required this.couponId,
    required this.couAmt,
    required this.usedwal,
    required this.tid,
    required this.total,
    required this.pid,
    required this.weight,
    required this.cost,
    required this.qty,
  });

  


  Order copyWith({
    String? uid,
    String? ddate,
    String? timesloat,
    String? pname,
    String? pMethod,
    String? addressId,
    String? tax,
    String? couponId,
    String? couAmt,
    String? usedwal,
    String? tid,
    String? total,
    String? pid,
    String? weight,
    String? cost,
    String? qty,
  }) {
    return Order(
      uid: uid ?? this.uid,
      ddate: ddate ?? this.ddate,
      timesloat: timesloat ?? this.timesloat,
      pname: pname ?? this.pname,
      pMethod: pMethod ?? this.pMethod,
      addressId: addressId ?? this.addressId,
      tax: tax ?? this.tax,
      couponId: couponId ?? this.couponId,
      couAmt: couAmt ?? this.couAmt,
      usedwal: usedwal ?? this.usedwal,
      tid: tid ?? this.tid,
      total: total ?? this.total,
      pid: pid ?? this.pid,
      weight: weight ?? this.weight,
      cost: cost ?? this.cost,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'ddate': ddate,
      'timesloat': timesloat,
      'pname': pname,
      'pMethod': pMethod,
      'addressId': addressId,
      'tax': tax,
      'couponId': couponId,
      'couAmt': couAmt,
      'usedwal': usedwal,
      'tid': tid,
      'total': total,
      'pid': pid,
      'weight': weight,
      'cost': cost,
      'qty': qty,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      uid: map['uid'] as String,
      ddate: map['ddate'] as String,
      timesloat: map['timesloat'] as String,
      pname: map['pname'] as String,
      pMethod: map['pMethod'] as String,
      addressId: map['addressId'] as String,
      tax: map['tax'] as String,
      couponId: map['couponId'] as String,
      couAmt: map['couAmt'] as String,
      usedwal: map['usedwal'] as String,
      tid: map['tid'] as String,
      total: map['total'] as String,
      pid: map['pid'] as String,
      weight: map['weight'] as String,
      cost: map['cost'] as String,
      qty: map['qty'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(uid: $uid, ddate: $ddate, timesloat: $timesloat, pname: $pname, pMethod: $pMethod, addressId: $addressId, tax: $tax, couponId: $couponId, couAmt: $couAmt, usedwal: $usedwal, tid: $tid, total: $total, pid: $pid, weight: $weight, cost: $cost, qty: $qty)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.ddate == ddate &&
      other.timesloat == timesloat &&
      other.pname == pname &&
      other.pMethod == pMethod &&
      other.addressId == addressId &&
      other.tax == tax &&
      other.couponId == couponId &&
      other.couAmt == couAmt &&
      other.usedwal == usedwal &&
      other.tid == tid &&
      other.total == total &&
      other.pid == pid &&
      other.weight == weight &&
      other.cost == cost &&
      other.qty == qty;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      ddate.hashCode ^
      timesloat.hashCode ^
      pname.hashCode ^
      pMethod.hashCode ^
      addressId.hashCode ^
      tax.hashCode ^
      couponId.hashCode ^
      couAmt.hashCode ^
      usedwal.hashCode ^
      tid.hashCode ^
      total.hashCode ^
      pid.hashCode ^
      weight.hashCode ^
      cost.hashCode ^
      qty.hashCode;
  }
}

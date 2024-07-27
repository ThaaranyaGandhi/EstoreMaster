// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {

  final String aid;
  final String name;
  final String type;
  final String no;
  final String society;
  final String area;
  final String landmark;
  final String pincode;

  Address({
    required this.aid,
    required this.name,
    required this.type,
    required this.no,
    required this.society,
    required this.area,
    required this.landmark,
    required this.pincode,
  });


  Address copyWith({
    String? aid,
    String? name,
    String? type,
    String? no,
    String? society,
    String? area,
    String? landmark,
    String? pincode,
  }) {
    return Address(
      aid: aid ?? this.aid,
      name: name ?? this.name,
      type: type ?? this.type,
      no: no ?? this.no,
      society: society ?? this.society,
      area: area ?? this.area,
      landmark: landmark ?? this.landmark,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'hno': no,
      'aid': aid,
      'society': society,
      'area': area,
      'landmark': landmark,
      'pincode': pincode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      name: map['name'] as String,
      type: map['type'] as String,
      aid: map['id'] as String,
      no: map['hno'] as String,
      society: map['society'] as String,
      area: map['area'] as String,
      landmark: map['landmark'] as String,
      pincode: map['pincode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(name: $name, type: $type, no: $no, society: $society, area: $area, landmark: $landmark, pincode: $pincode)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return
      other.name == name &&
      other.type == type &&
      other.no == no &&
      other.society == society &&
      other.area == area &&
      other.landmark == landmark &&
      other.pincode == pincode;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      type.hashCode ^
      no.hashCode ^
      society.hashCode ^
      area.hashCode ^
      landmark.hashCode ^
      pincode.hashCode;
  }
}

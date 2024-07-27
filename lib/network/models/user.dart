// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {

  final String? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? ccode;
  final String? imei;
  final String? rdate;
  final String? password;
  final String? pin;
  final String? ref;
  final String? wallet;
  final String? parent;
  
  User({
     this.id,
     this.name,
     this.email,
     this.mobile,
     this.ccode,
     this.imei,
     this.rdate,
     this.password,
     this.pin,
     this.ref,
     this.wallet,
     this.parent,
  });


  User copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? ccode,
    String? imei,
    String? rdate,
    String? password,
    String? pin,
    String? ref,
    String? wallet,
    String? parent,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      ccode: ccode ?? this.ccode,
      imei: imei ?? this.imei,
      rdate: rdate ?? this.rdate,
      password: password ?? this.password,
      pin: pin ?? this.pin,
      ref: ref ?? this.ref,
      wallet: wallet ?? this.wallet,
      parent: parent ?? this.parent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'ccode': ccode,
      'imei': imei,
      'rdate': rdate,
      'password': password,
      'pin': pin,
      'ref': ref,
      'wallet': wallet,
      'parent': parent,
    };
  }

  factory User.fromMap( map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      ccode: map['ccode'] as String,
      imei: map['imei'] as String,
      rdate: map['rdate'] as String,
      password: map['password'] as String,
      pin: map['pin'] ?? '',
      ref: map['ref'] ?? '',
      wallet: map['wallet'] ?? '',
      parent: map['parent'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, mobile: $mobile, ccode: $ccode, imei: $imei, rdate: $rdate, password: $password, pin: $pin, ref: $ref, wallet: $wallet, parent: $parent)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.mobile == mobile &&
      other.ccode == ccode &&
      other.imei == imei &&
      other.rdate == rdate &&
      other.password == password &&
      other.pin == pin &&
      other.ref == ref &&
      other.wallet == wallet &&
      other.parent == parent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      mobile.hashCode ^
      ccode.hashCode ^
      imei.hashCode ^
      rdate.hashCode ^
      password.hashCode ^
      pin.hashCode ^
      ref.hashCode ^
      wallet.hashCode ^
      parent.hashCode;
  }
}

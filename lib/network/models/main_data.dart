// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MainData {

  final String id;
  final String oneKey;
  final String oneHash;
  final String rkey;
  final String rHash;
  final String currency;
  final String privacyPolicy;

  MainData({
    required this.id,
    required this.oneKey,
    required this.oneHash,
    required this.rkey,
    required this.rHash,
    required this.currency,
    required this.privacyPolicy,
  });

  MainData copyWith({
    String? id,
    String? oneKey,
    String? oneHash,
    String? rkey,
    String? rHash,
    String? currency,
    String? privacyPolicy,
  }) {
    return MainData(
      id: id ?? this.id,
      oneKey: oneKey ?? this.oneKey,
      oneHash: oneHash ?? this.oneHash,
      rkey: rkey ?? this.rkey,
      rHash: rHash ?? this.rHash,
      currency: currency ?? this.currency,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'oneKey': oneKey,
      'oneHash': oneHash,
      'rkey': rkey,
      'rHash': rHash,
      'currency': currency,
      'privacyPolicy': privacyPolicy,
    };
  }

  factory MainData.fromMap( map) {
    return MainData(
      id: map['id'] as String,
      oneKey: map['one_key'] as String,
      oneHash: map['one_hash'] as String,
      rkey: map['r_key'] as String,
      rHash: map['r_hash'] as String,
      currency: map['currency'] as String,
      privacyPolicy: map['privacy_policy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MainData.fromJson(String source) => MainData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MainData(id: $id, oneKey: $oneKey, oneHash: $oneHash, rkey: $rkey, rHash: $rHash, currency: $currency, privacyPolicy: $privacyPolicy)';
  }

  @override
  bool operator ==(covariant MainData other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.oneKey == oneKey &&
      other.oneHash == oneHash &&
      other.rkey == rkey &&
      other.rHash == rHash &&
      other.currency == currency &&
      other.privacyPolicy == privacyPolicy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      oneKey.hashCode ^
      oneHash.hashCode ^
      rkey.hashCode ^
      rHash.hashCode ^
      currency.hashCode ^
      privacyPolicy.hashCode;
  }
}

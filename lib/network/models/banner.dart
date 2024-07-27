// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Banner {

  final String id;
  final String bimg;
  final String cid;

  Banner({
    required this.id,
    required this.bimg,
    required this.cid,
  });

  Banner copyWith({
    String? id,
    String? bimg,
    String? cid,
  }) {
    return Banner(
      id: id ?? this.id,
      bimg: bimg ?? this.bimg,
      cid: cid ?? this.cid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bimg': bimg,
      'cid': cid,
    };
  }

  factory Banner.fromMap(map) {
    return Banner(
      id: map['id'] as String,
      bimg: map['bimg'] as String,
      cid: map['cid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Banner.fromJson(String source) => Banner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Banner(id: $id, bimg: $bimg, cid: $cid)';

  @override
  bool operator ==(covariant Banner other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.bimg == bimg &&
      other.cid == cid;
  }

  @override
  int get hashCode => id.hashCode ^ bimg.hashCode ^ cid.hashCode;
}

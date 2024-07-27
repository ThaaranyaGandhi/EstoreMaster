/*
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  final String id;
  final String catname;
  final String catimg;
  final int count;
  Category({
    required this.id,
    required this.catname,
    required this.catimg,
    required this.count,
  });

  Category copyWith({
    String? id,
    String? catname,
    String? catimg,
    int? count,
  }) {
    return Category(
      id: id ?? this.id,
      catname: catname ?? this.catname,
      catimg: catimg ?? this.catimg,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'catname': catname,
      'catimg': catimg,
      'count': count,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      catname: map['catname'] as String,
      catimg: map['catimg'] as String,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, catname: $catname, catimg: $catimg, count: $count)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.catname == catname &&
      other.catimg == catimg &&
      other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      catname.hashCode ^
      catimg.hashCode ^
      count.hashCode;
  }
}
*/


// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  final String id;
  final String catname;
  final String catimg;
  final dynamic count;
  Category({
    required this.id,
    required this.catname,
    required this.catimg,
    required this.count,
  });

  Category copyWith({
    String? id,
    String? catname,
    String? catimg,
    dynamic count,
  }) {
    return Category(
      id: id ?? this.id,
      catname: catname ?? this.catname,
      catimg: catimg ?? this.catimg,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'catname': catname,
      'catimg': catimg,
      'count': count,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      catname: map['catname'] as String,
      catimg: map['catimg'] as String,
      count: map['count'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, catname: $catname, catimg: $catimg, count: $count)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
          other.catname == catname &&
          other.catimg == catimg &&
          other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    catname.hashCode ^
    catimg.hashCode ^
    count.hashCode;
  }
}

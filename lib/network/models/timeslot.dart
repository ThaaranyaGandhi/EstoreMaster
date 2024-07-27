// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeSlot {

  final String mintime;
  final String maxtime;
  TimeSlot({
    required this.mintime,
    required this.maxtime,
  });

  TimeSlot copyWith({
    String? mintime,
    String? maxtime,
  }) {
    return TimeSlot(
      mintime: mintime ?? this.mintime,
      maxtime: maxtime ?? this.maxtime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mintime': mintime,
      'maxtime': maxtime,
    };
  }

  factory TimeSlot.fromMap( map) {
    return TimeSlot(
      mintime: map['mintime'] as String,
      maxtime: map['maxtime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeSlot.fromJson(String source) => TimeSlot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TimeSlot(mintime: $mintime, maxtime: $maxtime)';

  @override
  bool operator ==(covariant TimeSlot other) {
    if (identical(this, other)) return true;
  
    return 
      other.mintime == mintime &&
      other.maxtime == maxtime;
  }

  @override
  int get hashCode => mintime.hashCode ^ maxtime.hashCode;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Absensi {
  final int? id;
  final String status;
  final String checkin;
  final String checkin_loc;
  final String checkout;
  final String checkout_loc;
  Absensi({
    this.id,
    required this.status,
    required this.checkin,
    required this.checkin_loc,
    required this.checkout,
    required this.checkout_loc,
  });

  Absensi copyWith({
    int? id,
    String? status,
    String? checkin,
    String? checkin_loc,
    String? checkout,
    String? checkout_loc,
  }) {
    return Absensi(
      id: id ?? this.id,
      status: status ?? this.status,
      checkin: checkin ?? this.checkin,
      checkin_loc: checkin_loc ?? this.checkin_loc,
      checkout: checkout ?? this.checkout,
      checkout_loc: checkout_loc ?? this.checkout_loc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'checkin': checkin,
      'checkin_loc': checkin_loc,
      'checkout': checkout,
      'checkout_loc': checkout_loc,
    };
  }

  factory Absensi.fromMap(Map<String, dynamic> map) {
    return Absensi(
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] as String,
      checkin: map['checkin'] as String,
      checkin_loc: map['checkin_loc'] as String,
      checkout: map['checkout'] as String,
      checkout_loc: map['checkout_loc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Absensi.fromJson(String source) => Absensi.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Absensi(id: $id, status: $status, checkin: $checkin, checkin_loc: $checkin_loc, checkout: $checkout, checkout_loc: $checkout_loc)';
  }

  @override
  bool operator ==(covariant Absensi other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.status == status &&
      other.checkin == checkin &&
      other.checkin_loc == checkin_loc &&
      other.checkout == checkout &&
      other.checkout_loc == checkout_loc;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      status.hashCode ^
      checkin.hashCode ^
      checkin_loc.hashCode ^
      checkout.hashCode ^
      checkout_loc.hashCode;
  }
}

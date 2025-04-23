// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int? id;
  final String nama;
  final String email;
  final String password;
  User({
    this.id,
    required this.nama,
    required this.email,
    required this.password,
  });

  

  User copyWith({
    int? id,
    String? nama,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, nama: $nama, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nama == nama &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nama.hashCode ^
      email.hashCode ^
      password.hashCode;
  }
}

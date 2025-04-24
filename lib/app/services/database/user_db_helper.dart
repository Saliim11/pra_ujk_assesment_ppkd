import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pra_ujk_assesment_ppkd/app/models/absensi.dart';
import 'package:pra_ujk_assesment_ppkd/app/models/user.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/widgets/dialog.dart';
import 'package:sqflite/sqflite.dart';

class UserDbHelper {
  static Future<Database> openDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'db_pra_ujk.db'),

      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nama TEXT, email TEXT, password TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS absensi(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, status TEXT, checkin TEXT, checkin_loc TEXT, checkout TEXT, checkout_loc TEXT)',
        );
      },
      version: 2
    );
  }

  Future<bool> register(BuildContext context, User user) async {
    final db = await openDB();
      try {

      await db.insert(
        "user",
        {
          "nama": user.nama,
          "email": user.email,
          "password": user.password,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Berhasil Mendaftarkan Akun");
      return true; // Berhasil
    } catch (e) {
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Error saat register akun user: $e");
      return false; // Gagal
    }
  }

  Future<bool> login(BuildContext context, String email, String password) async {
    try {
      final user = await getUserByEmail(email);
      CustomDialog().hide(context);

      if (user == null) {
        CustomDialog().message(context, pesan: "Akun tidak ditemukan");
        return false;
      }

      if (user.password != password) {
        CustomDialog().message(context, pesan: "Password salah");
        return false;
      }

      Navigator.pushReplacementNamed(context, "/main");
      CustomDialog().message(context, pesan: "Berhasil Login, Selamat Datang ${user.nama}");
      return true;
    } catch (e) {
      CustomDialog().message(context, pesan: "Terjadi error saat login: $e");
      return false;
    }
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await openDB();
    final result = await db.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isNotEmpty) {
      final data = result.first;
      return User(
        id: data['id'] as int,
        nama: data['nama'] as String,
        email: data['email'] as String,
        password: data['password'] as String,
      );
    }

    return null; // User tidak ditemukan
  }

  Future<bool> editNama(BuildContext context, int id, String nama) async {
    final db = await openDB();
    try {
      await db.update(
        'user',
        {
          'nama' : nama,
        },
        where: 'id = ?',
        whereArgs: [id],
      );

      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Berhasil update nama menjadi $nama");
      return true;
    } catch (e) {
      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Error saat update nama: $e");
      return false;
    }
  }

  Future<bool> checkin(BuildContext context, Absensi absen) async {
    final db = await openDB();
      try {

      await db.insert(
        "absensi",
        {
          "status": absen.status,
          "checkin": absen.checkin,
          "checkin_loc": absen.checkin_loc,
          "checkout": "-",
          "checkout_loc": "-"
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Berhasil check in pada ${absen.checkin}");
      return true; // Berhasil
    } catch (e) {
      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Error saat checkin: $e");
      return false; // Gagal
    }
  }

  Future<bool> checkout(BuildContext context, int id, String checkoutTime, String checkoutLoc) async {
    final db = await openDB();
    try {
      await db.update(
        'absensi',
        {
          'status' : 'checkout',
          'checkout': checkoutTime,
          'checkout_loc': checkoutLoc,
        },
        where: 'id = ?',
        whereArgs: [id],
      );

      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Berhasil checkout pada $checkoutTime");
      return true;
    } catch (e) {
      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Error saat checkout: $e");
      return false;
    }
  }

  Future<List<Absensi>> getAbsensi() async {
    final db = await openDB();
    final absensi = await db.query("absensi");

    return [
      for (
        final {
          "id": id as int,
          "status": status as String,
          "checkin": checkin as String,
          "checkin_loc": checkin_loc as String,
          "checkout": checkout as String,
          "checkout_loc": checkout_loc as String
        } 
        in absensi)
        Absensi(id: id, status: status, checkin: checkin, checkin_loc: checkin_loc, checkout: checkout, checkout_loc: checkout_loc)
    ];
  }

  Future<void> deleteAbsen(int id) async{
    final db = await openDB();

    db.delete(
      "absensi",
      where: 'id = ?',
      whereArgs: [id]
    );
  }


}
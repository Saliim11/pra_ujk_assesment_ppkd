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

  Future<bool> checkin(BuildContext context, Absensi absen) async {
    final db = await openDB();
      try {

      await db.insert(
        "absensi",
        {
          "status": absen.status,
          "checkin": absen.checkin,
          "checkin_loc": absen.checkin_loc,
          "checkout": absen.checkout,
          "checkout_loc": absen.checkout_loc
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Berhasil check in pada ${absen.checkin}");
      return true; // Berhasil
    } catch (e) {
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "Error saat checkin: $e");
      return false; // Gagal
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

  // Future<void> updatePrio(int id, bool isPrio) async{
  //   final db = await openDB();

  //   db.update(
  //     "investasi", 
  //     {
  //       "isPrio": isPrio? 0 : 1
  //     },
  //     where: 'id = ?',
  //     whereArgs: [id]
  //   );
  // }
  
  // Future<bool> updateInvest(int id, 
  // {
  //   required String nama,
  //   required double nominal,
  //   required bool isInvest,
  //   required String tglMulai,
  //   required String deadline,
  //   required String deskripsi
  // }) async{

  //   final db = await openDB();
  //   try {
  //     db.update(
  //       "investasi", 
  //       {
  //         'nama': nama, 
  //         'nominal': nominal,
  //         'deskripsi': deskripsi,
  //         'tglMulai': tglMulai,
  //         'deadline': deadline,
  //         'isInvest': isInvest ? 1 : 0,
  //       },
  //       where: 'id = ?',
  //       whereArgs: [id]
  //     );
  //     print("Berhasil update data");

  //     return true;
      
  //   } catch (e) {
  //     print("gagal update data : $e");
  //     return false;
  //   }
  // }

  // Future<void> deleteInvestasi(int id) async{
  //   final db = await openDB();

  //   db.delete(
  //     "investasi",
  //     where: 'id = ?',
  //     whereArgs: [id]
  //   );
  // }


}
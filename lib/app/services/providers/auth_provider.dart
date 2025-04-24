import 'package:flutter/material.dart';
import 'package:pra_ujk_assesment_ppkd/app/models/user.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/database/user_db_helper.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/shared_preferences/prefs_handler.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/widgets/dialog.dart';

class AuthProvider with ChangeNotifier{
  UserDbHelper dbUser = UserDbHelper();

  User? _user;

  User get user => _user!;

  Future<void> register(BuildContext context, User user ) async{
    bool result = await dbUser.register(context, user);

    if (result) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> login(BuildContext context, {required String email, required String password}) async{
    await getUser(email);
    notifyListeners();
    try {

      CustomDialog().hide(context);

      if (user.password != password) {
        CustomDialog().message(context, pesan: "Password salah");
        return;
      }

      PrefsHandler.saveid(_user!.email);
      Navigator.pushReplacementNamed(context, "/main");
      CustomDialog().message(context, pesan: "Berhasil Login, Selamat Datang ${user.nama}");
    } catch (e) {
      CustomDialog().message(context, pesan: "Terjadi error saat login: $e");
    }
  }

  Future<void> getUser(String email) async{
    try {
      _user = await dbUser.getUserByEmail(email);
        
    } catch (e) {
      print(e);
    }
  }
}
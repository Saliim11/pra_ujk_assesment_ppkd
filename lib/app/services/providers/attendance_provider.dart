import 'package:flutter/widgets.dart';
import 'package:pra_ujk_assesment_ppkd/app/models/absensi.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/database/user_db_helper.dart';

class AttendanceProvider with ChangeNotifier {
  UserDbHelper db = UserDbHelper();

  List<Absensi> _list = [];

  List<Absensi> get list => _list; 

  Future<void> checkinUser(BuildContext context, Absensi absen) async{
    bool result = await db.checkin(context, absen);

    if (result) {
      getAbsensiUser();
    }
  }

  void getAbsensiUser() async{
    _list = await db.getAbsensi();
    print("isi listnya brooo $_list");
    notifyListeners();
  }

  
}
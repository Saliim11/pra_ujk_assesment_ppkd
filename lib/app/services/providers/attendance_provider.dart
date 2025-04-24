import 'package:flutter/widgets.dart';
import 'package:pra_ujk_assesment_ppkd/app/models/absensi.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/database/user_db_helper.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/widgets/dialog.dart';

class AttendanceProvider with ChangeNotifier {
  UserDbHelper db = UserDbHelper();

  List<Absensi> _list = [];

  List<Absensi> get list => _list;


  void getAbsensiUser() async{
    _list = await db.getAbsensi();
    print("isi listnya brooo $_list");
    notifyListeners();
  }

  Future<void> checkinUser(BuildContext context, Absensi absen) async{
    bool result = await db.checkin(context, absen);

    if (result) {
      getAbsensiUser();
    }
  }

  Future<void> deleteAbsenUser( BuildContext context, int id) async{
    await db.deleteAbsen(id);
    getAbsensiUser();
    CustomDialog().hide(context);
  }

  
}
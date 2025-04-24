import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pra_ujk_assesment_ppkd/app/models/absensi.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/database/user_db_helper.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/widgets/dialog.dart';

class AttendanceProvider with ChangeNotifier {
  UserDbHelper db = UserDbHelper();

  List<Absensi> _list = [];


  List<Absensi> get list => _list;

  bool _checkin = false;

  bool get checkin => _checkin;

  Future<void> getAbsensiUser() async{
    _list = await db.getAbsensi();
    print("isi listnya brooo $_list");
    isSudahCheckInOut();
    notifyListeners();
  }

  Future<void> checkinUser(BuildContext context, Absensi absen) async{
    bool result = await db.checkin(context, absen);

    if (result) {
      getAbsensiUser();
    }
  }

  Future<void> checkoutUser(BuildContext context, int id, String waktu, String lokasi) async{
    bool result = await db.checkout(context, id, waktu, lokasi);

    if (result) {
      getAbsensiUser();
    }
  }

  void isSudahCheckInOut() {
    if (_list.isEmpty || _list == []) {
      _checkin = false;
      return;
    }

    Absensi first = _list.first;

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String today = formatter.format(DateTime.now()); // "24-04-2025"

    // final DateTime checkinDate = DateTime.parse(first.checkin);
    final String checkinOnlyDate = first.checkin.substring(0, 10); // "24-04-2025"
    print("hari ini $today dan list pertama $checkinOnlyDate");

    if (checkinOnlyDate == today) {
      _checkin = true;
    } else {
      _checkin = false;
    }
    
  }

  Future<void> deleteAbsenUser( BuildContext context, int id) async{
    await db.deleteAbsen(id);
    getAbsensiUser();
    CustomDialog().hide(context);
  }

  
}
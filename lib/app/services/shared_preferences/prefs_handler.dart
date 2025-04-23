import 'package:shared_preferences/shared_preferences.dart';

class PrefsHandler {
  static const String _id = "id";

  static void saveid(String id){
    SharedPreferences.getInstance().then((value) {
      value.setString(_id, id);
    });
  }
  static Future getid() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(_id) ?? "";
    return id;
  }

  static void removeid(){
    SharedPreferences.getInstance().then((value) {
      value.remove(_id);
    });
  }
}
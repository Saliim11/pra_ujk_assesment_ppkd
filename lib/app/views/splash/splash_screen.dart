import 'package:flutter/material.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/attendance_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/auth_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/shared_preferences/prefs_handler.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      Future.microtask(() => 
        Provider.of<AttendanceProvider>(context, listen: false).getAbsensiUser()
      );
      String email = await PrefsHandler.getid();
      print("isi id: $email");
      if (email.isEmpty || email == "") {
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        Future.microtask(() => 
        Provider.of<AuthProvider>(context, listen: false).getUser(email)
      );
        Navigator.pushReplacementNamed(context, "/main");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Pra Ujikom", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
      ),
    );
  }
}
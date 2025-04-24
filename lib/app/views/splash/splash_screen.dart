import 'package:flutter/material.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/shared_preferences/prefs_handler.dart';

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
      String id = await PrefsHandler.getid();
      print("isi id: $id");
      if (id.isEmpty || id == "") {
        Navigator.pushReplacementNamed(context, "/login");
      } else {
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
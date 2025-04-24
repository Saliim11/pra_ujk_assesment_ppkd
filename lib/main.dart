import 'package:flutter/material.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/attendance_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/auth_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/location_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/profile_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/widget_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/views/auth/login/login_page.dart';
import 'package:pra_ujk_assesment_ppkd/app/views/auth/register/register_page.dart';
import 'package:pra_ujk_assesment_ppkd/app/views/main/main_page.dart';
import 'package:pra_ujk_assesment_ppkd/app/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider(),),
      ChangeNotifierProvider(create: (context) => AttendanceProvider(),),
      ChangeNotifierProvider(create: (context) => ProfileProvider(),),
      ChangeNotifierProvider(create: (context) => WidgetProvider(),),
      ChangeNotifierProvider(create: (context) => LocationProvider(),),
    ],
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      
      initialRoute: "/",
      routes: {
        "/" : (context) => SplashScreen(),
        "/login" : (context) => LoginPage(),
        "/register" : (context) => RegisterPage(),
        "/main" : (context) => MainPage(),
      },
    );
  }
}


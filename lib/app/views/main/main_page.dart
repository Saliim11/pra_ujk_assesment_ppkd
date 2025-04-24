import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pra_ujk_assesment_ppkd/app/models/absensi.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/attendance_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/auth_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/location_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/profile_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/colors/app_colors.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/styles/app_btn_style.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/widgets/dialog.dart';
import 'package:pra_ujk_assesment_ppkd/app/views/main/widgets/list_absensi.dart';
import 'package:pra_ujk_assesment_ppkd/app/views/main/widgets/profile_sheet.dart';
import 'package:pra_ujk_assesment_ppkd/app/views/main/widgets/tanggal_waktu.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async {
      await Provider.of<AttendanceProvider>(context, listen: false).getAbsensiUser();

    }
      );
  }
  @override
  Widget build(BuildContext context) {
    final profileProv = Provider.of<ProfileProvider>(context);
    final authProv = Provider.of<AuthProvider>(context);
    final locProv = Provider.of<LocationProvider>(context);
    final attendProv = Provider.of<AttendanceProvider>(context);

    final user = authProv.user;

    // final listAbsen = attendProv.list;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text("Hai, ${user.nama}", style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primary,
        actions: [
          GestureDetector(
            onTap: () {
              showProfileSheet(
                context, 
                profileProv,
                authProv,
                user: user);
            },
            child: CircleAvatar(
              backgroundColor: AppColors.background,
              child: Icon(Icons.person, color: AppColors.primary,),
            ),
          ),
        SizedBox(width: 20,)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showTanggalWaktu(context),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 16, left: 12, right: 12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              ),
              child: Column(
                children: [
                  Expanded(child: buildListAbsensi(attendProv.list, attendProv)),
                ],
              )
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          CustomDialog().loading(context);
          await locProv.ambilLokasi();
          
          CustomDialog().hide(context);

          final lokasi = locProv.lokasi;
          final formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
          final waktu = formatter.format(DateTime.now());

          final sudahCheckin = attendProv.checkin;
          final sudahCheckOut = attendProv.checkout;

          showModalBottomSheet(
            context: context, 
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: sudahCheckin ?
                            () {
                              showDialog(
                                context: context, 
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Check out Kantor"),
                                    content: Text("Lokasi anda: $lokasi"),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [           
                                      ElevatedButton(
                                        onPressed: () async{
                                          final firstId = attendProv.list.first.id;
                                          CustomDialog().loading(context);
                                          await attendProv.checkoutUser(context, firstId!, waktu, lokasi);
                                        }, 
                                        style: AppBtnStyle.merah,
                                        child: Text("Check out")
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            : null,
                            icon: const Icon(Icons.logout, color: Colors.white),
                            label: const Text("Check-out"),
                            style: AppBtnStyle.merah
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: !sudahCheckin ?
                            () {
                              showDialog(
                                context: context, 
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Check in Kantor"),
                                    content: Text("Lokasi anda: $lokasi"),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [  
                                      ElevatedButton(
                                        onPressed: () async{
                                          CustomDialog().loading(context);
                                          await attendProv.checkinUser(context, Absensi(status: "checkin", checkin: waktu, checkin_loc: lokasi, checkout: "-", checkout_loc: "-"));
                                        }, 
                                        style: AppBtnStyle.hijau,
                                        child: Text("Check in")
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            : null,
                            icon: const Icon(Icons.login, color: Colors.white),
                            label: const Text("Check-In"),
                            style: AppBtnStyle.hijau
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.event_available_outlined, color: Colors.white,),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
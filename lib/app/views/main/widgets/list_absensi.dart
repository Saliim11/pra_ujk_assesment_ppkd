import 'package:flutter/material.dart';
import 'package:pra_ujk_assesment_ppkd/app/models/absensi.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/attendance_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/colors/app_colors.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/widgets/dialog.dart';

Widget buildListAbsensi(List<Absensi> absensi, AttendanceProvider provider) {
  return absensi == [] 
  ? Center(child: Text("Anda belum pernah melakukan absen"),)
  : ListView.builder(
    itemCount: absensi.length,
    itemBuilder: (context, index) {
      final absen = absensi[index];
      
      final ischeckin = absen.status == "checkin";

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Check in pada",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(absen.checkin,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ischeckin ? AppColors.success.withOpacity(0.1) : AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    absen.status,
                    style: TextStyle(color: ischeckin ? AppColors.success : AppColors.warning, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lokasi Check-in:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      absen.checkin_loc,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),

                    
                    SizedBox(height: 20),
                    Text(
                      'Waktu Check-out:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      absen.checkout,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      'Alamat Check-out:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      absen.checkout_loc,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    
                    
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () async{
                          CustomDialog().loading(context);
                          await provider.deleteAbsenUser(context, absen.id!);
                        }, 
                        icon: Icon(Icons.delete, color: AppColors.warning,)
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
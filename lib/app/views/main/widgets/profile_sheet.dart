import 'package:flutter/material.dart';
import 'package:pra_ujk_assesment_ppkd/app/models/user.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/auth_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/profile_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/shared_preferences/prefs_handler.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/colors/app_colors.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/styles/app_btn_style.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/widgets/dialog.dart';

void showProfileSheet(BuildContext context, ProfileProvider prov, AuthProvider authProv, {
  required User user,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Profile Sheet',
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.topCenter,
        child: Material(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          color: AppColors.card,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            // margin: EdgeInsets.only(top: 20), // jarak dari atas
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("My Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.textPrimary))),
                SizedBox(height: 10),
                Text("Nama", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(user.nama, style: TextStyle(color: AppColors.textSecondary)),
                SizedBox(height: 10),

                Text("Email", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(user.email, style: TextStyle(color: AppColors.textSecondary)),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final _nameController = TextEditingController(text: user.nama);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: AppColors.card,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                title: Text(
                                  "Edit Nama",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                content: TextField(
                                  controller: _nameController,
                                  cursorColor: AppColors.primary,
                                  style: TextStyle(color: AppColors.textPrimary),
                                  decoration: InputDecoration(
                                    labelText: "Nama Baru",
                                    labelStyle: TextStyle(color: AppColors.textSecondary),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.border),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Batal", style: TextStyle(color: AppColors.textSecondary)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async{
                                      final newName = _nameController.text.trim();
                                      if (newName.isNotEmpty && newName != user.nama) {
                                        CustomDialog().loading(context);
                                        await authProv.editNama(context, user.id!, newName, user.email);
                                      }
                                    },
                                    style: AppBtnStyle.normalS,
                                    child: Text("Simpan"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: AppBtnStyle.biru,
                        icon: Icon(Icons.edit, color: Colors.white,),
                        label: Text("Edit"),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          PrefsHandler.removeid();
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                        style: AppBtnStyle.merah,
                        icon: Icon(Icons.logout, color: Colors.white,),
                        label: Text("Logout"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 300),
  );
}
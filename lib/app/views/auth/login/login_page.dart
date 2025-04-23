import 'package:flutter/material.dart';
import 'package:pra_ujk_assesment_ppkd/app/services/providers/auth_provider.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/colors/app_colors.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/styles/app_btn_style.dart';
import 'package:pra_ujk_assesment_ppkd/app/utils/widgets/dialog.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);

    TextEditingController _emailC = TextEditingController();
    TextEditingController _passwordC = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // // Logo
              // SizedBox(
              //   height: 200,
              //   width: 200,
              //   child: Image.asset("assets/images/logo2_teks.png")),

              // Email
              TextField(
                controller: _emailC,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              TextField(
                controller: _passwordC,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 8),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa Password?',
                    style: TextStyle(color: AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Tombol Login
              ElevatedButton(
                onPressed: () async{
                  CustomDialog().loading(context);
                  await authProv.login(context, email: _emailC.text, password: _passwordC.text);
                },
                style: AppBtnStyle.normal,
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('atau'),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),

              // Button ke Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun?", style: TextStyle(color: AppColors.textSecondary)),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, "/register"), 
                    child: Text("Daftar Sekarang", style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold))
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
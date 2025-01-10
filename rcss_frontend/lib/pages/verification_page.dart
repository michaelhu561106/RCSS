import 'package:flutter/material.dart';
import 'package:rcss_frontend/auth_implemetation/auth_service.dart';
import 'package:rcss_frontend/pages/login_page.dart';
import 'package:rcss_frontend/pages/return_verify_page.dart';

import '../widgets/text_field_widget.dart';

class VerificationPage extends StatelessWidget {
  final String email;
  final String password;
  final String phone;
  final String phoneCountry;
  final String countryId;

  VerificationPage({
    super.key,
    required String this.email,
    required String this.password,
    required String this.phone,
    required String this.phoneCountry,
    required String this.countryId,
  });

  final AuthService authService = AuthService();

  final TextEditingController verificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('信箱驗證'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "驗證碼",
              style: TextStyle(
                  color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            TextFieldWidget(
                controller: verificationController,
                hintText: "驗證碼",
                obscureText: false),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () => _verify(context),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "驗證",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () => _returnVerify(context, email),
              child: Container(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '無法成功認證？',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        '改用回傳驗證碼認證！',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verify(BuildContext context) async {
    String code = verificationController.text;
    Map<String, dynamic> response = await authService.verifyRegistration(
        email: email,
        code: code,
        password: password,
        userName: email.split('@')[0],
        phone: phone,
        phoneCountry: phoneCountry,
        countryId: countryId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void _returnVerify(BuildContext context, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReturnVerifyPage(),
      ),
    );
  }
}

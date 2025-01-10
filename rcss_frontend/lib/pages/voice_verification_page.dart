import 'package:flutter/material.dart';
import 'package:rcss_frontend/auth_implemetation/auth_service.dart';
import 'package:rcss_frontend/pages/login_page.dart';
import '../widgets/text_field_widget.dart';

class VoiceVerificationPage extends StatelessWidget {
  final String email;
  final String password;
  final String phone;
  final String phoneCountry;
  final String countryId;

  VoiceVerificationPage({
    super.key,
    required String this.email,
    required String this.password,
    required String this.phone,
    required String this.phoneCountry,
    required String this.countryId,
  });

  final AuthService authService = AuthService();

  final TextEditingController verificationController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('語音接收驗證碼驗證'),
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
            SizedBox(height: 12),
            TextField(
                controller: messageController,
                style: TextStyle(color: Colors.red,fontSize: 28),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '',
                )
            )
          ],
        ),
      ),
    );
  }

  void _verify(BuildContext context) async {
    Map<String, dynamic> response =
      await authService
        .verifyRegistrationByVoice(
        email: email,
        code: verificationController.text,
        password: password,
        userName: email.split('@')[0],
        phone: phone,
        phoneCountry: phoneCountry,
        countryId: countryId);
    if(response['code'] == 0) {
      messageController.text="驗證(註冊)成功，將導向登入頁";
      await Future.delayed(Duration(seconds: 2));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
    messageController.text="驗證(註冊)失敗，請重新註冊...";
    await Future.delayed(Duration(seconds: 10));
    messageController.text="";
  }
}

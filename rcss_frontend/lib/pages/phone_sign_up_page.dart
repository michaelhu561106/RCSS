import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rcss_frontend/auth_implemetation/auth_service.dart';
import 'package:rcss_frontend/pages/phone_verification_page.dart';
import 'package:rcss_frontend/pages/sign_up_page.dart';
import 'package:rcss_frontend/widgets/text_field_widget.dart';

import 'login_page.dart';
import 'message_sign_up_page.dart';
import 'voice_sign_up_page.dart';

class PhoneSignUpPage extends StatefulWidget {
  PhoneSignUpPage({super.key});

  @override
  State<PhoneSignUpPage> createState() => _PhoneSignUpPageState();
}

class _PhoneSignUpPageState extends State<PhoneSignUpPage> {
  final AuthService _authService = AuthService();

  String countryId = '';
  String phoneCountry = '';

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("歡迎加入註冊寶"),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "手機註冊",
            style: TextStyle(
                color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 32),
          IntlPhoneField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: "Phone Number",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.red, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.red, width: 3),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onCountryChanged: (country) {
              setState(() {
                phoneCountry = country.dialCode;
                countryId = country.code;
              });
            },
          ),
          SizedBox(height: 12),
          TextFieldWidget(
            controller: emailController,
            hintText: "Email",
            obscureText: false,
          ),
          SizedBox(height: 12),
          TextFieldWidget(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
          ),
          SizedBox(height: 32),
          GestureDetector(
            onTap: () => _signUp(context),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "註冊",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "已註冊?",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text("立即登入!",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
                child: Text("改用信箱註冊",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageSignUpPage(),
                    ),
                  );
                },
                child: Text("手機未收到驗證碼-手機傳回驗證碼",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VoiceSignUpPage(),
                    ),
                  );
                },
                child: Text("手機未收到驗證碼-語音電話接收驗證碼",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signUp(BuildContext context) {
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;

    _authService.getVerificationCodeByPhone(phone: phoneCountry + phone);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhoneVerificationPage(
          email: email,
          password: password,
          phone: phone,
          phoneCountry: phoneCountry,
          countryId: countryId
        ),
      ),
    );
  }
}